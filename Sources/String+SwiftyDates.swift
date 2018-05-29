//
//  String+SwiftyDates.swift
//  SwiftyDates
//
//  Created by Ralph Küpper on 3/8/18.
//  Copyright © 2018 Skelpo Inc. All rights reserved.
//

import Foundation

extension String {
    public func swiftyTime() -> TimeInterval {
        var hour: Double = 0
        var minute: Double = 0
        var second: Double = 0
        var offset: Double = 0

        var cleanedTime = self.replacingOccurrences(of: "[a-zA-Z]", with: "", options: .regularExpression)
        let sep: Character = self.contains(".") && !self.contains(":") ? "." : ":"

        if (self.contains("-") || self.contains("+")) {
            let sign: Double = self.contains("-") ? -1 : 1
            
            let timeParts = split(separator: sign == 1 ? "+" : "-").map(String.init)
            cleanedTime = timeParts[0]
            if (timeParts[1].contains(":")) {
                let intervalParts = timeParts[1].split(separator: ":").compactMap(Double.init)
                offset = sign * (intervalParts[0]*3600 + intervalParts[1]*60)
                if (intervalParts.count > 2) {
                    offset = offset + intervalParts[2]
                }
            } else {
                offset = (Double(timeParts[1]) ?? 0) * sign
            }
        }
        let parts = cleanedTime.split(separator: sep).compactMap(Double.init)
        if (parts.count > 0) {
            hour = parts[0]
        }
        if (parts.count > 1) {
            minute = parts[1]
        }
        if (parts.count > 2) {
            second = parts[2]
        }
        if (self.contains("pm")) {
            hour = hour + 12
        }
        return Double((hour * 3600) + (minute * 60) + second - offset)
    }
    
    public func swiftyDate(calendar:Calendar = Calendar.current) -> Date? {
        // is this even a string we can work with?
        if (self.count < 1) { return nil }
        
        var day: Int?
        var month: Int?
        var year: Int?
        // check for german dates ((d)d.(m)m.(yy)yy) or ((m)m.(yy)yy) or ((d)d.(m)m)
        if (contains(".")) { // most obvious sign for a german date
            let parts = split(separator: ".").map { Int($0) ?? 0}
            if (parts.count == 3) {
                day = parts[0]
                month = parts[1]
                year = parts.last!
            } else if (parts.count == 2) {
                // checking if the later number is a year (>12 or 4-digits)
                if (parts.last! > 12) {
                    year = parts.last!
                    month = parts[0]
                }
                else {
                    month = parts.last!
                    day = parts[0]
                }
            }
        } else if (contains("-") || contains("/")) {
            let sep: Character = self.contains("/") ? "/" : "-"
            let usWay = contains("/")
            let parts = split(separator: sep).map { Int($0) ?? 0}
            let isoOrder = parts[0] > 12 && parts[1] < 13
            if (parts.count == 3) {
                let reverseIsoOrder = !usWay && parts[2] > 12 && parts[1] < 13
                if (isoOrder) {
                    year = parts[0]
                    month = parts[1]
                    day = parts[2]
                } else if (reverseIsoOrder) {
                    year = parts[2]
                    month = parts[1]
                    day = parts[0]
                } else {
                    if (usWay) {
                        day = parts[1]
                        month = parts[0]
                    }
                    else {
                        day = parts[0]
                        month = parts[1]
                    }
                    year = parts.last!
                }
            } else if (parts.count == 2) {
                if (isoOrder) {
                    year = parts[0]
                    month = parts[1]
                } else {
                    // checking if the later number is a year (>12 or 4-digits)
                    if (parts.last! > 12) {
                        year = parts.last!
                        month = parts[0]
                    } else {
                        if (usWay) {
                            day = parts.last!
                            month = parts[0]
                        } else {
                            month = parts.last!
                            day = parts[0]
                        }
                    }
                }
                
            }
        } else {
            let intValue = Int(self) ?? 0
            if (self.count == 4 || intValue > 12) {
                year = intValue
            } else {
                month = intValue
            }
        }
        // if no year is given we use the current year
        let date = Date()
        if (year == nil) {
            year = calendar.component(.year, from: date)
        }
        if (year! < 100 && year! < 50) {
            year = 2000 + year!
        }
        let components = DateComponents(calendar: calendar, year: year, month: month, day: day)
        return components.date!
    }
    public func swiftyDateTime(calendar: Calendar = Calendar.current, baseDate: Date = Date()) -> Date? {
        if (self == "") { return nil }
        
        var time: TimeInterval = 0
        var date: Date?
        
        // cleaning
        let cleanString = replacingOccurrences(of: " am", with: "am").replacingOccurrences(of: " pm", with: "pm")
        
        // check for iso 8601 (yyyy-MM-ddTHH:mm:ss.SSZ)
        if (cleanString.contains("T")) {
            let parts:[String] = split(separator: "T").map(String.init)
            date = parts[0].swiftyDate()
            time = parts[1].swiftyTime()
        }
        else if (cleanString.contains(" ") && (cleanString.contains(":") || cleanString.contains("am") || cleanString.contains("pm")) && (cleanString.contains("/") || cleanString.contains("-") || cleanString.contains("."))) {
            if let pos = index(of: " ") {
                date = String(self[..<pos]).swiftyDate()
                time = String(self[pos...]).swiftyTime()
            } else {
                date = swiftyDate()
            }
        } else if (cleanString.contains(":") || cleanString.contains("pm") || cleanString.contains("am")) { // if we have a ":" it is most likely a time
            date = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: baseDate))!
            time = swiftyTime()
        } else {
            date = swiftyDate()
        }
        if (date == nil) {
            return nil
        }
        return date! + time
    }
}
