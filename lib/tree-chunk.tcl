ad_page_contract {
    Display an ident tree of categories and courses.
    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation-date   11-02-2005

} {
    category_f:optional
    uncat_f:optional
}

# Get all tree categories
set tree_list [category_tree::get_tree -all $tree_id]

# Create a list of values for the list filter
set tree [list]
foreach element $tree_list {
    set ident [lindex $element 3]
    set spacer ""
    for { set i 1 } { $i < $ident } { incr i } {
	append spacer ". . "
    }
    lappend tree [list "${spacer}[lindex "$element" 1]" [lindex $element 0]]
}

# Get all objects_ids and category_id
set cat_obj_list [dotlrn_catalog::get_categories_from_tree -tree_id $tree_id]

template::list::create \
    -name course_list \
    -multirow course_list \
    -key course_id \
    -filters {
	category_f {
	    label "[_ dotlrn-catalog.categories]"
	    values { $tree }
	    where_clause { dc.course_id in ( select object_id from category_object_map where category_id = :category_f )}
	}
	uncat_f {
	    label "[_ dotlrn-catalog.uncat]"
	    values { "Watch" }
	    where_clause { dc.course_id not in ( select object_id from category_object_map where category_id in \
						     ( select category_id from categories where tree_id =:tree_id ))
	    }
	}
    } \
    -bulk_action_method post \
    -bulk_action_export_vars {
    }\
    -row_pretty_plural "[_ dotlrn-catalog.courses]" \
    -elements {
	course_key  {
	    label "[_ dotlrn-catalog.course_key]"
	    display_template {
		<div align=left>
		@course_list.course_key@
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
    }


db_multirow course_list get_courses {}

