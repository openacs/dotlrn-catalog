-- DotLRN Catalog Relation Model
-- author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
-- creation-date 2005-01-31


create function inline_0 ()
returns integer as '
begin
  PERFORM acs_rel_type__create_role(''d_catalog_role'', ''DotLRN Catalog Role'', ''DotLRN Catalog Role'');
  PERFORM acs_rel_type__create_role(''dotlrn_class_role'', ''dotLRN Class Role'', ''dotLRN Class Role'');
  PERFORM acs_rel_type__create_role(''dotlrn_com_role'', ''dotLRN Community Role'', ''dotLRN Community Role'');

  return 0;		
end;' language 'plpgsql';

select inline_0 ();

drop function inline_0 ();