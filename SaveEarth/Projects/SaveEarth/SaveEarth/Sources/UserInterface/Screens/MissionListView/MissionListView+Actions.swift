//
//  MissionListView+Actions.swift
//  SaveEarth
//
//  Created by 김용우 on 10/13/24.
//

import SwiftUI

extension MissionListView {

  func toggle(_ index: Int) {
    if let dayInfoIndex = dayInfos.firstIndex(where: { $0.isToday }) {
      dayInfos[dayInfoIndex].missionList[index].isClear.toggle()
    }
  }
}
