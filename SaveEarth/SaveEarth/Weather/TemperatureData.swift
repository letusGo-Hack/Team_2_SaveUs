//
//  TemperatureData.swift
//  SaveEarth
//
//  Created by 구본의 on 6/29/24.
//

import Foundation

struct TemperatureData {
  /// 과거 온도
  let historicTemperature: Double
  /// 현재 온도
  let currentTemperature: Double
  
  // MARK: - Initialize
  init(historicTemperature: Double, currentTemperature: Double) {
    self.historicTemperature = round(historicTemperature * 10) / 10
    self.currentTemperature = round(currentTemperature * 10) / 10
  }
}
