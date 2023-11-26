//
//  DateFormatClient.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/26.
//

import Foundation
import Dependencies

public struct DateFormatClient {
    public let month: (String) -> Int
    public let day: (String) -> Int
    
    private static let dateFormatter = DateFormatter()
}

extension DateFormatClient: DependencyKey {
    
    public static var liveValue: DateFormatClient {
        let formatter = DateFormatClient.dateFormatter
        return DateFormatClient(
            month: { dateString in
                formatter.dateFormat = "yyyy-MM-dd"
                if let date = formatter.date(from: dateString) {
                    return Calendar.current.component(.month, from: date)
                }
                return 0
            },
            day: { dateString in
                formatter.dateFormat = "yyyy-MM-dd"
                if let date = formatter.date(from: dateString) {
                    return Calendar.current.component(.day, from: date)
                }
                return 0
            }
        )
    }
}

extension DependencyValues {
    
    public var dateComposer: DateFormatClient {
        get { self[DateFormatClient.self] }
        set { self[DateFormatClient.self] = newValue }
    }
}
