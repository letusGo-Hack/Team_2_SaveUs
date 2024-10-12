//
//  Date+Extensions.swift
//  SaveEarth
//
//  Created by 이재훈 on 9/11/24.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: self)
    }
}
