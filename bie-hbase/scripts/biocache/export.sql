-- Export Occurrence data from MySQL DB portal on alaproddb1-cbr.vm.csiro.au

-- Export the data provider 
select tc.guid, dp.uid, dp.name, count(*)  as occurrences from occurrence_record oc
inner join taxon_concept tc on tc.id=oc.taxon_concept_id
inner join data_provider dp on dp.id = oc.data_provider_id
where tc.rank>=7000 and tc.priority <>100
group by tc.id, dp.id
into outfile '/data/bie-staging/biocache/tc_dp.txt'
fields enclosed by '"';


-- Subspecies occurrences by region - species id, species name, region, region_type, no of occurrences
select tc.guid, grt.name, gr.id, gr.name, gr.region_type, count(oc.id) as occurrences from occurrence_record oc
inner join geo_mapping gm on gm.occurrence_id=oc.id
inner join geo_region gr on gm.geo_region_id=gr.id
inner join geo_region_type grt on gr.region_type=grt.id
inner join taxon_concept tc on tc.id=oc.taxon_concept_id
where tc.rank>7000 and tc.priority<>100
group by tc.id, gr.id
into outfile '/data/bie-staging/biocache/subspecies_region.txt'
fields enclosed by '"';


-- Species occurrences by region - species id, species name, region, region_type, no of occurrences
select tc.guid, grt.name, gr.id, gr.name, gr.region_type, count(oc.id) as occurrences from occurrence_record oc
inner join geo_mapping gm on gm.occurrence_id=oc.id
inner join geo_region gr on gm.geo_region_id=gr.id
inner join geo_region_type grt on gr.region_type=grt.id
inner join taxon_concept tc on tc.id=oc.taxon_concept_id
where tc.rank=7000
and tc.priority <> 100
group by tc.id, gr.id
into outfile '/data/bie-staging/biocache/species_region.txt'
fields enclosed by '"';


-- Genus occurrences by region - genus id, genus name, region, region_type, no of occurrences
select tc.guid, grt.name, gr.id, gr.name, gr.region_type, count(*) as occurrences from occurrence_record oc
inner join geo_mapping gm on gm.occurrence_id=oc.id
inner join geo_region gr on gm.geo_region_id=gr.id
inner join geo_region_type grt on gr.region_type=grt.id
inner join taxon_concept tc on tc.id=oc.genus_concept_id
where tc.priority <> 100
group by tc.id, gr.id
into outfile '/data/bie-staging/biocache/genus_region.txt'
fields enclosed by '"';


-- Family occurrences by region - family id, family name, region, region_type, no of occurrences
select tc.guid, grt.name, gr.id, gr.name, gr.region_type, count(*) as occurrences from occurrence_record oc
inner join geo_mapping gm on gm.occurrence_id=oc.id
inner join geo_region gr on gm.geo_region_id=gr.id
inner join geo_region_type grt on gr.region_type=grt.id
inner join taxon_concept tc on tc.id=oc.family_concept_id
where tc.priority <> 100
group by tc.id, gr.id
into outfile '/data/bie-staging/biocache/family_region.txt'
fields enclosed by '"';

-- Export the occurrence count information

select tc.guid, count(*) as occurrences from occurrence_record oc
inner join taxon_concept tc on oc.taxon_concept_id = tc.id
inner join data_resource dr on oc.data_resource_id = dr.id
where tc.priority <>100 and dr.release_flag
group by tc.guid
into outfile '/data/bie-staging/biocache/taxa_occurrence_count.txt'
fields enclosed by '"';

-- Export the georeferenced occurrence count information

select tc.guid, count(*) as occurrences from occurrence_record oc
inner join taxon_concept tc on oc.taxon_concept_id = tc.id
inner join data_resource dr on oc.data_resource_id = dr.id
where tc.priority <>100 and dr.release_flag and oc.cell_id is not NULL
group by tc.guid
into outfile '/data/bie-staging/biocache/taxa_georef_occurrence_count.txt'
fields enclosed by '"';


-- subspecies, species, genus, family, order
-- retrieve a count of specimens per species
-- retrieve a count of observations per species
-- retrieve a count of observations/specimens with coordinates per species
-- retrieve type specimens per species, genus, and subspecies