package com.virtualpairprogrammers.staffmanagement.services;

import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.stereotype.Service;

import com.virtualpairprogrammers.staffmanagement.domain.StaffRecord;

@Service
public class StaffService
{
	private Map<String, String> drivers = Stream.of(new String[][] {
		{"Purani Dilli Trucking", "Man Singh"},
	    {"Amritsar Packers", "Pritam Singh"},
	    {"Worli Packers", "Mandeep Singh"},
	    {"Namma Bengaluru Logistics", "Mohd Sheik"},
	    {"Jammu Carriers", "Dilip Kumar"}}).collect(Collectors.toMap(data -> data[0], data -> data[1]));
	
	private Map<String, String> photos = Stream.of(new String[][] {
		{"Man Singh","https://storage.googleapis.com/indian-truck-drivers-image/mansingh.jpeg"},
	    {"Pritam Singh","https://storage.googleapis.com/indian-truck-drivers-image/pritamsingh.jpeg"},
	    {"Mandeep Singh","https://storage.googleapis.com/indian-truck-drivers-image/mandeepsingh.jpeg"},
	    {"Mohd Sheik","https://storage.googleapis.com/indian-truck-drivers-image/mohdsheik.jpeg"},
	    {"Dilip Kumar","https://storage.googleapis.com/indian-truck-drivers-image/dileepkumar.jpeg"}}).collect(Collectors.toMap(data -> data[0], data -> data[1]));
	
	
	public StaffRecord getDriverDetailsFor(String vehicleName) 
	{
		String driverName = drivers.get(vehicleName);
		String staffPhoto = photos.get(driverName);
		return new StaffRecord(driverName, staffPhoto);
	}

}
