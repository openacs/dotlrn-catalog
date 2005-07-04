<?xml version="1.0"?>
<queryset>

<fullquery name="select_users_name_email">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id, email as db_email
	  from cc_users where user_id <> :user_id and (
	  lower(first_names) like lower('%$keyword%') or lower(last_name) like lower('%$keyword%') or
	  lower(email) like lower('%$keyword%')) order by email
      </querytext>
</fullquery>

</queryset>
