//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 31/05/21.
//

import Foundation

extension Date {
    
    func covertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
