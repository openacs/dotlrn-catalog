ad_page_contract {
    Displays the information of one course
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   08-01-2005
} {

}

set dotlrn_url [dotlrn::get_url]
if { ![info exists index] } {
    set index ""
}

if { ![info exists to_index] } {
    set to_index ""
}

if { [info exist return_url] } {
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

set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]
set tree_id [db_string get_tree_id { } -default "-1"]

# Get the category name
set category_name "[category::get_name [category::get_mapped_categories $course_id]]"

# Check if user has admin permission over course_id
if { [permission::permission_p -object_id $cc_package_id -privilege "create"] } { 
    set item_id [dotlrn_catalog::get_item_id -revision_id $course_id]
    set admin_p [permission::permission_p -object_id $item_id -privilege "admin"]
} else {
    set admin_p 0
}

set obj_n 0
set dotlrn_class "("
set dotlrn_com "("

# For dotlrn associations
db_multirow -extend { obj_n admin_p } relations relation { } {
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

db_multirow classes_list get_dotlrn_classes { }

template::list::create \
    -name dotlrn_classes \
    -multirow classes_list \
    -key object_id \
    -row_pretty_plural "[_ dotlrn-catalog.dotlrn_classes]" \
    -elements {
        class  {
            label "[_ dotlrn-catalog.class_name]"
            display_template {
                <a href="dotlrn-info?object_id=@classes_list.object_id@&type=class&course_id=$course_id&course_name=$name&course_key=$course_key">@classes_list.pretty_name@</a>
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
    }


db_multirow com_list get_dotlrn_communities { }


template::list::create \
    -name dotlrn_communities \
    -multirow com_list \
    -key object_id \
    -row_pretty_plural "[_ dotlrn-catalog.dotlrn_com]" \
    -elements {
        community  {
            label "[_ dotlrn-catalog.com_name]"
            display_template {
                <a href="dotlrn-info?object_id=@com_list.object_id@&type=community&course_id=$course_id&course_name=$name&course_key=$course_key">@com_list.pretty_name@</a>
            }
        }
    }
