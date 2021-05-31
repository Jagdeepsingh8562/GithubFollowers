//
//  String +Ext.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 31/05/21.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_IN")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func covertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.covertToMonthYearFormat()
    }
    
}
