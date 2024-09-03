//
//  MissionListModalFeature.swift
//  SaveEarth
//
//  Created by 김용우 on 9/3/24.
//

import ComposableArchitecture

@Reducer
struct MissionListModalFeature {

  // MARK: - State

  @ObservableState
  struct State: Equatable {
    var missionList: [Mission]
  }

  // MARK: - Action

  enum Action {
    case toggle([Mission])
    case dismiss
  }

  // MARK: - Body

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case .toggle(let missionList):
          state.missionList = missionList
          return .none

        case .dismiss:

          return .none
      }
    }
  }
}
