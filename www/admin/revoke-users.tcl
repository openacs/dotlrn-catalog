ad_page_contract {
    Revokes users admin permissions on dotlrn_catalog

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   29-01-2005
} {
    p_user_id:multiple
    {keyword ""}
}

# Grants Permission for all the users in p_user_id
foreach user $p_user_id {
    set courses [db_list_of_lists user_courses {}]
    
    foreach course $courses {
	permission::revoke -party_id $user -object_id $course  -privilege "admin"
    }
    permission::revoke -party_id $user -object_id [ad_conn package_id]  -privilege "create"
}


ad_returnredirect "grant-list?keyword=$keyword"
