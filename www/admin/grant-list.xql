<?xml version="1.0"?>
<queryset>

<fullquery name="select_users">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id, email as db_email
	  from cc_users where user_id in ( 
	      select grantee_id from acs_permissions where object_id = :cc_package_id
		  and privilege = 'create')
		
      </querytext>
</fullquery>

<fullquery name="select_users_name">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id, email as db_email
	  from cc_users where user_id <> :user_id and (lower(first_names) like lower('%$user_name%')
	  or lower(last_name) like lower('%$user_name%')) order by first_names, last_name
      </querytext>
</fullquery>

<fullquery name="select_users_email">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id, email as db_email
	  from cc_users where user_id <> :user_id and lower(email) like lower('%$user_email%')
	  order by email
      </querytext>
</fullquery>

<fullquery name="select_users_name_email">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id, email as db_email
	  from cc_users where user_id <> :user_id and (
	  lower(first_names) like lower('%$user_name%') or lower(last_name) like lower('%$user_name%'))
	  and lower(email) like lower('%$user_email%')
	  order by email
      </querytext>
</fullquery>


</queryset>
