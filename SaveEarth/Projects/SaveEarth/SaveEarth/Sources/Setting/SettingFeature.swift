//
//  SettingFeature.swift
//  SaveUs
//
//  Created by 이재훈 on 9/3/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SettingFeature {

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        var totalTasks: Int = 0
        var avgTasksPerDay: Int = 0
        var currentVersion: String = "0.0"
    }

    // MARK: - Action

    enum Action {
        case onAppear
        case showTotalTasksButtonTapped
        case reviewButtonTapped
        case notificationSettingButtonTapped
        case feedbackButtonTapped
        case showGitHubButtonTapped
    }

    // MARK: - body

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                // TODO: 현재 버전 불러오기
                return .none

            case .showTotalTasksButtonTapped:
                return .none

            case .reviewButtonTapped:
                return .none

            case .notificationSettingButtonTapped:
                return .none

            case .feedbackButtonTapped:
                return .none

            case .showGitHubButtonTapped:
                return .none
            }
        }
    }
}
