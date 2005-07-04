ad_page_contract {
    Gives users admin permissions on dotlrn_catalog

    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation-date   29-01-2005
} {
    p_user_id:multiple
    { keyword ""}
} 

# dotlrn_catalog package_id
set cc_package_id [ad_conn package_id]

# Grants Permission for all the users in p_user_id
foreach user $p_user_id {
    permission::grant -party_id $user -object_id $cc_package_id  -privilege "create"
}


ad_returnredirect "grant-list?keyword=$keyword"
