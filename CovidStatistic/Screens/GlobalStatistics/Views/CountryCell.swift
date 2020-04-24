//
//  CountryCell.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
	
	static let Identifier = "CountryCell"
	
	private let regularFlagCornerRadius: CGFloat = 15
	private let compactFlagCornerRadius: CGFloat = 25
	
	struct Item {
		let iso2CountryCode: String
		let title: String
		let confirmed: Int
		let deaths: Int
		let recovered: Int
	}
	
	private lazy var flagLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: traitCollection.verticalSizeClass == .regular ? 60 : 20)
		label.textAlignment = .center
		label.backgroundColor = UIColor(named: "background")
		label.layer.cornerRadius = traitCollection.verticalSizeClass == .regular ? regularFlagCornerRadius : compactFlagCornerRadius
		label.layer.masksToBounds = true
		return label
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		return label
	}()
	
	private lazy var confirmedLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .systemBlue
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		return label
	}()
	
	private lazy var deathsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .systemRed
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		return label
	}()
	
	private lazy var recoveredLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .systemGreen
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		return label
	}()
	
	private lazy var statsStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = traitCollection.verticalSizeClass == .regular ? .vertical : .horizontal
		stack.distribution = .fillProportionally
		return stack
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		accessoryType = .disclosureIndicator
		
		contentView.addSubview(flagLabel)
		
		NSLayoutConstraint.activate([
			flagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			flagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			flagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			flagLabel.widthAnchor.constraint(equalTo: flagLabel.heightAnchor)
		])
		
		contentView.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
		
		contentView.addSubview(statsStack)
		NSLayoutConstraint.activate([
			statsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			statsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			statsStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
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
			flagLabel.layer.cornerRadius = compactFlagCornerRadius
			flagLabel.font = UIFont.systemFont(ofSize: 60)
		} else {
			flagLabel.font = UIFont.systemFont(ofSize: 20)
			flagLabel.layer.cornerRadius = regularFlagCornerRadius
			statsStack.axis = .horizontal
		}
	}
	
	func configure(item: Item) {
		flagLabel.text = item.iso2CountryCode.flag()
		titleLabel.text = item.title
		confirmedLabel.text = "Confirmed: \(item.confirmed)"
		deathsLabel.text =  "Deaths: \(item.deaths)"
		recoveredLabel.text =  "Recovered: \(item.recovered)"
	}
	
}
