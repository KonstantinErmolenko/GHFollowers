//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 25.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
