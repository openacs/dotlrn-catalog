<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>

<if @course_key@ not nil>
	<h2>#dotlrn-catalog.associate# @course_key@ (@course_name@) #dotlrn-catalog.to# #dotlrn-catalog.class#:</h2> 
</if>
<else>
        <h2>#dotlrn-catalog.associate# #dotlrn-catalog.to# #dotlrn-catalog.class#:</h2> 
</else>

<listtemplate name="dotlrn_classes"></listtemplate>

<if @course_key@ not nil>
	<h2>#dotlrn-catalog.associate# @course_key@ (@course_name@) #dotlrn-catalog.to# #dotlrn-catalog.community#:</h2> 
</if>
<else>
        <h2>#dotlrn-catalog.associate# #dotlrn-catalog.to# #dotlrn-catalog.community#:</h2> 
</else>
<listtemplate name="dotlrn_communities"></listtemplate>