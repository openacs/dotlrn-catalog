ad_page_contract {
    Displays a form to add a course or add a new revision of a course (edit)

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   27-01-2005

} {
    course_id:optional
    mode:optional
    { return_url "" }
    { index "" }
}

if { [string equal $return_url ""] } {
    set return_url "course-list"
} else { 
    set return_url $return_url 
}

set page_title ""
set context ""

set user_id [ad_conn user_id]
set cc_package_id [ad_conn package_id]


# Check for create permissions over dotlrn-catalog package
permission::require_permission -party_id $user_id -object_id $cc_package_id -privilege "create"

if { [info exist mode] } {
    if { [string equal $mode 1] } {
	permission::require_permission -object_id $course_id -privilege "admin"
    } 
    set mode_p edit
} else {
    set mode_p edit
}

# Get assessments
set asm_list [list [list "[_ dotlrn-catalog.not_associate]" "-1"]]
db_foreach assessment { } {
    if { [permission::permission_p -object_id $assessment_id -privilege "admin"] == 1 } {
	lappend asm_list [list $title $assessment_id] 
    }
}

# Get a list of all the attributes asociated to dotlrn_catalog
set attribute_list [package_object_attribute_list -start_with dotlrn_catalog dotlrn_catalog]
set elements ""
set i 0

# Creates the elements to show with ad_form
foreach attribute $attribute_list {


    set element_mode ""
    set aditional_type ""
    set aditional_elements_2 ""
    set aditional_elements ""
    switch [lindex $attribute 4] {
	string {
	    if { [string equal [lindex $attribute 2] "assessment_id"]} {
                set aditional_type "(select)"
                set aditional_elements [list options $asm_list]
            } else {
                if { [string equal [lindex $attribute 2] "course_key"]} {
                    set element_mode [list mode $mode_p]
                }
            }
	}
	text {
	    set aditional_type "(textarea)"
	    set aditional_elements "{html  {rows 7 cols 35}}"
	}
	integer {
	    if { [string equal [lindex $attribute 2] "assessment_id"]} {
		set aditional_type "(select)"
		set aditional_elements [list options $asm_list]
	    }
	}
	boolean {
        # DRB: this is broken.  You can't have a checkbox without an options list.
        #
        # If Solution Grove folks want a nice boolean checkbox they need to
        # 1. Make it work by provide the option list
        # 2. Do it for ALL boolean attributes, not just active_p
        #
	#    if { [string equal [lindex $attribute 2] "active_p"]} {
	#	set aditional_type "(checkbox)"
	#    }
	}
	date {
	    if { [string equal [lindex $attribute 2] "start_date"] } {
		set aditional_type "(text),optional"
		set aditional_elements {html { id sel1}} 
		set aditional_elements_2  {after_html  {<input type='reset' value=' ... ' onclick=\"return showCalendar('sel1', 'y-m-d');\"> \[<b>y-m-d</b>\] }}
	    }
	    if { [string equal [lindex $attribute 2] "end_date"] } {
		set aditional_type "(text),optional"
		set aditional_elements {html { id sel2}} 
		set aditional_elements_2  {after_html  {<input type='reset' value=' ... ' onclick=\"return showCalendar('sel2', 'y-m-d');\"> \[<b>y-m-d</b>\] }}
	    }
	}
    }
    set element [list [lindex $attribute 2]:text${aditional_type} [list label [lindex $attribute 3]] $aditional_elements $aditional_elements_2 $element_mode]
    lappend elements $element
}

# Create the form
ad_form -name add_course -export {mode $mode} -form {
    course_id:key
    {return_url:text(hidden)}
}


ad_form -extend -name add_course -form $elements

ad_form -extend -name add_course -form {
    {category_ids:integer(multiselect),multiple,optional
	{label "[_ dotlrn-catalog.categories]"}
	{html {size 4}}
	{options [dotlrn_catalog::get_categories_widget]}
	{value "-1"}
    }
}

ad_form -extend -name add_course -new_data {
    
    # New item and revision in the CR
    set folder_id [dotlrn_catalog::get_folder_id]
    set attribute_list [package_object_attribute_list -start_with dotlrn_catalog dotlrn_catalog]
    set form_attributes [list]
    
    foreach attribute $attribute_list {
	set attr_name [lindex $attribute 2]
	lappend form_attributes [list $attr_name [set $attr_name]]
    }
    
    if { [dotlrn_catalog::check_name -name $course_key] } {
	set item_id [content::item::new -name $course_key -parent_id $folder_id \
			 -content_type "dotlrn_catalog" -creation_user $user_id \
			 -attributes $form_attributes -is_live t -title $course_key]
    } else {
	ad_return_complaint 1 "\#dotlrn-catalog.name_already\#"
	ad_script_abort
    }
    # Grant admin privileges to the user over the item in the CR
    permission::grant -party_id $user_id -object_id $item_id  -privilege "admin"
    
    set revision_id [db_string get_revision_id { } -default "-1"]
    if { ![string equal $category_ids "-1"] } {
	category::map_object -object_id $revision_id $category_ids
    }
} -edit_data {
    # New revision in the CR
    set folder_id [dotlrn_catalog::get_folder_id]
    set item_id [dotlrn_catalog::get_item_id -revision_id $course_id]
    set attribute_list [package_object_attribute_list -start_with dotlrn_catalog dotlrn_catalog]
    set form_attributes [list]
    foreach attribute $attribute_list {
	set attr_name [lindex $attribute 2]
	lappend form_attributes [list $attr_name [set $attr_name]]
    }
    
    set course_id [content::revision::new -item_id $item_id -attributes $form_attributes -content_type "dotlrn_catalog"]
    
    # Set the new revision live  
    dotlrn_catalog::set_live -revision_id $course_id
    if { ![string equal $category_ids "-1"] } {
	category::map_object -object_id $course_id $category_ids
    }
    
    if { [string equal $return_url "course-list"] } {
        set return_url "$return_url"
    } else {
        set return_url "$return_url?course_id=$course_id&course_name=$course_name&course_key=$course_key&index=$index"
    }

} -new_request {
    set context [list [list course-list "[_ dotlrn-catalog.course_list]"] "[_ dotlrn-catalog.new_course]"]
    set page_title "[_ dotlrn-catalog.new_course]"
    
} -edit_request {
    set context [list [list course-list "[_ dotlrn-catalog.course_list]"] "[_ dotlrn-catalog.edit_course]"]
    set page_title "[_ dotlrn-catalog.edit_course]"
    db_1row get_course_info { }
    db_string get_course_assessment { } -default "[_ dotlrn-catalog.not_associated]"
    set category_ids [category::get_mapped_categories $course_id]
} -after_submit {
    ad_returnredirect "$return_url"
}









