<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>

<if @type@ eq "class">
    <include src="/packages/dotlrn-catalog/lib/dotlrn-chunk" class_id=@object_id@>
</if>
<else>
    <include src="/packages/dotlrn-catalog/lib/community-chunk" community_id=@object_id@>
</else>
