//
//  DataPoint.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import Foundation
import SwiftUI

struct DataPoint: Identifiable {
    let index: Int
    let id: Int
    let xLongitude: Angle
    let yLatitude: Angle
    
    let mapProjection: PolarProjection

    internal init(
        index: Int,
        id: Int,
        xLongitude: Angle,
        yLatitude: Angle
    ) {
        self.index = index
        self.id = id
        self.xLongitude = xLongitude
        self.yLatitude = yLatitude
        self.mapProjection = .init(xLongitude: xLongitude, yLatitude: yLatitude)
    }
}

extension DataPoint {
    static var mockData: [Self] = [
        .init(index: 0, id: 1, xLongitude: Angle(degrees: 0.0), yLatitude: Angle(degrees: 90.0)),  // North Pole
        .init(index: 1, id: 2, xLongitude: Angle(degrees: 10.0), yLatitude: Angle(degrees: 89.0)), // Near North Pole
        .init(index: 2, id: 3, xLongitude: Angle(degrees: -10.0), yLatitude: Angle(degrees: 89.0)),
        .init(index: 3, id: 4, xLongitude: Angle(degrees: 45.0), yLatitude: Angle(degrees: 88.0)),
        .init(index: 4, id: 5, xLongitude: Angle(degrees: -45.0), yLatitude: Angle(degrees: 88.0)),
        .init(index: 5, id: 6, xLongitude: Angle(degrees: 90.0), yLatitude: Angle(degrees: 87.0)),
        .init(index: 6, id: 7, xLongitude: Angle(degrees: -90.0), yLatitude: Angle(degrees: 87.0)),
        .init(index: 7, id: 8, xLongitude: Angle(degrees: 135.0), yLatitude: Angle(degrees: 86.0)),
        .init(index: 8, id: 9, xLongitude: Angle(degrees: -135.0), yLatitude: Angle(degrees: 86.0)),
        .init(index: 9, id: 10, xLongitude: Angle(degrees: 170.0), yLatitude: Angle(degrees: 85.0)),
        .init(index: 10, id: 11, xLongitude: Angle(degrees: -170.0), yLatitude: Angle(degrees: 85.0)),
        .init(index: 11, id: 12, xLongitude: Angle(degrees: 180.0), yLatitude: Angle(degrees: 84.0)),
        .init(index: 12, id: 13, xLongitude: Angle(degrees: 0.0), yLatitude: Angle(degrees: 84.0)),
        .init(index: 13, id: 14, xLongitude: Angle(degrees: -60.0), yLatitude: Angle(degrees: 83.0))
    ]
}
