/***************************************************************************
 * Copyright (C) 2010 Atlas of Living Australia
 * All Rights Reserved.
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package org.ala.dao;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;

import org.ala.model.Ranking;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

/**
 * Simple ranking DAO implementation
 *
 * @author Dave Martin (David.Martin@csiro.au)
 */
@Component("rankingDao")
public class RankingDaoImpl implements RankingDao {

	private final static Logger logger = Logger.getLogger(RankingDaoImpl.class);
	@Inject
	protected StoreHelper storeHelper;
	
	@Inject
	protected TaxonConceptDao taxonConceptDao;
	
	public boolean rankImageForTaxon(
			String userIP,
			String userId,
			String fullName,
			String taxonGuid, 
			String scientificName, 
			String imageUri,
			Integer imageInfoSourceId,
			boolean positive) throws Exception {
		return this.rankImageForTaxon(userIP, userId, fullName, taxonGuid, scientificName, imageUri, imageInfoSourceId, false, positive);
	}
	
	/**
	 * @see org.ala.dao.RankingDao#rankImageForTaxon(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Integer, boolean)
	 */
	@Override
	public boolean rankImageForTaxon(
			String userIP,
			String userId,
			String fullName,
			String taxonGuid, 
			String scientificName, 
			String imageUri,
			Integer imageInfoSourceId,
			boolean blackList,
			boolean positive) throws Exception {
			
		Ranking r = new Ranking();
		if(blackList){
			r.setBlackListed(blackList);
		}
		else{
			r.setPositive(positive);
		}
		
		r.setUri(imageUri);
		r.setUserId(userId);
		r.setFullName(fullName);
		r.setUserIP(userIP);
		
		//store the ranking event
		logger.debug("Storing the rank event...");
		storeHelper.put("rk", "rk", "image", ""+System.currentTimeMillis(), taxonGuid, r);
		logger.debug("Updating the images ranking...");
		taxonConceptDao.setRankingOnImage(taxonGuid, imageUri, positive, blackList);
		logger.debug("Finished updating ranking");
		
		return true;
	}
        /**
         * @see org.ala.dao.RankingDao#reloadImageRanks() 
         */
        public void reloadImageRanks(){
            try{
                System.out.println("Initialising the scanner...");
                Scanner scanner = storeHelper.getScanner("bie", "rk", "image");
                byte[] guidAsBytes = null;
                while((guidAsBytes = scanner.getNextGuid()) != null){
                    String guid = new String(guidAsBytes);
                    //TODO in the future when LSIDs have potentially changed we will need to look up in an index to find the LSID that is being used
                    logger.debug("Processing Image ranks for " +guid);
                    //get the rankings for the current guid
                    Map<String, Object> subcolumns =  storeHelper.getSubColumnsByGuid("rk", "image",guid);
                    Map<String, Integer[]> counts = new java.util.HashMap<String, Integer[]>();
                    
                    for(String key : subcolumns.keySet()){
                        //logger.debug(guid + " :  key : "+ key);
                        List<Ranking> lr = (List<Ranking>) subcolumns.get(key);
                        //sort the rankings based on the URI for the image
                        Collections.sort(lr, new Comparator<Ranking>() {

                            @Override
                            public int compare(Ranking o1, Ranking o2) {
                                return o1.getUri().compareTo(o2.getUri());
                            }
                        });
                        
                        for(Ranking r : lr){
                            Integer[] c = counts.get(r.getUri());
                            if(c == null){
                                c = new Integer[]{0,0};
                                counts.put(r.getUri(), c);
                            }
                            c[0] = c[0]+1;
                            if(r.isPositive())
                                c[1] = c[1] +1;
                            else
                                c[1] = c[1] -1;
                
                            
                        }
                    }
                    for(String uri: counts.keySet()){
                        Integer[] c = counts.get(uri);
                        logger.debug("Updating guid: "+ guid + " for image: " + uri + " with count " + c[0] + " overall rank " + c[1]);
                        taxonConceptDao.setRankingOnImages(guid, counts);
                    }
                }
            }
            catch(Exception e){
                e.printStackTrace();
            }
        }

	/**
	 * @param storeHelper the storeHelper to set
	 */
	public void setStoreHelper(StoreHelper storeHelper) {
		this.storeHelper = storeHelper;
	}

	/**
	 * @param taxonConceptDao the taxonConceptDao to set
	 */
	public void setTaxonConceptDao(TaxonConceptDao taxonConceptDao) {
		this.taxonConceptDao = taxonConceptDao;
	}
}
