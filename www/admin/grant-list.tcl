ad_page_contract {
    Displays a list of all users to grant permissions

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   28-01-2005
} {
    { return_url "" }
    { keyword "" }
}

set user_id [ad_conn user_id]
# dotlrn-catalog package_id
set cc_package_id [ad_conn package_id]

set page_title "[_ dotlrn-catalog.grant_list]"
if {[string equal $return_url ""]} {
    set return_url "grant-list"
}

set context [list [list "../dt-admin/course-list" "[_ dotlrn-catalog.course_list]"] $page_title]

# To search for users
ad_form -name search_user -form {
    {keyword:text(text),optional
	{label "[_ dotlrn-catalog.search_user]"}
	{help_text "[_ dotlrn-catalog.search_help], [_ dotlrn-catalog.search_email_help]"}
    }
}


db_multirow -extend { privilege email } grant_list select_users_name_email {} {
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
	keyword
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
	    label "[_ dotlrn-catalog.privilege_on_catalog]"
	    display_template {
		<div align=center>
		<if @grant_list.privilege@ eq 1>
		   [_ dotlrn-catalog.create]
		</if>
		<else>
		   <i>[_ dotlrn-catalog.not_allowed]</i>
		</else>
		</div>
	    }
	}
    }

