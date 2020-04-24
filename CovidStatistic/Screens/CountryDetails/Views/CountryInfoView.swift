//
//  CountryDetailsView.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/23/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit
import Charts

class CountryInfoView: UIView {
	
	struct Item {
		let iso2CountryCode: String
		let title: String
		let confirmed: Int
		let deaths: Int
		let recovered: Int
	}
	
	private let item: Item
	
	private lazy var flagLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 60)
		label.textAlignment = .center
		label.backgroundColor = UIColor(named: "background")
		label.layer.cornerRadius = 25
		label.layer.masksToBounds = true
		label.text = item.iso2CountryCode.flag()
		return label
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		label.text = item.title
		return label
	}()
	
	private lazy var confirmedLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .systemBlue
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.text = "Confirmed: \(item.confirmed)"
		return label
	}()
	
	private lazy var deathsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .systemRed
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		label.text = "Deaths: \(item.deaths)"
		return label
	}()
	
	private lazy var recoveredLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .systemGreen
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		label.text = "Recovered: \(item.recovered)"
		return label
	}()
	
	private lazy var statsStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .fillProportionally
		stack.axis = traitCollection.verticalSizeClass == .regular ? .vertical : .horizontal
		return stack
	}()
	
	init(item: Item) {
		self.item = item
		
		super.init(frame: .zero)
		
		backgroundColor = UIColor(named: "background")
		
		addSubview(flagLabel)
		
		NSLayoutConstraint.activate([
			flagLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			flagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			flagLabel.widthAnchor.constraint(equalToConstant: 100),
			flagLabel.heightAnchor.constraint(equalToConstant: 100)
		])
		
		addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
		addSubview(statsStack)
		NSLayoutConstraint.activate([
			statsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			statsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			statsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
			statsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
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
