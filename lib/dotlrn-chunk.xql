<?xml version="1.0"?>
<queryset>

    <fullquery name="get_class_info">
        <querytext>
            select department_name, term_name, class_name, pretty_name, description, url
	    from dotlrn_class_instances_full 
	    where class_instance_id = :class_id
        </querytext>
    </fullquery>

</queryset>