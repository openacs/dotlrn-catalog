ad_page_contract {
    Displays the information of one dotLRN class
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   08-01-2005
} {

}

db_1row get_class_info { }

set community_id [dotlrn_community::get_community_id_from_url -url $url ]

# get all the users in a list of ns_sets
set all_users_list [dotlrn_community::list_users $community_id]

set n_profs 0
set n_tas 0
set n_cas 0

# count how many of some types
foreach one_user_set $all_users_list {
    if {[string equal [ns_set get $one_user_set rel_type] "dotlrn_instructor_rel"]} {
	incr n_profs
    } elseif {[string equal [ns_set get $one_user_set rel_type] "dotlrn_ta_rel"]} {
	incr n_tas
    } elseif {[string equal [ns_set get $one_user_set rel_type] "dotlrn_ca_rel"]} {
	incr n_cas
    }
}

# stuff into a multirow
template::util::list_of_ns_sets_to_multirow \
    -rows $all_users_list \
    -var_name "users"

# Used in en_US version of some messages in adp
set instructor_role_pretty_plural [dotlrn_community::get_role_pretty_plural -community_id $community_id \
				       -rel_type dotlrn_instructor_rel]
set teaching_assistant_role_pretty_plural [dotlrn_community::get_role_pretty_plural -community_id $community_id \
					       -rel_type dotlrn_ta_rel]
set course_assistant_role_pretty_plural [dotlrn_community::get_role_pretty_plural -community_id $community_id \
					     -rel_type dotlrn_ca_rel]

if { [catch {[email_image::get_folder_id] } errmsg] } {
    set email_p 0
} else {
    set email_p 1
}