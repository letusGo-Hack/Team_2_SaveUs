//
//  MainInterface.swift
//  SaveEarth
//
//  Created by 김용우 on 10/11/24.
//

import SwiftData
import SwiftUI

struct MainInterface: View {
  let dayInfo: DayInfo
  let completeRate: Float

  @State var missionList: [Mission]
  @State var locationToggle: Bool = false

  @Query(sort: \DayInfo.date) private var dayInfos: [DayInfo]
  var temperatureDifference: Int {
    Int(
      dayInfo.temperatureData.currentTemperature - dayInfo.temperatureData.historicTemperature
    )
  }

  init(dayInfo: DayInfo, completeRate: Float) {
    self.dayInfo = dayInfo
    self.completeRate = completeRate
    self._missionList = State(initialValue: dayInfo.missionList)
  }

  var body: some View {
    VStack {
      TopInterface(temperatureDifference: temperatureDifference)
      Spacer()
      BottomInterface(missionList: $missionList)
    }
    .onChange(of: missionList, initial: false) { oldValue, newValue in
      if newValue != oldValue, let firstIndex = dayInfos.firstIndex(of: dayInfo) {
        dayInfos[firstIndex].missionList = newValue
      }
    }
  }
}

#if DEBUG
#Preview {
  MainInterface(dayInfo: .preview, completeRate: 0.5)
    .background(.blue.opacity(0.6))
    .environment(Navigator())
}
#endif
