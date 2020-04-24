//
//  CountryDertails.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit
import Charts

class CountryDetailsViewController: UIViewController {
	
	var viewModel: CountryDetailsViewModel
	
	private lazy var countryInfoView: CountryInfoView = {
		let view = CountryInfoView(
			item: CountryInfoView.Item(
				iso2CountryCode: viewModel.country.countrycode?.iso2 ?? "",
				title: viewModel.country.countryregion ?? "",
				confirmed: viewModel.country.confirmed ?? 0,
				deaths: viewModel.country.deaths ?? 0,
				recovered: viewModel.country.recovered ?? 0
			)
		)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private lazy var chartView: ChartView = {
		let view = ChartView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(TimeseriesCell.self, forCellReuseIdentifier: TimeseriesCell.Identifier)
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.style = .large
		indicator.hidesWhenStopped = true
		return indicator
	}()
	
	init(viewModel: CountryDetailsViewModel) {
		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor(named: "background")
		
		viewModel.view = self
		
		title = "Detailed Info"
		
		view.addSubview(countryInfoView)
		NSLayoutConstraint.activate([
			countryInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			countryInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			countryInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])
		
		view.addSubview(chartView)
		NSLayoutConstraint.activate([
			chartView.topAnchor.constraint(equalTo: countryInfoView.bottomAnchor),
			chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			chartView.heightAnchor.constraint(equalToConstant: 120)
		])
		
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: chartView.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		view.addSubview(activityIndicator)
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])

		self.viewModel.fetchTimeseries()
	}
	
}

extension CountryDetailsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.dates.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TimeseriesCell.Identifier, for: indexPath) as! TimeseriesCell
		
		let dateString = viewModel.dates[indexPath.item].toString(formatter: Date.defaultFormatter)
		
		cell.configure(
			item: TimeseriesCell.Item(
				dateString: dateString,
				confirmed: viewModel.country.timeseries?[dateString]?.confirmed ?? 0,
				deaths: viewModel.country.timeseries?[dateString]?.deaths ?? 0,
				recovered: viewModel.country.timeseries?[dateString]?.recovered ?? 0
			)
		)
		return cell
	}
	
}

extension CountryDetailsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
}

extension CountryDetailsViewController: CountryDetailsView {
	
	func reloadScreen() {
		tableView.reloadData()
	}
	
	func updateChartData() {
		let dates = viewModel.dates.reversed()
		chartView.updateChartData(item: ChartView.Item(
			confirmedEntries: dates.enumerated().map { offset, date in
				return ChartDataEntry(
					x: Double(offset),
					y: Double(viewModel.country.timeseries?[date.toString(formatter: Date.defaultFormatter)]?.confirmed ?? 0))
			},
			deathsEntries: dates.enumerated().map { offset, date in
				return ChartDataEntry(
					x: Double(offset),
					y: Double(viewModel.country.timeseries?[date.toString(formatter: Date.defaultFormatter)]?.deaths ?? 0))
			},
			recoveredEntries: dates.enumerated().map { offset, date in
				return ChartDataEntry(
					x: Double(offset),
					y: Double(viewModel.country.timeseries?[date.toString(formatter: Date.defaultFormatter)]?.recovered ?? 0))
			}
		))
	}
	
	func showActivityIndicator() {
		activityIndicator.startAnimating()
	}
	
	func hideActivityIndicator() {
		activityIndicator.stopAnimating()
	}
	
}
