<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">
      <querytext>
            select dc.course_id, dc.course_key, dc.course_name
            from dotlrn_catalog dc, cr_items ci
            where dc.course_id = ci.live_revision and dc.course_id = :course_id
      </querytext>
</fullquery>


<fullquery name="get_courses_uncat">
      <querytext>
            select dc.course_id, dc.course_key, dc.course_name
            from dotlrn_catalog dc, cr_items ci
            where dc.course_id = ci.live_revision and dc.course_id not in (
		select object_id from category_object_map where category_id in (
	 	    select category_id from categories where tree_id =:tree_id
	    	)	
	    )	
      </querytext>
</fullquery>


</queryset>
