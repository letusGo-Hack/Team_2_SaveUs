//
//  SettingsFeature.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SettingsFeature {

  // MARK: - State

  @ObservableState
  struct State {
    var exampleMessage: Int
  }

  // MARK: - Action

  enum Action {
    case setup
    case controlViewStack(ViewStackControl)
    case pushSettingView
  }

  // MARK: - Body

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case .setup:
          return .none

        case .controlViewStack(let control):
          Deeplink.open(of: control)
          return .none

        case .pushSettingView:
          let dependencyNumber = state.exampleMessage + 1
          let settingView: Screen = .setting(.init(dependencyNumber))
          return .send(.controlViewStack(.push([settingView])))
      }
    }
  }
}
