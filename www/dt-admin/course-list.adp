<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>
 <a href="course-add-edit?return_url=@return_url@">#dotlrn-catalog.new_course#</a>
<if @tree_id@ not eq ""> 
| <a href="/categories/cadmin/tree-view?tree_id=@tree_id@">#dotlrn-catalog.admin_categories#</a>
</if>
<if @admin_p@ eq 1>
| <a href="../admin/grant-list?return_url=@return_url@">#dotlrn-catalog.grant_per#</a>
</if>
<br><br>
<multiple name="course_list">
    <include src="/packages/dotlrn-catalog/lib/course-chunk" course_id=@course_list.course_id@ course_key=@course_list.course_key@ name=@course_list.course_name@ info=@course_list.course_info@ asm=@course_list.asm_name@ rel=@course_list.rel@ return_url=@return_url@ edit=yes live_revision="" item_id=@course_list.item_id@ creation_user=@course_list.creation_user@>
</multiple>
