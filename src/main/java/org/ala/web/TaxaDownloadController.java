/**************************************************************************
 *  Copyright (C) 2010 Atlas of Living Australia
 *  All Rights Reserved.
 *
 *  The contents of this file are subject to the Mozilla Public
 *  License Version 1.1 (the "License"); you may not use this file
 *  except in compliance with the License. You may obtain a copy of
 *  the License at http://www.mozilla.org/MPL/
 *
 *  Software distributed under the License is distributed on an "AS
 *  IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 *  implied. See the License for the specific language governing
 *  rights and limitations under the License.
 ***************************************************************************/

/**
 * create/download csv file for lower taxon.
 * 
 * @author mok011
 */
package org.ala.web;

import java.io.OutputStreamWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.ala.dao.FulltextSearchDao;
import org.ala.dao.TaxonConceptDao;
import org.ala.dto.ExtendedTaxonConceptDTO;
import org.ala.dto.SearchTaxonConceptDTO;
import org.ala.dto.SpeciesProfileDTO;
import org.ala.model.CommonName;
import org.ala.model.Document;
import org.ala.model.Image;
import org.ala.model.TaxonConcept;
import org.ala.repository.Predicates;
import org.ala.web.admin.dao.ImageUploadDao;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import au.com.bytecode.opencsv.CSVWriter;
import au.org.ala.data.model.LinnaeanRankClassification;
import au.org.ala.data.util.RankType;

@Controller
public class TaxaDownloadController {
	/** Logger initialisation */
	private final static Logger logger = Logger.getLogger(TaxaDownloadController.class);
	/** DAO bean for access to taxon concepts */
	@Inject
	private TaxonConceptDao taxonConceptDao;
	/** DAO bean for SOLR search queries */
	@Inject
	private FulltextSearchDao searchDao;
	@Inject
    protected RepoUrlUtils repoUrlUtils;
    @Inject
    protected ImageUploadDao imageUploadDao;	
	
    /**
     * get taxaDownload home page.
     * 
     * @return
     */
	@RequestMapping("/taxaDownloadPage")
	public String homePageHandler() {
		return "download/taxaDownload";
	}

	private int handleMultiTaxa(String higherTaxon, CSVWriter csvWriter) throws Exception{
		int resultsCount = 0;
				
		String[] taxa = higherTaxon.trim().split("\n");
		if(taxa == null || taxa.length < 1){
			return resultsCount;
		}
		
		for(int i = 0; i < taxa.length; i++){	
			ExtendedTaxonConceptDTO etc = null;
			if (taxa[i].trim().matches("(urn\\:lsid[a-zA-Z\\-0-9\\:\\.]*)") || taxa[i].trim().matches("([0-9]*)")) {
				etc = taxonConceptDao.getExtendedTaxonConceptByGuid(taxa[i].trim());
			} 
			else {
				// higherTaxon == sciName and kingkom?
				String lsid = getLsidByNameAndKingdom(taxa[i].trim());
				if (lsid != null && lsid.length() > 0) {
					etc = taxonConceptDao.getExtendedTaxonConceptByGuid(lsid);
				}
			}
	
			
			if (etc == null || etc.getTaxonConcept() == null || etc.getTaxonConcept().getGuid() == null) {
				// no match for the parameter, redirect to search page.
				// return "download/taxaDownload";
			}
			else{
				TaxonConcept tc = etc.getTaxonConcept();
				
				List<Image> images = etc.getImages();
				String imageUrl = "";
				String imagePath = "";
				if(images != null && images.size() > 0){
					imagePath = images.get(0).getRepoLocation();
					imageUrl = repoUrlUtils.fixSingleUrl(imagePath);
				}
				
            	Document doc = null;
            	if(imagePath != null && imagePath.length() > 0){
            		// biuld image path
            		int idx = imagePath.toLowerCase().indexOf("raw");
            		if(idx < 0){
            			idx = imagePath.toLowerCase().indexOf("thumbnail");
            		}
            		// create new Document with image url only for imageUploadDao.readDcFile(doc)
            		if(idx > 0){
            			doc = new Document();
            			doc.setFilePath(imagePath.substring(0, idx));
            		}
            	}
            	
            	String commonName = "";
            	List<CommonName> commonNames = etc.getCommonNames();
            	if(commonNames != null && commonNames.size() > 0){
            		commonName = commonNames.get(0).getNameString();
            	}
            	
            	String creator = "";
            	String rights = "";
            	String description = "";
            	String source = "";
            	
            	
            	try{
            		Map<String, String> dc = imageUploadDao.readDcFile(doc);
	            	if(dc != null){
	            		creator = dc.get(Predicates.DC_CREATOR.toString());
	            		rights = dc.get(Predicates.DC_RIGHTS.toString());
	            		source = dc.get(Predicates.DC_SOURCE.toString());
	            		description = dc.get(Predicates.DC_DESCRIPTION.toString());
	            	}
	            	String[] record = new String[]{
	                		tc.getGuid(),
	                		tc.getNameString(),
	                		RankType.getForId(tc.getRankID()).name(),
	                		commonName,
	                		imageUrl,
	                		creator,
	                		rights,
	                		description,
	                		source,
	                	};
	                	csvWriter.writeNext(record);
	                	csvWriter.flush();
	                	resultsCount++;
            	}
            	catch(Exception ex){
            		logger.error(ex);
            	}           	
            }
		}
		return resultsCount;
	}
	
