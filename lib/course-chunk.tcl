ad_page_contract {
    Displays the information of one course
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   08-01-2005
} {

}

set dotlrn_url [dotlrn::get_url]
if { ![info exists index] } {
    set index ""
}

if { ![info exists asmid] } {
    set asmid "-1"
}

set category_p [db_string get_category { } -default -1]

set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]
set tree_id [db_string get_tree_id { } -default "-1"]

# Get the category name
set category_name "[category::get_name [category::get_mapped_categories $course_id]]"