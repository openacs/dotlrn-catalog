ad_page_contract {
    Displays a list of all courses
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   28-01-2005
} {
    page:optional
    keyword:optional
}


set return_url [ad_return_url]
set user_id [ad_conn user_id]
set context [list "[_ dotlrn-catalog.course_list]"]
set page_title "[_ dotlrn-catalog.course_list]"

set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]


permission::require_permission -party_id $user_id -object_id $cc_package_id -privilege "create"

if {[permission::permission_p -party_id $user_id -object_id $cc_package_id -privilege "admin"]} {
    set admin_p 1
} else {
    set admin_p 0
}

# The tree id from categories
set tree_list [category_tree::get_mapped_trees $cc_package_id]
if { [string equal [lindex [lindex $tree_list 0] 1] "dotlrn-course-catalog"] } {
    set tree_id [lindex [lindex $tree_list 0] 0]
} else {
    set tree_id ""
}

if { [acs_user::site_wide_admin_p] } {
    if { [info exist keyword] } {
	set query get_course_info_site_wide_keyword
	set paginator_query site_wide_paginator_keyword
    } else {
	set query get_course_info_site_wide
	set paginator_query site_wide_paginator
    }
} else {
    if { [info exist keyword] } {
	set query get_course_info_keyword
	set paginator_query site_wide_paginator_keyword
    } else {
	set query get_course_info
	set paginator_query paginator
    }
}

template::list::create \
    -name course_list \
    -multirow course_list \
    -key course_id \
    -page_groupsize 5 \
    -page_flush_p t \
    -page_query_name $query \
    -bulk_action_method post \
    -bulk_action_export_vars {
    }\
    -row_pretty_plural "[_ dotlrn-catalog.courses]" \
    -elements {
	key {
	    label "[_ dotlrn-catalog.course_key]"
	    display_template {
		<div align=left>
		<a href=course-add-edit?course_id=@course_list.course_id@&return_url=$return_url&mode=1 \
		    title="[_ dotlrn-catalog.new_ver]">\
		        <img border=0 src=/resources/Edit16.gif></a>
		<a href="revision-list?course_key=@course_list.course_key@&return_url=$return_url&course_id=@course_list.course_id@" title="[_ dotlrn-catalog.see_all_rev]">@course_list.course_key@</a>
		</div>
	    }
	}
	name  {
	    label "[_ dotlrn-catalog.course_name]"
	    display_template {
		<div align=left>
		<a href="course-info?course_id=@course_list.course_id@&course_name=@course_list.course_name@&course_key=@course_list.course_key@">@course_list.course_name@</a>
		</div>
	    }
	}
	assessment_id  {
	    label "[_ dotlrn-catalog.asm]:"
	    display_template {
		@course_list.asm_name@
	    }
	}
	dotlrn {
	    label "[_ dotlrn-catalog.dotlrn]"
	    display_template {
		<if @course_list.rel@ eq 0>
		#dotlrn-catalog.no# (<a href="dotlrn-list?course_id=@course_list.course_id@&course_key=@course_list.course_key@&return_url=$return_url&course_name=@course_list.course_name@" title="\#dotlrn-catalog.associate_this\#"><i>#dotlrn-catalog.associate#</i></a>)
		</if>
		<else>
		#dotlrn-catalog.yes# (<a href="course-details?course_id=@course_list.course_id@&course_key=@course_list.course_key@&return_url=$return_url&course_name=@course_list.course_name@" title="\#dotlrn-catalog.course_details#"><i>#dotlrn-catalog.watch#</i></a>)
		</else>
	    }
	}
	category {
	    label "[_ dotlrn-catalog.category]"
	    display_template {
		<div align=center>
		<if @course_list.category_name@ not eq "">
		    @course_list.category_name@
		</if>
		<else>
		   #dotlrn-catalog.uncat#
		</else>
		</div>
	    }
	}
	permissions {
	    label "[_ dotlrn-catalog.permission]"
	    display_template {
		<a href="grant-user-list?object_id=@course_list.item_id@&creation_user=@course_list.creation_user@&course_key=@course_list.course_key@">\#dotlrn-catalog.manage_per\#</a>
	    }
	}
	delete {
	    display_template {
		<a href="course-delete?object_id=@course_list.item_id@&creation_user=@course_list.creation_user@&course_key=@course_list.course_key@" title="\#dotlrn-catalog.delete\#"><img border=0 src=/resources/Delete16.gif></a>
	    }
	}
    }

db_multirow -extend { asm_name rel item_id creation_user category_name } course_list $query {} {
    set asm_name [db_string get_asm_name { } -default "[_ dotlrn-catalog.not_associated]"]
    set item_id [dotlrn_catalog::get_item_id -revision_id $course_id]
    set creation_user [dotlrn_catalog::get_creation_user -object_id $item_id]
    set rel [dotlrn_catalog::has_relation -course_id $course_id]
    set category_name ""
    set mapped [category::get_mapped_categories $course_id]
    foreach element $mapped {
	append category_name "[category::get_name $element], "
    }
    set category_name [string range $category_name 0 [expr [string length $category_name] - 3]]
}

