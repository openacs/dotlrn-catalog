ad_page_contract {
    Displays a list of all users to grant permissions

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   28-01-2005
} {
    { return_url "" }
    { user_name "" }
    { user_email "" }

}

set user_id [ad_conn user_id]
# dotlrn-catalog package_id
set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]

set page_title "[_ dotlrn-catalog.grant_list]"
if {[string equal $return_url ""]} {
    set return_url "grant-list"
}

set context [list [list "../cc-admin/course-list" "[_ dotlrn-catalog.course_list]"] $page_title]

# To search for users
ad_form -name search_user -form {
    {user_name:text(text),optional
	{label "[_ dotlrn-catalog.search_user]"}
	{help_text "[_ dotlrn-catalog.search_help]"}
    }
    {user_email:text(text),optional
	{label "[_ dotlrn-catalog.search_user_email]"}
	{help_text "[_ dotlrn-catalog.search_email_help]"}
    }
}


# Establish what query to use in order to the values of the form elements
if {![string equal $user_name ""]} {
    set query select_users_name
    if {![string equal $user_email ""]} {
	set query select_users_name_email
    }
} else {
    set query select_users
    if {![string equal $user_email ""]} {
	    set query select_users_email
    }
}

db_multirow -extend { privilege email } grant_list $query {} {
    set privilege [permission::permission_p -party_id $p_user_id -object_id $cc_package_id -privilege "create"]
    if { [catch { set email [email_image::get_user_email -user_id $p_user_id] } errmsg] } {
	set email $db_email
    } else {
	set email [email_image::get_user_email -user_id $p_user_id]
    }
}

template::list::create \
    -name grant_list \
    -multirow grant_list \
    -key p_user_id \
    -bulk_actions {"\#dotlrn-catalog.grant\#" "grant-users?" "\#dotlrn-catalog.grant_per\#"\
		       "\#dotlrn-catalog.revoke\#" "revoke-users?" "\#dotlrn-catalog.revoke_per\#" }\
    -bulk_action_method post \
    -bulk_action_export_vars {
	user_name
	user_email
    }\
    -row_pretty_plural "[_ dotlrn-catalog.users_to_grant]" \
    -elements {
	name {
	    label "[_ dotlrn-catalog.user_name]"
	    display_template {
		@grant_list.first_names@ @grant_list.last_name@
	    }
	}
	email {
	    label "[_ dotlrn-catalog.email]"
	    display_template {
		@grant_list.email;noquote@
	    }
	}
	permission {
	    label "[_ dotlrn-catalog.permission]"
	    display_template {
		<if @grant_list.privilege@ eq 1>
		   [_ dotlrn-catalog.granted]
		</if>
		<else>
		   <i>[_ dotlrn-catalog.not_allowed]</i>
		</else>
	    }
	}
    }

