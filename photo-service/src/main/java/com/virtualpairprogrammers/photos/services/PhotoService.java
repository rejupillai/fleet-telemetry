package com.virtualpairprogrammers.photos.services;

import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.stereotype.Service;

@Service
public class PhotoService
{
	
	
		private Map<String, String> drivers = Stream.of(new String[][] {
			{"Man Singh","https://storage.googleapis.com/indian-truck-drivers-image/mansingh.jpeg"},
			{"Pritam Singh","https://storage.googleapis.com/indian-truck-drivers-image/pritamsingh.jpeg"},
			{"Mandeep Singh","https://storage.googleapis.com/indian-truck-drivers-image/mandeepsingh.jpeg"},
			{"Mohd Sheik","https://storage.googleapis.com/indian-truck-drivers-image/mohdsheik.jpeg"},
			{"Dilip Kumar","https://storage.googleapis.com/indian-truck-drivers-image/dileepkumar.jpeg"}}).collect(Collectors.toMap(data -> data[0], data -> data[1]));



	public String getPhotoFor(String driverName) {
		return drivers.get(driverName);
	}

}
