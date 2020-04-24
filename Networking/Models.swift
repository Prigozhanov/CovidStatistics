//
//  Models.swift
//  Networking
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import Foundation

//MARK: - Brief
public struct Brief: Codable {
	public let confirmed, deaths, recovered: Int?
	
	public init(confirmed: Int?, deaths: Int?, recovered: Int?) {
		self.confirmed = confirmed
		self.deaths = deaths
		self.recovered = recovered
	}
}

// MARK: - Country
public struct Country: Codable {
	public let countryregion, lastupdate: String?
	public let location: Location?
	public let countrycode: Countrycode?
	public let confirmed, deaths, recovered: Int?
	public let timeseries: [String: Timeseries]?
	
	public init(countryregion: String?, lastupdate: String?, location: Location?, countrycode: Countrycode?, confirmed: Int?, deaths: Int?, recovered: Int?, timeseries: [String: Timeseries]?) {
		self.countryregion = countryregion
		self.lastupdate = lastupdate
		self.location = location
		self.countrycode = countrycode
		self.confirmed = confirmed
		self.deaths = deaths
		self.recovered = recovered
		self.timeseries = timeseries
	}
}

// MARK: - Countrycode
public struct Countrycode: Codable {
	public let iso2, iso3: String?
	
	public init(iso2: String?, iso3: String?) {
		self.iso2 = iso2
		self.iso3 = iso3
	}
}

// MARK: - Location
public struct Location: Codable {
	public let lat, lng: Double?
	
	public init(lat: Double?, lng: Double?) {
		self.lat = lat
		self.lng = lng
	}
}

// MARK: - Timeseries
public struct Timeseries: Codable {
	public let confirmed, deaths, recovered: Int?
	
	public init(confirmed: Int?, deaths: Int?, recovered: Int?) {
		self.confirmed = confirmed
		self.deaths = deaths
		self.recovered = recovered
	}
}
