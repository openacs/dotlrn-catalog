<?xml version="1.0"?>
<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="dotlrn_catalog::add_relation.add_relation">
     <querytext>
        begin
          :1 := acs_rel.new (
                 rel_type => :type,
                 object_id_one => :course_id,
                 object_id_two => :object_id);
        end;
     </querytext>
</fullquery>

<fullquery name="dotlrn_catalog::delete_relation.remove_relation">
     <querytext>
        begin
          acs_rel.del (:rel_id);
        end;
     </querytext>
</fullquery>


</queryset>