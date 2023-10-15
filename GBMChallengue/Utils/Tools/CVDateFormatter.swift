//
//  CVDateFormatter.swift
//  GBMChallengue
//
//  Created by javier pineda on 15/10/23.
//

import Foundation

class CVDateFormatter {
    static let formatter = DateFormatter()
    static let byDayMonthYear = "dd/MMM/yyyy"
    
    static func shortDate(_ date: Date) -> String {
        formatter.dateFormat = CVDateFormatter.byDayMonthYear
        return formatter.string(from: date)
    }
}
