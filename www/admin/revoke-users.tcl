ad_page_contract {
    Revokes users admin permissions on dotlrn_catalog

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   29-01-2005
} {
    p_user_id:multiple
    { user_name "" }
    { user_email "" }
}

# dotlrn_catalog package_id
set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]

# Grants Permission for all the users in p_user_id
foreach user $p_user_id {
    permission::revoke -party_id $user -object_id $cc_package_id  -privilege "create"
}


ad_returnredirect "grant-list?user_name=$user_name&user_email=$user_email"
