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
package org.ala.dto;

/**
 * A search DTO for regions.
 *
 * @author Dave Martin (David.Martin@csiro.au)
 */
public class SearchRegionDTO extends SearchDTO {

	protected String acronym;
	protected String regionTypeName;
	/**
	 * @return the acronym
	 */
	public String getAcronym() {
		return acronym;
	}
	/**
	 * @param acronym the acronym to set
	 */
	public void setAcronym(String acronym) {
		this.acronym = acronym;
	}
	/**
	 * @return the regionTypeName
	 */
	public String getRegionTypeName() {
		return regionTypeName;
	}
	/**
	 * @param regionTypeName the regionTypeName to set
	 */
	public void setRegionTypeName(String regionTypeName) {
		this.regionTypeName = regionTypeName;
	}
}
