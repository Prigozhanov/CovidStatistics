//
//  ViewController.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit

class GlobalStatisticsViewController: UITableViewController {
	
	private var viewModel: GlobalStatisticsViewModel
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.style = .large
		indicator.hidesWhenStopped = true
		return indicator
	}()
	
	init(viewModel: GlobalStatisticsViewModel) {
		self.viewModel = viewModel
		
		super.init(style: .plain)
		
		self.tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.Identifier)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.view = self
		
		title = "Global Statistics"
		
		navigationItem.searchController = UISearchController()
		navigationItem.searchController?.searchBar.delegate = self
		navigationItem.searchController?.searchResultsUpdater = self
		navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
		
		view.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
		
		viewModel.fetchData()
	}
	
	@objc private func scrollToTop() {
		tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
	}
	
}

extension GlobalStatisticsViewController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.countries.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.Identifier, for: indexPath) as! CountryCell
		let country = viewModel.countries[indexPath.item]
		cell.configure(
			item: CountryCell.Item(
				iso2CountryCode: country.countrycode?.iso2 ?? "",
				title: (country.countryregion ?? "Unknown"),
				confirmed: country.confirmed ?? 0,
				deaths: country.deaths ?? 0,
				recovered: country.recovered ?? 0
			)
		)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = CountryDetailsViewController(
			viewModel: CountryDetailsViewModelImplementation(country: viewModel.countries[indexPath.item])
		)
		navigationController?.pushViewController(vc, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return traitCollection.verticalSizeClass == .regular ? 100 : 70
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = GlobalStatisticsSectionHeaderView(
			item: GlobalStatisticsSectionHeaderView.Item(
				confirmed: viewModel.brief?.confirmed ?? 0,
				deaths: viewModel.brief?.deaths ?? 0,
				recovered: viewModel.brief?.recovered ?? 0
			)
		)
		header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToTop)))
		return header
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return traitCollection.verticalSizeClass == .regular ? 120 : 60
	}
	
}

extension GlobalStatisticsViewController: UISearchBarDelegate {
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		viewModel.filterText = ""
		reloadScreen()
	}
}

extension GlobalStatisticsViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let searchText = searchController.searchBar.text else { return }
		
		viewModel.filterText = searchText
		
		reloadScreen()
	}
}

extension GlobalStatisticsViewController: GlobalStatisticsView {
	func reloadScreen() {
		tableView.reloadData()
	}
	
	func showActivityIndicator() {
		activityIndicator.startAnimating()
	}
	
	func hideActivityIndicator() {
		activityIndicator.stopAnimating()
	}
}
