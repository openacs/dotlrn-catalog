<?xml version="1.0"?>
<queryset>

<fullquery name="community_admin_users">      
      <querytext>
	select
	   user_id
	from
	dotlrn_member_rels_full
	where 
  	   community_id = :object
	   and role = 'instructor' or role = 'admin'
      </querytext>
</fullquery>
</queryset>