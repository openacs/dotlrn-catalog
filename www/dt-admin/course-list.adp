<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>
 <a href="course-add-edit?return_url=@return_url@">#dotlrn-catalog.new_course#</a>
<if @admin_p@ eq 1>
    <if @tree_id@ not eq ""> 
    | <a href="/categories/cadmin/tree-view?tree_id=@tree_id@">#dotlrn-catalog.admin_categories#</a>
    </if>
| <a href="../admin/grant-list?return_url=@return_url@">#dotlrn-catalog.grant_per#</a>
</if>
<br><br>
<center>
<listtemplate name=course_list></listtemplate>
</center>