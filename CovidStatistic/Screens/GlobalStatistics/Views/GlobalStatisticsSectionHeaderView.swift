//
//  GlobalStatisticsHeaderView.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit

class GlobalStatisticsSectionHeaderView: UIView {
	
	struct Item {
		let confirmed: Int
		let deaths: Int
		let recovered: Int
	}
	
	private let item: Item
	
	private lazy var confirmedLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Total confirmed: \(self.item.confirmed)"
		label.textAlignment = .left
		label.textColor = .systemBlue
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		return label
	}()
	
	private lazy var deathsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Total deaths: \(self.item.deaths)"
		label.textAlignment = .left
		label.textColor = .systemRed
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		return label
	}()
	
	private lazy var recoveredLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Total recovered: \(self.item.recovered)"
		label.textAlignment = .left
		label.textColor = .systemGreen
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		return label
	}()
	
	private lazy var statsStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = traitCollection.verticalSizeClass == .regular ? .vertical : .horizontal
		stack.distribution = .equalCentering
		return stack
	}()
	
	init(item: Item) {
		self.item = item
		
		super.init(frame: .zero)
		
		backgroundColor = UIColor(named: "background")
		
		addSubview(statsStack)
		
		NSLayoutConstraint.activate([
			statsStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			statsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			statsStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
			statsStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 12)
		])
		
		statsStack.addArrangedSubview(confirmedLabel)
		statsStack.addArrangedSubview(deathsLabel)
		statsStack.addArrangedSubview(recoveredLabel)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		if previousTraitCollection?.verticalSizeClass == .compact {
			statsStack.axis = .vertical
		} else {
			statsStack.axis = .horizontal
		}
	}
	
}
