-- Export IRMNG data from MySQL DB irmng20091116 on alaslvdb1-cbr.vm.csiro.au
--
-- IRMNG Family extant and habitat data

select family_id, family, kingdom, fam_extant_flag, fam_habitat_flag from MASTER_FAMLIST
where fam_extant_flag != 'F'
order by family
into outfile '/data/bie-staging/irmng/family_list.txt'
fields enclosed by '"';

-- IRMNG Genus extant and habitat data

select genus_id, genus, family, gen_extant_flag, gen_habitat_flag from MASTER_GENLIST
where gen_extant_flag != 'F'
order by genus
into outfile '/data/bie-staging/irmng/genus_list.txt'
fields enclosed by '"';

-- IRMNG Species extant and habitat data

select species_id, concat(g.genus, ' ', species), concat(genus_orig, ' ', species), sp_extant_flag, sp_habitat_flag from MASTER_SPLIST sp, MASTER_GENLIST g
where sp_extant_flag != 'F' and sp.genus_id=g.genus_id
order by g.genus, species
into outfile '/data/bie-staging/irmng/species_list.txt'
fields enclosed by '"';