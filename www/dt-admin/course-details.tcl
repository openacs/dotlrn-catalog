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

permission::require_permission -object_id $course_id -privilege "admin"

if { [string equal $return_url "index"] } {
    set context [list [list ../course-info?course_id=$course_id&course_key=$course_key&course_name=$course_name  "[_ dotlrn-catalog.one_course_info]"] "[_ dotlrn-catalog.course_details]"]
} else {
    set context [list [list course-list  "[_ dotlrn-catalog.course_list]"] "[_ dotlrn-catalog.course_details]"]
}

set page_title "[_ dotlrn-catalog.course_details]"
set user_id [ad_conn user_id]

db_multirow relations relation { }

