ad_page_contract {
    Makes one revision live

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   29-01-2005
} {
    revision_id:notnull
}

dotlrn_catalog::set_live -revision_id $revision_id

ad_returnredirect "/dotlrn-catalog/dt-admin/course-list"
