<STYLE TYPE="text/css">
table.list {
  font-family: tahoma, verdana, helvetica; 
  border-collapse: collapse;
  font-size: 12px;
}
</STYLE>

<table>
<if @index@ eq "yes">
   <if @admin_p;literal@ true>
   <div align="left">
        <a href="dt-admin/course-info?course_id=@course_id@&course_name=@name@&course_key=@course_key@&index=yes" title="#dotlrn-catalog.admin_this#"><img border=0 src=images/admin.gif></a> 
   </div>
   </if>
</if>
<h3>#dotlrn-catalog.info#:</h3>
<tr>
   <td>
   <if @edit@ eq yes>
   <div align="right">
	<a href=course-add-edit?course_id=@course_id@&return_url=course-info&mode=1&index=@to_index@ title="#dotlrn-catalog.new_ver#"><img border=0 src=/resources/Edit16.gif></a>
   </div>
   </if>
   </td>
  <td>
    <b>#dotlrn-catalog.course_key#</b>
  </td>
  <td>
    <if @edit@ eq yes>
    <a href="revision-list?course_key=@course_key@&return_url=$return_url&course_id=@course_id@" title="#dotlrn-catalog.see_all_rev#">@course_key@</a></if><else>@course_key@</else>
   </td>
</tr>
<tr><td></td>
    <td><b>#dotlrn-catalog.course_name#</b></td><td>@name@</td>
</tr>
<tr><td></td>
    <td><b>#dotlrn-catalog.course_info#</b></td><td>@info;noquote@</td>
</tr>
<if @revision@ eq yes>
<tr><td></td>
    <td>
	<b>#dotlrn-catalog.dotlrn#:</b>
    </td>
    <td>
	<if @rel@ eq 0>
	   #dotlrn-catalog.no# 
	  <if @edit@ eq "yes">
	     <if @dotlrn_url@ eq "/dotlrn">
             (<a href="dotlrn-list?course_id=@course_id@&course_key=@course_key@&course_name=@name@&return_url=@return_url@" title="#dotlrn-catalog.associate_this#"><i>#dotlrn-catalog.associate#</i></a>)</if>
          </if>
	</if>
	<else>
	   <if @index@ eq "yes">
	       #dotlrn-catalog.yes# (<a href="dt-admin/course-details?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@&course_name=@name@" title="#dotlrn-catalog.course_details#"><i>#dotlrn-catalog.watch#</i></a>)
	   </if>
	   <else>
	       #dotlrn-catalog.yes# (<a href="course-details?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@&course_name=@name@" title="#dotlrn-catalog.course_details#"><i>#dotlrn-catalog.watch#</i></a>)
	   </else>
	</else>
    </td>
</tr>
</if>
<if @asm@ not eq #dotlrn-catalog.not_associated#>
    <tr><td></td>
        <td><b>#dotlrn-catalog.asm#:</b></td><td>@asm@</td>
    </tr>
</if>
<if @category_p;literal@ true>
    <if @index@ not eq "yes">
        <tr><td></td>
	   <td>
	       <b>#dotlrn-catalog.categorize#:</b>
	   </td>
    	   <td>#dotlrn-catalog.yes# (@category_name@)</td>
        </tr>
    </if>
</if>
<tr><td></td><td></td>
<td>
   <if @edit@ eq no>
      <if @index@ eq "yes">
	<if @asmid@ not eq "-1">
	    <a class="button" href="@ret_chunck@">#dotlrn-catalog.enroll#</a>
	</if>
      </if>
      <else>
         <if @course_id@ eq @live_revision@>
	     <img border=0 src="/dotlrn-catalog/images/live.gif">   
         </if>
         <else>
	     <a href="go-live?course_key=@course_key@&revision_id=@course_id@" title="#dotlrn-catalog.make_live#"><img border=0 src="/dotlrn-catalog/images/golive.gif"></a>
         </else>
      </else>
   </if>
   <else>
	<a class=button href="grant-user-list?object_id=@item_id@&creation_user=@creation_user@&course_key=@course_key@" title="#dotlrn-catalog.grantrevoke#">#dotlrn-catalog.manage_per#</a>
         <a class=button href="course-delete?object_id=@item_id@&creation_user=@creation_user@&course_key=@course_key@" title="#dotlrn-catalog.delete_this#">#dotlrn-catalog.delete#</a>
	<if @category_p@ eq "-1">
	   <a class=button href="course-categorize?course_id=@course_id@&name=@name@">#dotlrn-catalog.categorize#</a>
	</if>
   </td>
   </else>
</tr>
</table>

<br>
<if @revision@ not eq yes>
  <if @obj_n@ not eq "0">
  </if>
  <else>
     <if @admin_p;literal@ true>
        <if @index@ not eq "yes">
          <h3>#dotlrn-catalog.dotlrn_assoc#:</h3>
          &nbsp;&nbsp;&nbsp;#dotlrn-catalog.no# 
          (<a href="dotlrn-list?course_id=@course_id@&course_key=@course_key@&course_name=@name@" title="#dotlrn-catalog.associate_this#"><i>#dotlrn-catalog.associate#</i></a>)
        </if>
     </if>
  </else>
</if>

<h2>@course_key@ (@name@) #dotlrn-catalog.dotlrn_classes#:</h2>
<listtemplate name="dotlrn_classes"></listtemplate>

<h2>@course_key@ (@name@) #dotlrn-catalog.dotlrn_com#:</h2>
<listtemplate name="dotlrn_communities"></listtemplate>