	private int handleSingleTaxa(String higherTaxon, CSVWriter csvWriter) throws Exception{
		ExtendedTaxonConceptDTO etc = null;
		int resultsCount = 0;
		
		if (higherTaxon.matches("(urn\\:lsid[a-zA-Z\\-0-9\\:\\.]*)") || higherTaxon.matches("([0-9]*)")) {
			etc = taxonConceptDao.getExtendedTaxonConceptByGuid(higherTaxon);
		} 
		else {
			// higherTaxon == sciName and kingkom?
			String lsid = getLsidByNameAndKingdom(higherTaxon);
			if (lsid != null && lsid.length() > 0) {
				etc = taxonConceptDao.getExtendedTaxonConceptByGuid(lsid);
			}
		}

		
		if (etc == null || etc.getTaxonConcept() == null || etc.getTaxonConcept().getGuid() == null) {
			// no match for the parameter, redirect to search page.
			// return "download/taxaDownload";
		}
		else{
			TaxonConcept tc = etc.getTaxonConcept();
			// load child concept using search indexes
			List<SearchTaxonConceptDTO> childConcepts = searchDao.getChildConceptsByNS(tc.getLeft(), tc.getRight(), RankType.SPECIES.getId(), 1000000);
			childConcepts.addAll(searchDao.getChildConceptsByNS(tc.getLeft(), tc.getRight(), RankType.SUBSPECIES.getId(), 1000000));
			// Reorder the children concepts so that ordering is based on rank followed by name
			Collections.sort(childConcepts, new TaxonRankNameComparator());
                        
            for(SearchTaxonConceptDTO concept : childConcepts){
            	Document doc = null;
            	String imagePath = concept.getImage();
            	String imageUrl = "";
            	if(imagePath != null && imagePath.length() > 0){
            		// biuld image path
            		imageUrl = repoUrlUtils.fixSingleUrl(imagePath);
            		int idx = imagePath.toLowerCase().indexOf("raw");
            		if(idx < 0){
            			idx = imagePath.toLowerCase().indexOf("thumbnail");
            		}
            		// create new Document with image url only for imageUploadDao.readDcFile(doc)
            		if(idx > 0){
            			doc = new Document();
            			doc.setFilePath(imagePath.substring(0, idx));
            		}
            	}
            	
            	
            	String creator = "";
            	String rights = "";
            	String description = "";
            	String source = "";
            	try{
            		Map<String, String> dc = imageUploadDao.readDcFile(doc);
	            	if(dc != null){
	            		creator = dc.get(Predicates.DC_CREATOR.toString());
	            		rights = dc.get(Predicates.DC_RIGHTS.toString());
	            		source = dc.get(Predicates.DC_SOURCE.toString());
	            		description = dc.get(Predicates.DC_DESCRIPTION.toString());
	            	}
	            	String[] record = new String[]{
	                		concept.getGuid(),
	                		concept.getName(),
	                		concept.getRank(),
	                		concept.getCommonNameSingle(),
	                		imageUrl,
	                		creator,
	                		rights,
	                		description,
	                		source,
	                	};
	                	csvWriter.writeNext(record);
	                	csvWriter.flush();
	                	resultsCount++;
            	}
            	catch(Exception ex){
            		logger.error(ex);
            	}           	
            }
		}
		return resultsCount;
	}
	@RequestMapping(value = "/taxaProfileDownload", method = RequestMethod.GET)
	public void downloadAllTaxaProfile(HttpServletResponse response) throws Exception{
	    response.setHeader("Cache-Control", "must-revalidate");
        response.setHeader("Pragma", "must-revalidate");
        response.setHeader("Content-Disposition", "attachment;filename=taxon_profile.csv");
        response.setContentType("text/csv");
        
        ServletOutputStream output = response.getOutputStream();

        CSVWriter csvWriter = new CSVWriter(new OutputStreamWriter(output), '\t', '"');
        try{
            csvWriter.writeNext(new String[]{
                    "GUID",
                    "Scientific Name",
                    "Left",
                    "Right",
                    "Rank",
                    "Common Name",
                    "Conservation Status",
                    "Sensitive Status"
            });
            String startKey = "";
            int pageSize = 100;
            
            List<SpeciesProfileDTO> profiles = taxonConceptDao.getProfilePage(startKey, pageSize);
            while(profiles != null && profiles.size()>0){
                for(SpeciesProfileDTO profile : profiles){
                    String[] values = new String[]{
                      profile.getGuid(),      
                      profile.getScientificName(),
                      profile.getLeft(),
                      profile.getRight(),
                      profile.getRank(),
                      profile.getCommonName(),
                      StringUtils.join(profile.getHabitats(),(",")),
                      StringUtils.join(profile.getConservationStatus(),(",")),
                      StringUtils.join(profile.getSensitiveStatus(),(","))
                      
                    };
                    csvWriter.writeNext(values);
                    startKey = profile.getGuid();
                }
                profiles = taxonConceptDao.getProfilePage(startKey, pageSize);
            }
        }
        catch (Exception e) {
            logger.error(e);
        }
        finally{
            if(csvWriter != null){
                csvWriter.flush();
                csvWriter.close();
            }
        }
	}
	
