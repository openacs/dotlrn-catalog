<h3>#dotlrn-catalog.categorized#:</h3>
@tree_view;noquote@
<br>
<if @uncat_p@ eq 1>
   <h3>#dotlrn-catalog.uncategorized#:</h3>
</if>
<ul>
<multiple name="uncat">
    <li><a href="course-info?course_id=@course_id@&course_key=@course_key@&course_name=@course_name@">(@uncat.course_key@) @uncat.course_name@</a>
</multiple>
</ul>