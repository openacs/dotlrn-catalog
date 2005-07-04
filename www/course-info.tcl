ad_page_contract {
    Displays information of one course
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   09-02-2005
} {
    course_id:notnull

}

db_1row get_course_info { } 
set page_title "$course_key [_ dotlrn-catalog.course_info]"
set context [list "[_ dotlrn-catalog.one_course_info]"]

set return_url "index"
dotlrn_catalog::get_course_data -course_id $course_id



set asm_name [db_string get_asm_name { } -default "[_ dotlrn-catalog.not_associated]"]
set item_id [dotlrn_catalog::get_item_id -revision_id $course_id]
set creation_user [dotlrn_catalog::get_creation_user -object_id $item_id]
set rel [dotlrn_catalog::has_relation -course_id $course_id]

