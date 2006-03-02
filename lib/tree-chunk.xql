<?xml version="1.0"?>
<queryset>

<fullquery name="get_courses">
      <querytext>
            select dc.course_id, dc.course_key, dc.course_name, dc.assessment_id
            from dotlrn_catalog dc, cr_items ci
            where active_p = 't' and dc.course_id = ci.live_revision
            [template::list::filter_where_clauses -and -name course_list]
        </querytext>
</fullquery>

</queryset>
