ad_page_contract {
    Displays the information of class or community
    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation-date   08-01-2005
} {
    type:notnull
    object_id:notnull
    {course_id ""}
    {course_name ""}
    {course_key ""}
}

set page_title "[_ dotlrn-catalog.description]"
set context "[list [list "course-info?course_id=$course_id&course_name=$course_name&course_key=$course_key" "[_ dotlrn-catalog.one_course_info]"] $page_title]"