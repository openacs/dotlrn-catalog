<?xml version="1.0"?>
<queryset>

    <fullquery name="get_category">
        <querytext>
	     select 1 from category_object_map where object_id = :course_id
        </querytext>
    </fullquery>

    <fullquery name="get_tree_id">      
        <querytext>
      	    select tree_id from category_tree_map where object_id = :cc_package_id
        </querytext>
    </fullquery>

    <fullquery name="relation">
        <querytext>
            select object_id_two as object_id, rel_type as type from acs_rels
	    where object_id_one = :course_id order by type
        </querytext>
    </fullquery>

</queryset>