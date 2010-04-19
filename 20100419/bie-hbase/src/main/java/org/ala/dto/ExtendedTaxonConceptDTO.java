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
package org.ala.dto;

import java.util.List;
import org.ala.model.Classification;

import org.ala.model.CommonName;
import org.ala.model.ConservationStatus;
import org.ala.model.ExtantStatus;
import org.ala.model.Habitat;
import org.ala.model.Image;
import org.ala.model.PestStatus;
import org.ala.model.Reference;
import org.ala.model.SimpleProperty;
import org.ala.model.TaxonConcept;
import org.ala.model.TaxonName;
/**
 * A DTO that encapsulates all the information required to present a 
 * profile of a species. This is a heavy weight DTO.
 * 
 * @author Dave Martin (David.Martin@csiro.au)
 */
public class ExtendedTaxonConceptDTO {

	protected TaxonConcept taxonConcept;
	protected TaxonName taxonName;
    protected Classification classification;
	protected List<TaxonConcept> synonyms;
	protected List<CommonName> commonNames;
	protected List<TaxonConcept> childConcepts;
	protected List<TaxonConcept> parentConcepts;
	protected List<PestStatus> pestStatuses;
	protected List<ConservationStatus> conservationStatuses;
    protected List<SimpleProperty> simpleProperties;
	protected List<Image> images;
	protected List<ExtantStatus> extantStatusus;
	protected List<Habitat> habitats;
	protected List<RegionTypeDTO> regionTypes;
	protected List<Reference> references;

	/**
	 * @return the taxonConcept
	 */
	public TaxonConcept getTaxonConcept() {
		return taxonConcept;
	}
	/**
	 * @param taxonConcept the taxonConcept to set
	 */
	public void setTaxonConcept(TaxonConcept taxonConcept) {
		this.taxonConcept = taxonConcept;
	}
	/**
	 * @return the taxonName
	 */
	public TaxonName getTaxonName() {
		return taxonName;
	}
	/**
	 * @param taxonName the taxonName to set
	 */
	public void setTaxonName(TaxonName taxonName) {
		this.taxonName = taxonName;
	}
	/**
	 * @return the synonyms
	 */
	public List<TaxonConcept> getSynonyms() {
		return synonyms;
	}
	/**
	 * @param synonyms the synonyms to set
	 */
	public void setSynonyms(List<TaxonConcept> synonyms) {
		this.synonyms = synonyms;
	}
	/**
	 * @return the commonNames
	 */
	public List<CommonName> getCommonNames() {
		return commonNames;
	}
	/**
	 * @param commonNames the commonNames to set
	 */
	public void setCommonNames(List<CommonName> commonNames) {
		this.commonNames = commonNames;
	}
	/**
	 * @return the childConcepts
	 */
	public List<TaxonConcept> getChildConcepts() {
		return childConcepts;
	}
	/**
	 * @param childConcepts the childConcepts to set
	 */
	public void setChildConcepts(List<TaxonConcept> childConcepts) {
		this.childConcepts = childConcepts;
	}
	/**
	 * @return the parentConcepts
	 */
	public List<TaxonConcept> getParentConcepts() {
		return parentConcepts;
	}
	/**
	 * @param parentConcepts the parentConcepts to set
	 */
	public void setParentConcepts(List<TaxonConcept> parentConcepts) {
		this.parentConcepts = parentConcepts;
	}
	/**
	 * @return the pestStatus
	 */
	public List<PestStatus> getPestStatuses() {
		return pestStatuses;
	}
	/**
     * @param pestStatuses
     */
	public void setPestStatuses(List<PestStatus> pestStatuses) {
		this.pestStatuses = pestStatuses;
	}
	/**
	 * @return the conservationStatuses
	 */
	public List<ConservationStatus> getConservationStatuses() {
		return conservationStatuses;
	}
	/**
	 * @param conservationStatuses the conservationStatuses to set
	 */
	public void setConservationStatuses(
			List<ConservationStatus> conservationStatuses) {
		this.conservationStatuses = conservationStatuses;
	}
	/**
	 * @return the images
	 */
	public List<Image> getImages() {
		return images;
	}
	/**
	 * @param images the images to set
	 */
	public void setImages(List<Image> images) {
		this.images = images;
	}
    /**
     * @return the simpleProperties
     */
    public List<SimpleProperty> getSimpleProperties() {
        return simpleProperties;
    }
    /**
     * @param simpleProperties the simpleProperties to set
     */
    public void setSimpleProperties(List<SimpleProperty> simpleProperty) {
        this.simpleProperties = simpleProperty;
    }
	/**
	 * @return the regions
	 */
	public List<RegionTypeDTO> getRegionTypes() {
		return this.regionTypes;
	}
	/**
	 * @param regions the regions to set
	 */
	public void setRegionTypes(List<RegionTypeDTO> regionTypes) {
		this.regionTypes = regionTypes;
	}
	/**
	 * @return the extantStatusus
	 */
	public List<ExtantStatus> getExtantStatusus() {
		return this.extantStatusus;
	}
	/**
	 * @param extantStatusus the extantStatusus to set
	 */
	public void setExtantStatuses(List<ExtantStatus> extantStatusus) {
		this.extantStatusus = extantStatusus;
	}
	/**
	 * @return the habitats
	 */
	public List<Habitat> getHabitats() {
		return this.habitats;
	}
	/**
	 * @param habitats the habitats to set
	 */
	public void setHabitats(List<Habitat> habitats) {
		this.habitats = habitats;
	}
	/**
	 * @return the references
	 */
	public List<Reference> getReferences() {
		return references;
	}
	/**
	 * @param references the references to set
	 */
	public void setReferences(List<Reference> references) {
		this.references = references;
	}

    public Classification getClassification() {
        return classification;
    }

    public void setClassification(Classification classification) {
        this.classification = classification;
    }
}
