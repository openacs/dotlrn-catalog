<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>


<multiple name="course_list">
    <include src="/packages/dotlrn-catalog/lib/course-chunk" course_id=@course_list.course_id@ course_key=@course_list.course_key@ name=@course_list.course_name@ info=@course_list.course_info@ asm=@course_list.asm_name@ rel=@course_list.rel@ return_url=@return_url@ edit=no live_revision=@course_list.live_revision@ revision=yes>
</multiple>

