<table>
<h3>#dotlrn-catalog.info#:</h3>
<tr>
   <td>
   <if @edit@ eq yes>
   <div align="right">
	<a href=course-add-edit?course_id=@course_id@&return_url=@return_url@&mode=edit \
	title="#dotlrn-catalog.new_ver#"><img border=0 src=/resources/Edit16.gif></a>
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
	       #dotlrn-catalog.yes# (<a href="dt-admin/watch-association?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@&course_name=@name@" title="#dotlrn-catalog.watch_assoc#"><i>#dotlrn-catalog.watch#</i></a>)
	   </if>
	   <else>
	       #dotlrn-catalog.yes# (<a href="watch-association?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@&course_name=@name@" title="#dotlrn-catalog.watch_assoc#"><i>#dotlrn-catalog.watch#</i></a>)
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
<if @category_p@ eq "1">
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
	<if @asmid@ gt "-1">
	    <a class="button" href="/assessment/assessment?assessment_id=@asmid@">#dotlrn-catalog.enroll#</a>
	</if>
	<else>
	   <br>
	   <b>#dotlrn-catalog.enroll_not#</b>
	</else>
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
<h3>#dotlrn-catalog.dotlrn_assoc#:</h3>
<multiple name="relations">
    <if @relations.type@ eq "dotlrn_catalog_class_rel">
    	<include src="/packages/dotlrn-catalog/lib/dotlrn-chunk" class_id=@relations.object_id@>
    </if>
    <else>
    	<include src="/packages/dotlrn-catalog/lib/community-chunk" community_id=@relations.object_id@>
    </else>
</multiple>
</if>

