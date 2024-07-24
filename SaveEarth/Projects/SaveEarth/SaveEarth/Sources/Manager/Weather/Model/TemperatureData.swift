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

    /// 현재 온도와 평균온도 차이 계산
    ///
    /// - note: 현재 온도가 더 낮다면 0을 반환
    func temperatureDeviation() -> Int {
        let roundedHistoricTemperature: Int = Int(round(historicTemperature))
        let roundedCurrentTemperature: Int = Int(round(currentTemperature))

        if roundedCurrentTemperature - roundedHistoricTemperature < 0 {
            return 0
        } else if 2 < roundedCurrentTemperature - roundedHistoricTemperature {
            return 3
        } else {
            return roundedCurrentTemperature - roundedHistoricTemperature
        }
    }
}
