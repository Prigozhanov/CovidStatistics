//
//  Extensions.swift
//  CovidStatistic
//
//  Created by Vladimir on 4/23/20.
//  Copyright © 2020 Prigozhanov. All rights reserved.
//

import UIKit

// MARK: - Date
extension Date {
	
	static var defaultFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "M/d/yy"
		return formatter
	}
	
	static func fromString(_ string: String) -> Date? {
		return defaultFormatter.date(from: string)
	}
	
	func toString(formatter: DateFormatter) -> String {
		return formatter.string(from: self)
	}
	
}

//MARK: - String
extension String {
	func flag() -> String {
		let base = 127397
		var usv = String.UnicodeScalarView()
		for i in self.utf16 {
			usv.append(UnicodeScalar(base + Int(i))!)
		}
		return String(usv)
	}
}
