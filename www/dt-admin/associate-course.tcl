ad_page_contract {
    Associates dotlrn_catalog's course_id with dotlrn's class_instance_id or community

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   31-01-2005
} {
    course_id:notnull
    type:notnull
    object_id:multiple
    { return_url ""}
}

if { [string equal $type "class"] } {
    set type "dotlrn_catalog_class_rel"
} else {
    set type "dotlrn_catalog_dotcom_rel"
}

foreach object $object_id {
    dotlrn_catalog::add_relation -course_id $course_id -object_id $object -type $type
}

if { [string equal $return_url ""] } {
    ad_returnredirect "dotlrn-list?course_id=$course_id"
}
