ad_page_contract {
    Display an ident tree of categories and courses.
    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation-date   11-02-2005

} {
    category_f:optional
    uncat_f:optional
    { level "" }
}

if { [info exist category_f] } {
    set var_list [split $category_f "&"]
    set category_v [lindex $var_list 0]
    set level [lindex [split [lindex $var_list 1] "="] 1]
} else {
    set category_v ""
}


# Get all tree categories
set tree_list [category_tree::get_tree -all $tree_id]
set tree_length [llength $tree_list]

# Create a list of values for the list filter
set tree [list]

foreach element $tree_list {
    set ident [lindex $element 3]
    set spacer ""
    for { set i 1 } { $i < $ident } { incr i } {
	append spacer ". . "
    }
    lappend tree [list "${spacer}[lindex "$element" 1]" "[lindex $element 0]&level=[lindex $element 3]" ]
}

# Get all sub categories
set map_tree "("
if { ![string equal $level ""] } {
    set j 0
    set i 0
    while { $i < $tree_length } {
	set element [lindex $tree_list $i]
	if {[string equal $category_v [lindex $element 0]] } {
	    append map_tree "[lindex $element 0],"
	    set pos $i
	    set i $tree_length
	}
	incr i
    }
    set j 0
    set i [expr $pos + 1]
    while { $i < $tree_length } {
	set element [lindex $tree_list $i]
	if { $level < [lindex $element 3] } {
	    append map_tree "[lindex $element 0],"
	    incr i
	} else {
	    set i $tree_length
	}
    }
    append map_tree "0)"
}

if { [string equal $category_v ""] } {
    set where_query "dc.course_id in ( select object_id from category_object_map_tree where tree_id = :tree_id )" 
} else {
    set where_query "dc.course_id in ( select object_id from category_object_map_tree where tree_id = :tree_id and category_id in $map_tree )"
}

template::list::create \
    -name course_list \
    -multirow course_list \
    -key course_id \
    -filters {
	category_f {
	    label "[_ dotlrn-catalog.categories]"
	    values { $tree }
	    where_clause { $where_query }
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
		<a href="course-info?course_id=@course_list.course_id@&course_name=@course_list.course_name@&course_key=@course_list.course_key@">@course_list.course_key@</a>
		</div>
	    }
	}
	name  {
	    label "[_ dotlrn-catalog.course_name]"
	    display_template {
		<div align=left>
		@course_list.course_name@
		</div>
	    }
	}
    }


db_multirow course_list get_courses {}

