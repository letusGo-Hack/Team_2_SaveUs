//
//  RootViewFeature.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct RootFeature {
  @ObservableState
  struct State {
    var path: StackState<Path.State> = .init()
  }
  enum Action {
    case path(StackActionOf<Path>)
    case push(Screen)
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case .push(let screen):
          let path: Path.State
          switch screen {
            case .setting: path = .setting(.init())
          }
          state.path.append(path)
          return .none

        case .path:
          return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

extension RootFeature {
  @Reducer
  enum Path {
    case setting(SettingFeature)
  }
}
