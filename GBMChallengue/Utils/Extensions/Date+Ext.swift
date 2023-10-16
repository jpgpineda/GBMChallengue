//
//  Date+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 15/10/23.
//

import Foundation

extension Date {
    func oneWeekAfter() -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: .one, to: self) ?? Date()
    }
    
    func oneMonthAfter() -> Date {
        return Calendar.current.date(byAdding: .month, value: .one ,to: self) ?? Date()
    }
    
    func oneYearAfter() -> Date {
        return Calendar.current.date(byAdding: .year, value: .one ,to: self) ?? Date()
    }
}
