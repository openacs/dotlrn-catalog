ad_page_contract {
    Display an ident tree of categories and courses.
    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation-date   11-02-2005

} {

}


set tree_list [category_tree::get_tree -all $tree_id]
set tree_view ""

set cat_obj_list [dotlrn_catalog::get_categories_from_tree -tree_id $tree_id]

# Display all courses associated to one category
foreach element $tree_list {
    set level [lindex $element 3]
    set spacer ""
    for { set i 0 } { $i < $level } { incr i } {
        append spacer "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
    }
    if { [string equal $level 1] } {
        append tree_view "<b>${spacer}[lindex $element 1]<br></b>"
    } else {
        append tree_view "${spacer}[lindex $element 1]<br>"
    }
    foreach item $cat_obj_list {
	if { [string equal [lindex $item 0] [lindex $element 0] ]} {
	    set course_id "[lindex $item 1]"
	    db_0or1row get_course_info { }
	    append tree_view "${spacer}&nbsp;&nbsp&nbsp;&nbsp;<a href=\"course-info?course_id=$course_id&course_key=$course_key&course_name=$course_name\">($course_key) $course_name</a><br>"
	}
    }
}

# Display courses without category
set uncat_p 0
db_multirow uncat get_courses_uncat { } {
    set uncat_p 1
}