ad_page_contract {
    Index for course administration
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   31-01-2005

} {

}
set page_title "[_ dotlrn-catalog.course_catalog]"
set context ""
set return_url "dt-admin/course-list"

set cc_package_id [ad_conn package_id]

set user_id [ad_conn user_id]

if {[permission::permission_p -party_id $user_id -object_id $cc_package_id -privilege "create"]} {
    set create_p 1
} else {
    set create_p 0
}

set tree_id [db_string get_tree_id { } -default "-1"]




 
