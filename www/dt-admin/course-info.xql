<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">      
      <querytext>
            select dc.course_info, dc.assessment_id, cr.item_id
	    from dotlrn_catalog dc, cr_revisions cr
 	    where cr.revision_id = :course_id and dc.course_id = :course_id
      </querytext>
</fullquery>

<fullquery name="get_asm_name">
      <querytext>
            select cr.title from
            cr_folders cf, cr_items ci, cr_revisions cr, as_assessments a
            where cr.revision_id = ci.latest_revision and a.assessment_id = cr.revision_id and
            ci.parent_id = cf.folder_id and ci.item_id = :assessment_id order by cr.title
      </querytext>
</fullquery>


</queryset>