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

</queryset>