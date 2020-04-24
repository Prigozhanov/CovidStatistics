//
//  TimeseriesCell.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/22/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit

class TimeseriesCell: UITableViewCell {
	
	static let Identifier = "TimeseriesCell"
	
	struct Item {
		let dateString: String
		let confirmed: Int
		let deaths: Int
		let recovered: Int
	}
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		return label
	}()
	
	private lazy var confirmedLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var deathsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var recoveredLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var statsStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.spacing = 12
		return stack
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12)
		])
		
		contentView.addSubview(statsStack)
		NSLayoutConstraint.activate([
			statsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			statsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			statsStack.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor)
		])
		statsStack.addArrangedSubview(confirmedLabel)
		statsStack.addArrangedSubview(deathsLabel)
		statsStack.addArrangedSubview(recoveredLabel)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	func configure(item: Item) {
		titleLabel.text = item.dateString
		confirmedLabel.text = "Confirmed: \(item.confirmed)"
		deathsLabel.text =  "Deaths: \(item.deaths)"
		recoveredLabel.text =  "Recovered: \(item.recovered)"
	}
	
}
