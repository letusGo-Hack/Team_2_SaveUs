//
//  SettingFeature.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SettingFeature {

  @ObservableState
  struct State { }

  enum Action {
    case setup
    case dismiss
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case .setup:
          return .none

        case .dismiss:
          // pop 동작 추가
          print("dismiss")
          return .none
      }
    }
  }
}
