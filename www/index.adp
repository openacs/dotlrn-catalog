<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>

<STYLE TYPE="text/css">
td.list-filter-pane-big {
  background-color: #ddddff;
  vertical-align: top;
  font-size: 14px;
}
</STYLE>

<if @create_p;literal@ true>
    <div align="right"><a href="dt-admin/course-list"><img border=0 src=images/admin.gif></a></div>
</if>

<include src="/packages/dotlrn-catalog/lib/tree-chunk" tree_id=@tree_id@>

