ad_page_contract {
    Gives users the same permissions that creation_users has over course_id and assessment_id

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   03-02-2005
} {
    p_user_id:multiple
    { keyword "" }
    object_id:notnull
    creation_user:notnull
    course_key:notnull
} 

# Grants Permission for all the users in p_user_id
foreach user $p_user_id {
    dotlrn_catalog::grant_permissions -party_id $user -object_id $object_id -creation_user $creation_user
}

ad_returnredirect "grant-user-list?keyword=$keyword&object_id=$object_id&creation_user=$creation_user&course_key=$course_key"
