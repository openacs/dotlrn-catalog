<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>

<multiple name="live_course">
    <include src="/packages/dotlrn-catalog/lib/course-chunk" course_id=@live_course.course_id@ course_key=@live_course.course_key@ name=@live_course.course_name@ info=@live_course.course_info@ asm=@live_course.asm_name@ rel=@live_course.rel@ return_url=@return_url@ edit=no live_revision=@live_course.live_revision@ revision=yes>
<br>
<hr>
</multiple>


<multiple name="course_list">
    <include src="/packages/dotlrn-catalog/lib/course-chunk" course_id=@course_list.course_id@ course_key=@course_list.course_key@ name=@course_list.course_name@ info=@course_list.course_info@ asm=@course_list.asm_name@ rel=@course_list.rel@ return_url=@return_url@ edit=no live_revision=@course_list.live_revision@ revision=yes>
<br>
<hr>
</multiple>

