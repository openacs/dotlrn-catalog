ad_page_contract {
    Displays a list of all dotlrn classes to associate to a dotlrn_catalog(course_id)

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   31-01-2005
} {
    course_id:notnull
    { course_key ""}
    { return_url "" }
    { course_name ""}
}

set page_title "[_ dotlrn-catalog.dotlrn_list]"
if {[string equal $return_url ""]} {
    set return_url "dotlrn-catalog-list"
}
set user_id [ad_conn user_id]

# Check if users has admin permission to edit dotlrn_catalog
permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"

set context [list [list course-list  "[_ dotlrn-catalog.course_list]"] "[_ dotlrn-catalog.dotlrn_list]"]

set asm_package_id [apm_package_id_from_key assessment]

db_multirow -extend { rel type } classes_list get_dotlrn_classes {} {
    set rel [dotlrn_catalog::relation_between -object_one $course_id -object_two $object_id]
    set type "class"
}

template::list::create \
    -name dotlrn_classes \
    -multirow classes_list \
    -key object_id \
    -has_checkboxes\
    -bulk_actions {"\#dotlrn-catalog.associate\#" "associate-course" "\#dotlrn-catalog.associate_to_class\#" }\
    -bulk_action_method post \
    -bulk_action_export_vars {
	course_id
	type
    }\
    -row_pretty_plural "[_ dotlrn-catalog.dotlrn_classes]" \
    -elements {
	check_box {
	    class "list-narrow"
	    label "<input type=\"checkbox\" name=\"_dummy\" onclick=\"acs_ListCheckAll('dotlrn_classes', this.checked)\" \
                   title=\"\#dotlrn-catalog.label_title\#\">"
	    display_template {
		<if @classes_list.rel@ eq 0>
		    <input type="checkbox" name="object_id" value="@classes_list.object_id@" \
		    id="dotlrn_classes,@classes_list.object_id@" \
		    title="\#dotlrn-catalog.title\#">
		</if>
		<else>
		    <input type="checkbox" checked disabled>
		</else>
	    }
	}
	class  {
	    label "[_ dotlrn-catalog.class_name]"
	    display_template {
		<a href="@classes_list.url@">@classes_list.pretty_name@</a> 
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
	associate {
	    display_template {
		<if @classes_list.rel@ not eq 0>
		    #dotlrn-catalog.associated#
		</if>
	    }
	}
    }

db_multirow -extend { rel type } com_list get_dotlrn_communities { } {
    set rel [dotlrn_catalog::relation_between -object_one $course_id -object_two $object_id]
    set type "community"
}

template::list::create \
    -name dotlrn_communities \
    -multirow com_list \
    -key object_id \
    -has_checkboxes \
    -bulk_actions {"\#dotlrn-catalog.associate\#" "associate-course" "\#dotlrn-catalog.associate_to_com\#" }\
    -bulk_action_method post \
    -bulk_action_export_vars {
	course_id
	type
    }\
    -row_pretty_plural "[_ dotlrn-catalog.dotlrn_com]" \
    -elements {
	check_box {
	    class "list-narrow"
	    label "<input type=\"checkbox\" name=\"_dummy\" onclick=\"acs_ListCheckAll('dotlrn_communities', this.checked)\"                  title=\"\#dotlrn-catalog.lable_title\#\">"
	    display_template {
		<if @com_list.rel@ eq 0>
		    <input type="checkbox" name="object_id" value="@com_list.object_id@" \
		    id="dotlrn_communities,@com_list.object_id@" \
		    title="\#dotlrn-catalog.title\#">
		</if>
		<else>
		    <input type="checkbox" checked disabled>
		</else>
	    }
	}
	community  {
	    label "[_ dotlrn-catalog.com_name]"
	    display_template {
		<a href="@com_list.url@">@com_list.pretty_name@</a>
	    }
	}
	associate {
	    display_template {
		<if @com_list.rel@ not eq 0>
		#dotlrn-catalog.associated#
		</if>
	    }
	}
    }
