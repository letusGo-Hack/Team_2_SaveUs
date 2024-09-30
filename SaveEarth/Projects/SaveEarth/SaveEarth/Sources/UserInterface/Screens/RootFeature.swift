//
//  RootFeature.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct RootFeature {

  // MARK: - State
  @ObservableState
  struct State {
    var path: StackState<Path.State> = .init()
  }

  // MARK: - Action

  enum Action {
    case path(StackActionOf<Path>)
    case controlViewStack(ViewStackControl)
  }

  // MARK: - Body

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case .controlViewStack(let control):
          switch control {
            case .push(let screens):
              let paths: [Path.State] = screens.map({
                switch $0 {
                  case .setting(let state): return .setting(state)
                }
              })
              state.path.append(contentsOf: paths)
              return .none

            case .pop(let count):
              state.path.removeLast(count)
              return .none

            case .popToRoot:
              state.path.removeAll()
              return .none
          }

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
