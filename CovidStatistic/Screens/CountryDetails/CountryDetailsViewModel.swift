//
//  CountryDetailsViewModel.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import Foundation
import Networking

protocol CountryDetailsView: AnyObject {
	func reloadScreen()
	func updateChartData()
	func showActivityIndicator()
	func hideActivityIndicator()
}

protocol CountryDetailsViewModel {
	
	var view: CountryDetailsView? { get set }
	
	var country: Country { get set }
	var dates: [Date] { get }
	
	func fetchTimeseries()
}

class CountryDetailsViewModelImplementation: CountryDetailsViewModel {
	
	weak var view: CountryDetailsView?
	
	var country: Country
	
	var dates: [Date] = []
	
	init(country: Country) {
		self.country = country
	}
	
	func fetchTimeseries() {
		view?.showActivityIndicator()
		let request = RequestFactory.timeseries(iso2: country.countrycode?.iso2 ?? "")
		NetworkClient.shared.send(request: request) { [weak self] result in
			switch result {
			case let .success(countries):
				guard let country = countries.first else {
					return
				}
				self?.country = country
				
				guard let keys = country.timeseries?.keys else {
					return
				}
				self?.dates = Array(keys).compactMap { dateString -> Date? in
					return Date.fromString(dateString)
				}.sorted(by: >)
				self?.view?.reloadScreen()
				self?.view?.updateChartData()
			case let .failure(error):
				print(error.localizedDescription)
			}
			
			self?.view?.hideActivityIndicator()
		}
	}
	
}
