ad_page_contract {
    Displays a list of all courses
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   28-01-2005
} {

}

set user_id [ad_conn user_id]
set context [list "[_ dotlrn-catalog.course_list]"]
set page_title "[_ dotlrn-catalog.course_list]"
set return_url "course-list"

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


set asm_package_id [apm_package_id_from_key assessment]

if { [acs_user::site_wide_admin_p] } {
    set query get_course_info_site_wide
} else {
    set query get_course_info
}


db_multirow -extend { asm_name rel item_id creation_user } course_list $query {} {
    set asm_name [db_string get_asm_name { } -default "[_ dotlrn-catalog.not_associated]"]
    set item_id [dotlrn_catalog::get_item_id -revision_id $course_id]
    set creation_user [dotlrn_catalog::get_creation_user -object_id $item_id]
    set rel [dotlrn_catalog::has_relation -course_id $course_id]
}

