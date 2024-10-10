//
//  Screen.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

enum Screen: Hashable {
  case setting(Int)
}

extension Screen {

  var key: String {
    switch self {
      case .setting:
        "setting"
    }
  }

  var query: String {
    switch self {
      case .setting(let exampleMesaage):
        "exampleMessage=\(exampleMesaage)"
    }
  }
}
