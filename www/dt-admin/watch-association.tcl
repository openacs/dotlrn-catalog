ad_page_contract {
    Shows all associations that course_id has
    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation date   28-01-2005
} {
    { return_url "" }
    course_id:notnull
    course_key:notnull
    { course_name "" }
}

if { [string equal $return_url "index"] } {
    set context [list [list ../course-info?course_id=$course_id&course_key=$course_key&course_name=$course_name  "[_ dotlrn-catalog.one_course_info]"] "[_ dotlrn-catalog.watch_assoc]"]
} else {
    set context [list [list course-list  "[_ dotlrn-catalog.course_list]"] "[_ dotlrn-catalog.watch_assoc]"]
}

set page_title "[_ dotlrn-catalog.watch_assoc]"
set user_id [ad_conn user_id]

# Allows that an unregiser user watch this page
if { ![string equal $user_id "0"] } {
    # Check if users has admin permission to edit dotlrn_catalog
    permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"
}

db_multirow relations relation { }

