//
//  ChartView.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/24/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit
import Charts
import Networking

class ChartView: UIView {
	
	struct Item {
		var confirmedEntries: [ChartDataEntry]
		var deathsEntries: [ChartDataEntry]
		var recoveredEntries: [ChartDataEntry]
	}
	
	private lazy var chartView: LineChartView = {
		let view = LineChartView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.xAxis.enabled = false
		return view
	}()
	
	init() {
		super.init(frame: .zero)
		
		addSubview(chartView)
		NSLayoutConstraint.activate([
			chartView.topAnchor.constraint(equalTo: topAnchor),
			chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
			chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
			chartView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	func updateChartData(item: Item) {
		chartView.data = LineChartData(dataSets: [
			makeChartDataSet(label: "Confirmed", entries: item.confirmedEntries, color: .systemBlue, filled: true),
			makeChartDataSet(label: "Deaths", entries: item.deathsEntries, color: .systemRed),
			makeChartDataSet(label: "Recovered", entries: item.recoveredEntries, color: .systemGreen),
		])
		chartView.animate(xAxisDuration: 1)
	}
	
	private func makeChartDataSet(label: String, entries: [ChartDataEntry], color: UIColor, filled: Bool = false) -> LineChartDataSet {
		let set = LineChartDataSet(
			entries: entries,
			label: label
		)
		set.drawValuesEnabled = false
		set.setColor(color)
		set.setCircleColor(color)
		set.circleRadius = 3
		set.drawCircleHoleEnabled = false
		
		if filled {
			let gradientColors = [UIColor.clear.cgColor, color.cgColor]
			let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
			
			set.fillAlpha = 1
			set.fill = Fill(linearGradient: gradient, angle: 90)
			set.drawFilledEnabled = true
		}
		return set
	}
	
}
