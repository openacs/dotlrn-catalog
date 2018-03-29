ad_page_contract {
    Displays the information of one course
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   08-01-2005
} {
    {enroll_p "1"}
}

db_0or1row get_course_dates { }
set referer "[ad_conn url]?course_id=$course_id"
if {[exists_and_not_null start_date] && [exists_and_not_null end_date]} {
    set enroll_p  [dotlrn_catalog::get_enroll_p  -start_date $start_date -end_date $end_date]
} 

set dotlrn_url [dotlrn::get_url]
if { ![info exists index] } {
    set index ""
}

if { ![info exists to_index] } {
    set to_index ""
}

if { [info exists return_url] } {
    set return_url $return_url
} else {
    set return_url "course-info?course_id=$course_id&course_name=$name&course_key=$course_key"
}

if { ![info exists asmid] } {
    set asmid "-1"
}

if { ![info exists revision] } {
    set revision "no"
}

set category_p [db_string get_category { } -default -1]

set info [ad_html_text_convert -from text/enhanced -to text/plain $info]
set reg_asm_id  [parameter::get -parameter RegistrationId -package_id [subsite::main_site_id]]
set cc_package_id [ad_conn package_id]
set tree_id [db_string get_tree_id { } -default "-1"]

# Get the category name
set category_name "[category::get_name [category::get_mapped_categories $course_id]]"

# Check if user has admin permission over course_id
set admin_p 0
if { [permission::permission_p -object_id $cc_package_id -privilege "create"] } { 
    set item_id [dotlrn_catalog::get_item_id -revision_id $course_id]
    if { [permission::permission_p -object_id $course_id -privilege "admin"] } { 
	set admin_p 1
    }
}

if { [acs_user::site_wide_admin_p] } {
    set admin_p 1
}

set obj_n 0
set dotlrn_class "("
set dotlrn_com "("

# For dotlrn associations
db_multirow -extend { obj_n } relations relation { } {
    set obj_n 1
    if { [string equal $type "dotlrn_catalog_class_rel" ]} {
	append dotlrn_class "'$object_id'"
	append dotlrn_class ","
    } else {
	append dotlrn_com "'$object_id'"
	append dotlrn_com ","
    }
}
append dotlrn_class "0)"
append dotlrn_com "0)"

db_multirow -extend { join } classes_list get_dotlrn_classes { } { 
    if {![dotlrn_community::member_p $object_id [ad_conn user_id]]} {
	if { $asmid == -1 } {
	    if {[dotlrn_community::member_pending_p -community_id $object_id -user_id [ad_conn user_id]]} {
		set join "\[<small> \#dotlrn.Pending_Approval\# </small>\]"
	    } elseif {![dotlrn_community::not_closed_p -community_id $object_id]} {
		set join ""
	    } elseif {[dotlrn_community::needs_approval_p -community_id $object_id]} {
		set label "Request Membership"
		set join "<a href=/dotlrn/register?community_id=$object_id&referer=$referer>\#dotlrn-catalog.request_membership_link\#</a>"	    
	    } else {
		set join "<a href=/dotlrn/register?community_id=$object_id&referer=$referer>#dotlrn.join_link#</a>" 
	    }  
	}
    } else {
	set join "\[<small>[_ dotlrn-catalog.member_p] </small>\]"
    } 
}

set elements {
    class  {
	label "[_ dotlrn-catalog.class_name]"
	display_template {
	    <if $index not eq "">
	    <a href="dotlrn-info?object_id=@classes_list.object_id@&type=class&course_id=$course_id&course_name=$name&course_key=$course_key">@classes_list.pretty_name@</a> 
	    </if> 
	    <else>
	    <a href="../dotlrn-info?object_id=@classes_list.object_id@&type=class&course_id=$course_id&course_name=$name&course_key=$course_key">@classes_list.pretty_name@</a> 
	    </else>
	}
    }
    dep_name {
	label "[_ dotlrn-catalog.dep_name]"
	display_template {
	    @classes_list.department_name@
	}
    }
    term_name  {
	label "[_ dotlrn-catalog.term_name]"
	display_template {
	    @classes_list.term_name@
	}
    } 
    subject  {
	label "[_ dotlrn-catalog.subject_name]"
	display_template {
	    @classes_list.class_name@
	}
    }
    join  {
	display_template {
	    @classes_list.join;noquote@
	}
    }
}



template::list::create \
    -name dotlrn_classes \
    -multirow classes_list \
    -key object_id \
    -row_pretty_plural "[_ dotlrn-catalog.dotlrn_classes]" \
    -elements $elements

set elements {        
    community  {
	label "[_ dotlrn-catalog.com_name]"
	display_template {
	    <if $index not eq "">
	    <a href="dotlrn-info?object_id=@com_list.object_id@&type=community&course_id=$course_id&course_name=$name&course_key=$course_key">@com_list.pretty_name@</a>
	    </if>
	    <else>
	    <a href="../dotlrn-info?object_id=@com_list.object_id@&type=community&course_id=$course_id&course_name=$name&course_key=$course_key">@com_list.pretty_name@</a>
	    </else>
	}
    }
    join  {
	display_template {
	    @com_list.join;noquote@
	}
    }
}


db_multirow -extend {join} com_list  get_dotlrn_communities {} { 
    if {![dotlrn_community::member_p $object_id [ad_conn user_id]]} {
	if { $asmid == -1 } {
	    if {[dotlrn_community::member_pending_p -community_id $object_id -user_id [ad_conn user_id]]} {
		set join "\[<small> \#dotlrn.Pending_Approval\# </small>\]"
	    } elseif {![dotlrn_community::not_closed_p -community_id $object_id]} {
		set join ""
	    } elseif {[dotlrn_community::needs_approval_p -community_id $object_id]} {
		set label "Request Membership"
		set join "<a href=/dotlrn/register?community_id=$object_id&referer=$referer>\#dotlrn-catalog.request_membership_link\#</a>"	    
	    } else {
		set join "<a href=/dotlrn/register?community_id=$object_id&referer=$referer>#dotlrn.join_link#</a>" 
	    }  
	}
    } else {
	set join "\[<small>[_ dotlrn-catalog.member_p] </small>\]"
    } 
}



template::list::create \
    -name dotlrn_communities \
    -multirow com_list \
    -key object_id \
    -row_pretty_plural "[_ dotlrn-catalog.dotlrn_com]" \
    -elements $elements 

#Send the registration assessment_id

set ret_chunck "../assessment/assessment?assessment_id=$asmid"

if { ![string eq $reg_asm_id 0] } {

    if { [ad_conn user_id] == 0} {
	set ret_chunck "../assessment/assessment?assessment_id=$reg_asm_id&next_asm=$asmid"
    }
} 















