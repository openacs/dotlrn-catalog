<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">      
      <querytext>
	    select dc.course_id, dc.course_key, dc.course_name, dc.course_info, dc.assessment_id, ci.live_revision
	    from dotlrn_catalog dc, cr_items ci
	    where ci.item_id = :item_id and 
	    dc.course_id in (select revision_id from cr_revisions where item_id = :item_id )
      </querytext>
</fullquery>

<fullquery name="get_asm_name">
      <querytext>
            select cr.title from
            cr_folders cf, cr_items ci, cr_revisions cr, as_assessments a
            where cr.revision_id = ci.latest_revision and a.assessment_id = cr.revision_id and
            ci.parent_id = cf.folder_id and cf.package_id = :asm_package_id and
            ci.item_id = :assessment_id order by cr.title
      </querytext>
</fullquery>

    <fullquery name="get_class_info">
        <querytext>
            select pretty_name, url
	    from dotlrn_class_instances_full 
	    where class_instance_id = :class_id
        </querytext>
    </fullquery>

</queryset>
