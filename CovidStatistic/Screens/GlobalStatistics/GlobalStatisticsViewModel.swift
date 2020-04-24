//
//  GlobalStatisticsViewModel.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import Foundation
import Networking

protocol GlobalStatisticsView: AnyObject {
	func reloadScreen()
	func showActivityIndicator()
	func hideActivityIndicator()
}

protocol GlobalStatisticsViewModel {
	
	var view: GlobalStatisticsView? { get set }
	
	var brief: Brief? { get set }
	var countries: [Country] { get }
	
	var filterText: String { get set }
	
	func fetchData()
	
}

class GlobalStatisticsViewModelImplementation: GlobalStatisticsViewModel {

	weak var view: GlobalStatisticsView?
	
	var brief: Brief?
	
	var countriesData: [Country] = []
	
	var countries: [Country] {
		get {
			if !filterText.isEmpty {
				return countriesData.filter {
					$0.countrycode?.iso2?.lowercased().contains(filterText.lowercased()) ?? false ||
					$0.countrycode?.iso3?.lowercased().contains(filterText.lowercased()) ?? false ||
					$0.countryregion?.lowercased().contains(filterText.lowercased()) ?? false
				}
			} else {
				return countriesData
			}
		}
	}
	
	var filterText: String = ""
	
	func fetchData() {
		self.view?.showActivityIndicator()
		let group = DispatchGroup()
		
		group.enter()
		fetchCountryList {
			group.leave()
		}
		
		group.enter()
		fetchBrief {
			group.leave()
		}
		
		group.notify(queue: .main) { [weak self] in
			self?.view?.hideActivityIndicator()
			self?.view?.reloadScreen()
		}
	}
	
	private func fetchCountryList(completion: @escaping () -> Void) {
		let request = RequestFactory.latest(onlyCountries: true)
		NetworkClient.shared.send(request: request) { [weak self] result in
			switch result {
			case let .success(countries):
				self?.countriesData = countries
			case let .failure(error):
				print(error.localizedDescription)
			}
			completion()
		}
	}
	
	private func fetchBrief(completion: @escaping () -> Void) {
		let request = RequestFactory.brief()
		NetworkClient.shared.send(request: request) { [weak self] result in
			switch result {
			case let .success(brief):
				self?.brief = brief
			case let .failure(error):
				print(error.localizedDescription)
			}
			completion()
		}
	}
	
}
