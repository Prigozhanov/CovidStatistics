//
//  NetworkClient.swift
//  Networking
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import Foundation

public class NetworkClient {
	
	public static let shared = NetworkClient()
	
	public enum Error: String, Swift.Error {
		case unknownError
		case parsingError
		case serverSideError
		case missingData
	}
	
	private let sessionQueue: OperationQueue
	private let session: URLSession
	
	private init() {
		sessionQueue = OperationQueue()
		session = URLSession(configuration: .default, delegate: nil, delegateQueue: sessionQueue)
	}
	
	public func send<Response: Codable>(request: Request<Response>, completion: @escaping (Result<Response, Error>) -> Void)  {
		let urlRequest = URLRequestBuilder(request: request).urlRequest
		
		session.dataTask(with: urlRequest) { (data, response, error) in
			guard let response = response as? HTTPURLResponse else {
				return
			}
			
			let successClosure: (Response) -> Void = { response in
				DispatchQueue.main.async {
					completion(.success(response))
				}
			}
			
			let failureClosure: (Error) -> Void = { error in
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
	
			switch response.statusCode {
			case 200 ..< 300:
				do {
					let jsonDecoder = JSONDecoder()
					guard let data = data else {
						failureClosure(Error.missingData)
						return
					}
					let jsonResponse = try jsonDecoder.decode(Response.self, from: data)
					successClosure(jsonResponse)
				} catch {
					failureClosure(Error.parsingError)
				}
			case 500:
				failureClosure(Error.serverSideError)
			default:
				failureClosure(Error.unknownError)
			}
			
		}.resume()
	}
	
}
