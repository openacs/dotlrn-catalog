ad_page_contract {
    Gives users admin permissions on dotlrn_catalog

    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation-date   29-01-2005
} {
    p_user_id:multiple
    { user_name "" }
    { user_email "" }
} 

# dotlrn_catalog package_id
set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]

# The tree id from categories
set tree_list [category_tree::get_mapped_trees $cc_package_id]
if { [string equal [lindex [lindex $tree_list 0] 1] "dotlrn-course-catalog"] } {
    set tree_id [lindex [lindex $tree_list 0] 0]
} else {
    set tree_id ""
}


# Grants Permission for all the users in p_user_id
foreach user $p_user_id {
    permission::grant -party_id $user -object_id $cc_package_id  -privilege "create"
    permission::grant -party_id $user -object_id $tree_id -privilege category_tree_read
    permission::grant -party_id $user -object_id $tree_id -privilege category_tree_write
}


ad_returnredirect "grant-list?user_name=$user_name&user_email=$user_email"
