//
//  Screen.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import SwiftUI

enum Screen: Hashable {
  case missionList
  case setting
}

extension Screen {

  var key: String {
    switch self {
      case .missionList:    "missionList"
      case .setting:        "setting"
    }
  }

  var query: String? {
    switch self {
      case .missionList:    "missionList"
      case .setting:        "setting"
    }
  }
}
