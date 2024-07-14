//
//  TemperatureSwiftDataModel.swift
//  SaveEarth
//
//  Created by 김용우 on 7/6/24.
//

import Foundation
import SwiftData

@Model
class TemperatureSwiftDataModel {
    #Unique<TemperatureSwiftDataModel>([\.id])
    let id: UUID
    let historicTemperature: Double
    let currentTemperature: Double
    
    init(
        id: UUID = UUID(),
        historicTemperature: Double,
        currentTemperature: Double
    ) {
        self.id = id
        self.historicTemperature = historicTemperature
        self.currentTemperature = currentTemperature
    }
}
