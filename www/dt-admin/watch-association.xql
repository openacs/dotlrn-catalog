<?xml version="1.0"?>
<queryset>

    <fullquery name="get_class_info">
        <querytext>
            select department_name, term_name, class_name, pretty_name, description, url
	    from dotlrn_class_instances_full 
	    where class_instance_id = :class_id
        </querytext>
    </fullquery>

    <fullquery name="relation">
        <querytext>
            select object_id_two as object_id, rel_type as type from acs_rels
	    where object_id_one = :course_id order by type
        </querytext>
    </fullquery>

</queryset>