--
-- author  Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
-- creation-date 2005-01-31
--

drop table dotlrn_catalog;
begin
  acs_rel_type.drop_type('dotlrn_catalog_rel');
  acs_rel_type.drop_role('dotlrn_com_role');
  acs_rel_type.drop_role('dotlrn_class_role');
  acs_rel_type.drop_role('d_catalog_role');
end;
/
show errors