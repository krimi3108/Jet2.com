//
//  Date+Extension.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//


import Foundation


extension DateFormatter {
    func getDatePicker(formate: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter
    }
}

extension Date {
    
    static func getTimeDiffernce(from dateTime: String) -> String {
        // Current Date
        let currentDate = Date()
        
        // posted Date
        guard let postedDate = getDateFromString(dateTime) else { return "" }
        
        // Get diffrence
        let difference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDate, to: postedDate)
        
        if let year = difference.year, year != 0 {
            return  "\(abs(year)) \(year > 1 ? "yrs" : "yr")"
            
        } else if let month = difference.month, month != 0 {
            return  "\(abs(month)) \(month > 1 ? "months" : "month")"
            
        }else if let day = difference.day, day != 0 {
            return  "\(abs(day)) \(day > 1 ? "days" : "day")"
            
        }else if let hour = difference.hour, hour != 0 {
            return  "\(abs(hour)) \(hour > 1 ? "hrs" : "hr")"
            
        } else if let minute = difference.minute, minute != 0 {
            return "\(abs(minute)) \(minute > 1 ? "mins" : "min")"
            
        } else if let second = difference.second, second != 0 {
            return "\(abs(second)) sec"
            
        } else {
            return "now"
        }
    }
    
    static private func getDateFromString(_ val: String) -> Date? {
        let dateFormatter = DateFormatter().getDatePicker(formate: SystemConstant.appDateFormat)
        guard let date = dateFormatter.date(from: val) else {
            return nil
        }
        return date
    }
    
}

