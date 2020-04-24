//
//  Requests.swift
//  Networking
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import Foundation

public struct Request<Response: Codable> {
	
	public init(baseUrlString: String, path: String, params: Request<Response>.Params) {
		self.baseUrlString = baseUrlString
		self.path = path
		self.params = params
	}
	
	public enum Params {
		case none
		case query([String : String])
	}
	
	public let baseUrlString: String
	public let path: String
	public let params: Params
	
}

public class RequestFactory {
	
	private static let baseUrlString = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai"
	
	public static func brief() -> Request<Brief> {
		return Request<Brief>(
			baseUrlString: baseUrlString,
			path: "/jhu-edu/brief",
			params: .none)
	}
	
	public static func latest(onlyCountries: Bool) -> Request<[Country]> {
		return Request<[Country]>(
			baseUrlString: baseUrlString,
			path: "/jhu-edu/latest",
			params: .query([
				"onlyCountries" : "\(onlyCountries)"
			])
		)
	}
	
	public static func timeseries(iso2: String) -> Request<[Country]> {
		return Request<[Country]>(
			baseUrlString: baseUrlString,
			path: "/jhu-edu/timeseries",
			params: .query([
				"iso2" : iso2,
				"onlyCountries" : "true"
			])
		)
	}
	
}