	/**
	 * search for lower taxon and create csv file.
	 * 
	 * @param higherTaxon
	 * @param response
	 * @return csv format file
	 * @throws Exception
	 */
	@RequestMapping(value = "/taxaDownload", method = RequestMethod.GET)
	public String downloadSpeciesList(
			@RequestParam(value = "higherTaxon", required = false) String higherTaxon,
			@RequestParam(value = "isMultiple", required = false) boolean isMultiple,
			HttpServletResponse response) throws Exception {
		int resultsCount = 0;
		CSVWriter csvWriter = null;		
		try {
			if (higherTaxon == null || higherTaxon.length() < 1) {
				// no match for the parameter, redirect to search page.
				return "download/taxaDownload";
			}

			response.setHeader("Cache-Control", "must-revalidate");
			response.setHeader("Pragma", "must-revalidate");
			response.setHeader("Content-Disposition", "attachment;filename=" + System.currentTimeMillis());
			response.setContentType("text/csv");
			ServletOutputStream output = response.getOutputStream();

            csvWriter = new CSVWriter(new OutputStreamWriter(output), ',', '"');            
            csvWriter.writeNext(new String[]{
            		"GUID",
            		"Scientific name",
            		"Taxon rank",
            		"Common name",
            		"ImageUrl",
            		"Creator",
            		"Rights",
            		"Description",
            		"Source"
            });
			
			if(isMultiple){
				resultsCount = handleMultiTaxa(higherTaxon, csvWriter);
			}
			else{
				resultsCount =  handleSingleTaxa(higherTaxon, csvWriter);
			}			
	        logger.debug("***** record counter: " + resultsCount);
		} 
		catch (Exception e) {
			logger.error(e);
		}
		finally{
			if(csvWriter != null){
				csvWriter.flush();
				csvWriter.close();
			}
		}
		return null;
	}

	private String getLsidByNameAndKingdom(String parameter) {
		String lsid = null;
		String name = null;
		String kingdom = null;

		name = extractScientificName(parameter);
		kingdom = extractKingdom(parameter);
		if (kingdom != null) {
			LinnaeanRankClassification cl = new LinnaeanRankClassification(
					kingdom, null);
			cl.setScientificName(name);
			lsid = taxonConceptDao.findLsidByName(cl.getScientificName(), cl,
					null);
		}

		if (lsid == null || lsid.length() < 1) {
			lsid = taxonConceptDao.findLSIDByCommonName(name);
		}

		if (lsid == null || lsid.length() < 1) {
			lsid = taxonConceptDao.findLSIDByConcatName(name);
		}

		if (lsid == null || lsid.length() < 1) {
			lsid = taxonConceptDao.findLsidByName(name);
		}
		return lsid;
	}

	private String extractScientificName(String parameter) {
		String name = null;

		int i = parameter.indexOf('(');
		if (i >= 0) {
			name = parameter.substring(0, i);
		} else {
			name = parameter;
		}
		name = name.replaceAll("_", " ");
		name = name.replaceAll("\\+", " ");
		name = name.trim();

		return name;
	}

	private String extractKingdom(String parameter) {
		String kingdom = null;

		int i = parameter.indexOf('(');
		int j = parameter.indexOf(')');
		if (i >= 0 && j >= 0 && j > i) {
			kingdom = parameter.substring(i + 1, j);
			kingdom = kingdom.trim();
		}
		return kingdom;
	}

	protected class TaxonRankNameComparator implements Comparator<SearchTaxonConceptDTO> {
		@Override
		public int compare(SearchTaxonConceptDTO t1, SearchTaxonConceptDTO t2) {
			if (t1 != null && t1 != null) {
				if (t1.getRankId() != t2.getRankId()) {
					return t1.getRankId() - t2.getRankId();
				} else {
					return t1.compareTo(t2);
				}
			}
			return 0;
		}
	}

}
