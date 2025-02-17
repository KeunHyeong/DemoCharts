//
//  Utils.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

class Utils {
    static func parseDate(from timestamp: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormatter.date(from: timestamp) {
            return date
        } else {
            print("Invalid ISO8601 timestamp: \(timestamp)")
            return nil
        }
    }

    
    static func formatDate(from isoDate: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: isoDate) else {
            print("날짜를 변환할 수 없습니다.")
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd 00:00"
        return outputFormatter.string(from: date)
    }
}
