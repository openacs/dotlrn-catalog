<?xml version="1.0"?>
<queryset>

<fullquery name="dotlrn_catalog::get_folder_id.check_folder_name">
  <querytext>
        select folder_id from cr_folders
        where label = 'DotLRN Catalog'
  </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::get_item_id.get_item_from_revision">
  <querytext>
        select item_id from cr_revisions
        where revision_id = :revision_id
  </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::get_creation_user.get_creation_user">
  <querytext>
        select creation_user from acs_objects
        where object_id = :object_id
  </querytext>
</fullquery>


<fullquery name="dotlrn_catalog::set_live.set_live_revision">      
      <querytext>
            update cr_items
            set live_revision = :revision_id
	    where item_id = ( select item_id from cr_revisions where revision_id = :revision_id )
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::check_name.check_item_name">      
      <querytext>
	    select course_id from dotlrn_catalog where course_key = :name
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::has_relation.has_relation">      
      <querytext>
            select count (rel_id)
	    from acs_rels where object_id_one = :course_id 
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::relation_between.relation_between">      
      <querytext>
            select rel_id
	    from acs_rels where object_id_one = :object_one and object_id_two = :object_two
      </querytext>
</fullquery>


<fullquery name="dotlrn_catalog::com_has_relation.com_has_relation">      
      <querytext>
            select count (rel_id)
	    from acs_rels where rel_type = 'dotlrn_catalog_com_rel'
	    and object_id_two = :community_id
      </querytext>
</fullquery>


<fullquery name="dotlrn_catalog::has_relation_rel_id.has_relation_rel_id">      
      <querytext>
            select rel_id
	    from acs_rels where
	    (rel_type = 'dotlrn_catalog_class_rel' or rel_type = 'dotlrn_catalog_com_rel')
	    and object_id_one = :course_id
      </querytext>
</fullquery>


<fullquery name="dotlrn_catalog::delete_row.delete_row">      
      <querytext>
	   delete from dotlrn_catalog where course_id = :course_id
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::delete_row.delete_rev">      
      <querytext>
	   delete from cr_revisions where revision_id = :course_id
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::check_live_latest.check_live">      
      <querytext>
	   select 1 from cr_items where live_revision = :revision_id
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::check_live_latest.check_latest">      
      <querytext>
	   select 1 from cr_items where latest_revision = :revision_id
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::grant_permissions.assessment">
      <querytext>
            select ci.item_id as assessment_id from
            cr_folders cf, cr_items ci, cr_revisions cr, as_assessments a
            where cr.revision_id = ci.latest_revision and a.assessment_id = cr.revision_id and
            ci.parent_id = cf.folder_id and cf.package_id = :asm_package_id 
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::revoke_permissions.assessment">
      <querytext>
            select ci.item_id as assessment_id from
            cr_folders cf, cr_items ci, cr_revisions cr, as_assessments a
            where cr.revision_id = ci.latest_revision and a.assessment_id = cr.revision_id and
            ci.parent_id = cf.folder_id and cf.package_id = :asm_package_id 
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::check_rev_assoc.revision_count">
      <querytext>
	    select count(revision_id) from cr_revisions where item_id = :item_id
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::check_rev_assoc.association_count">
      <querytext>
	    select count(rel_id) from acs_rels where object_id_one in (
		select revision_id from cr_revisions where item_id = :item_id )
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::course_delete.relation">
      <querytext>
	    select rel_id from acs_rels where object_id_one in (
		select revision_id from cr_revisions where item_id = :item_id )
      </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::get_categories_from_tree.get_categories">
      <querytext>
	   select om.category_id, om.object_id from category_object_map om where
	   om.category_id in (select category_id from categories where tree_id =:tree_id)
	   and om.object_id in (select live_revision from cr_items where content_type = 'dotlrn_catalog')
      </querytext>
</fullquery>


</queryset>
