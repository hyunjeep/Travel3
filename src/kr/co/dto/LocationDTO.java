package kr.co.dto;

import java.io.Serializable;

public class LocationDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int locationCode;
	private String locationName;
	
	public LocationDTO() {
		// TODO Auto-generated constructor stub
	}

	public LocationDTO(int locationCode, String locationName) {
		super();
		this.locationCode = locationCode;
		this.locationName = locationName;
	}

	public int getLocationCode() {
		return locationCode;
	}

	public void setLocationCode(int locationCode) {
		this.locationCode = locationCode;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
