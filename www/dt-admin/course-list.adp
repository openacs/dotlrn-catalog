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
<br><br><br>
<center>

<form action="course-list" method="GET">
    #dotlrn-catalog.search_courses# 
    <input name="keyword" onfocus="if(this.value=='Please type a keyword')this.value='';" onblur="if(this.value=='')this.value='#dotlrn-catalog.please_type#';" value="#dotlrn-catalog.please_type#" />
    <input type="submit" value="#dotlrn-catalog.search#" />
</form>
<br>
<listtemplate name=course_list></listtemplate>

</center>

