ad_page_contract {
    Displays a list of all revisions for one course

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   28-01-2005
} {
    { return_url "" }
    course_key:notnull
    course_id:notnull
}

set page_title "[_ dotlrn-catalog.rev_list]"
set context [list [list "course-list" "[_ dotlrn-catalog.course_list]" ] $page_title]
if {[string equal $return_url ""]} {
    set return_url "course-list"
}

set user_id [ad_conn user_id]
set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]

# Check for create permissions over dotlrn-catalog
permission::require_permission -party_id $user_id -object_id $cc_package_id -privilege "create"



# Check if users has admin permission to edit the course
set item_id [dotlrn_catalog::get_item_id -revision_id $course_id]
permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"


set context [list [list "course-list"  "[_ dotlrn-catalog.course_list]"] "[_ dotlrn-catalog.rev_list]"]

db_multirow -extend { asm_name rel } course_list get_course_info { } {
    set asm_name [db_string get_asm_name { } -default "[_ dotlrn-catalog.not_associated]"]
    set rel [dotlrn_catalog::has_relation -course_id $course_id]
}
db_multirow -extend { asm_name rel } live_course get_live_course { } {
    set asm_name [db_string get_asm_name { } -default "[_ dotlrn-catalog.not_associated]"]
    set rel [dotlrn_catalog::has_relation -course_id $course_id]
}

