<?xml version="1.0"?>
<queryset>
<rdbms><type>postgresql</type><version>7.3</version></rdbms>

<fullquery name="dotlrn_catalog::add_relation.add_relation">
     <querytext>
	select acs_rel__new (
        null,
        :type,
        :course_id,
        :object_id,
        null,
        null,
        null
        )
     </querytext>
</fullquery>


<fullquery name="dotlrn_catalog::delete_relation.remove_relation">
     <querytext>
	select acs_rel__delete (
	    :rel_id
        )
     </querytext>
</fullquery>


</queryset>