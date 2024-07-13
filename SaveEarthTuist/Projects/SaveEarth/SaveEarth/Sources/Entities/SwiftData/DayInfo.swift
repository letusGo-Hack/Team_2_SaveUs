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
