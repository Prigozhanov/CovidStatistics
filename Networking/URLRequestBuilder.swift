//
//  RequestBuilder.swift
//  Networking
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import Foundation

class URLRequestBuilder<Response: Codable> {
	private let request: Request<Response>
	private let urlString: String
	
	init(request: Request<Response>) {
		self.request = request
		self.urlString = request.baseUrlString + request.path
	}
	
	var urlRequest: URLRequest {
		guard let url = URL(string: self.urlString) else {
			fatalError("\(urlString) is invalid url")
		}
		
		var urlRequest = URLRequest(url: url)
		
		urlRequest.httpMethod = "GET"
		
		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
			fatalError("\(urlString) is invalid url")
		}
		
		switch request.params {
		case let .query(values):
			let queryItems = values.map { URLQueryItem(name: $0.key, value: $0.value) }
			components.queryItems = (components.queryItems ?? []) + queryItems
		default:
			break
		}
		
		urlRequest.url = components.url
		
		return urlRequest
	}
	
}
