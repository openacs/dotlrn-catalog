<?xml version="1.0"?>
<queryset>

<fullquery name="user_courses">      
      <querytext>
	select cr.item_id as course_item_id 
        from 
        cr_revisions cr, dotlrn_catalog dc, acs_permissions ap 
	where
	cr.revision_id = dc.course_id and ap.object_id = cr.item_id 
	and ap.privilege = 'admin' and ap.grantee_id = :user
      </querytext>
</fullquery>


</queryset>
