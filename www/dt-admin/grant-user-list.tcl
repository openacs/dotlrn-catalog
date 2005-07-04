ad_page_contract {
    Displays a list of all users that have create privile under dotlrn_catalog
    to give them admin privileges over course_id and assessment_id

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   03-01-2005
} {
    { return_url "" }
    { keyword "" }
    course_key:notnull
    object_id:notnull
    creation_user:notnull
}

# Check for create permissions over dotlrn-catalog
set user_id [ad_conn user_id]
set cc_package_id [ad_conn package_id]
permission::require_permission -party_id $user_id -object_id $cc_package_id -privilege "create"

set page_title "[_ dotlrn-catalog.search_users_to] $course_key"
set context [list [list course-list "[_ dotlrn-catalog.course_list]"] "[_ dotlrn-catalog.search_u]"]
if {[string equal $return_url ""]} {
    set return_url "grant-user-list"
}

# To search for users
ad_form -name search_user -form {
    {object_id:text(hidden)
	{value "$object_id"}
    }
    {creation_user:text(hidden)
	{value "$creation_user"}
    }
    {course_key:text(hidden)
	{value "$course_key"}
    }
    {keyword:text(text),optional
	{label "[_ dotlrn-catalog.search_user]"}
	{help_text "[_ dotlrn-catalog.search_help] or [_ dotlrn-catalog.search_email_help]"}
    }
}

db_multirow -extend { privilege email } grant_list select_users_name_email {} {
    set privilege [permission::permission_p -party_id $p_user_id -object_id $object_id -privilege "admin"]
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
    -bulk_actions {"\#dotlrn-catalog.grant\#" "grant-permission" "\#dotlrn-catalog.grant_per\#"\
		       "\#dotlrn-catalog.revoke\#" "revoke-permission" "\#dotlrn-catalog.revoke_per\#" }\
    -bulk_action_method post \
    -bulk_action_export_vars {
	keyword
	object_id
	creation_user
	course_key
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
	    label "[_ dotlrn-catalog.privilege_on] $course_key:"
	    display_template {
		<div align=center>
		<if @grant_list.privilege@ eq 1>
		[_ dotlrn-catalog.admin]
		</if>
		<else>
		<i>[_ dotlrn-catalog.not_allowed]</i>
		</else>
		</div>
	    }
	}
    }

