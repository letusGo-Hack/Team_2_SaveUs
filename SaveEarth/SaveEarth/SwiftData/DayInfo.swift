//
//  DayInfo.swift
//  SaveEarth
//
//  Created by Importants on 6/29/24.
//

import Foundation
import SwiftData

@Model
class TodayInfo {
  @Attribute(.unique) let date: Date
  let temperatureData: TemperatureSwiftDataModel
  var missionList: [Mission]
  
  
  public init(
    date: Date = .now,
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
    @Attribute(.unique) let id: UUID
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
  @Attribute(.unique) var id: UUID
  let historicTemperature: Double
  let currentTemperature: Double
  
  init(
    id: UUID,
    historicTemperature: Double,
    currentTemperature: Double
  ) {
    self.id = id
    self.historicTemperature = historicTemperature
    self.currentTemperature = currentTemperature
  }
}



