<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>


<h2>@course_key;noquote@ (@course_name@) #dotlrn-catalog.is_assoc#</h2>

<multiple name="relations">
    <if @relations.type@ eq "dotlrn_catalog_class_rel">
    	<include src="/packages/dotlrn-catalog/lib/dotlrn-chunk" class_id=@relations.object_id@>
    </if>
    <else>
    	<include src="/packages/dotlrn-catalog/lib/community-chunk" community_id=@relations.object_id@>
    </else>
</multiple>

