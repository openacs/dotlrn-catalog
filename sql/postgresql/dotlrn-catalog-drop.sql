--
--
-- author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
-- creation-date 2005-01-31
--

select acs_rel_type__drop_type('dotlrn_catalog_rel', 'f');
select acs_rel_type__drop_role('dotlrn_com_role');
select acs_rel_type__drop_role('dotlrn_class_role');
select acs_rel_type__drop_role('d_catalog_role');
drop table dotlrn_catalog;