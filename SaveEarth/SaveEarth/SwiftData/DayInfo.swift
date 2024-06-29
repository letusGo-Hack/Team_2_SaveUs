//
//  DayInfo.swift
//  SaveEarth
//
//  Created by Importants on 6/29/24.
//

import Foundation
import SwiftData

@Model
class DayInfo {
    #Unique<DayInfo>([\.date])
    let date: String
    let temperatureData: TemperatureSwiftDataModel
    var missionList: [Mission]
    
    
    public init(
        date: String,
        temperatureData: TemperatureSwiftDataModel,
        missionList: [Mission]
    ) {
        self.date = date
        self.temperatureData = temperatureData
        self.missionList = missionList
    }
}

@Model
class Mission {
    #Unique<Mission>([\.id])
    let id: UUID
    let title: String
    let isClear: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        isClear: Bool
    ) {
        self.id = id
        self.title = title
        self.isClear = isClear
    }
}

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



