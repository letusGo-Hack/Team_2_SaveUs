//
//  NotificationSettingFeature.swift
//  SaveUs
//
//  Created by 이재훈 on 9/3/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct NotificationSettingFeature {

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        var isActiveNotification: Bool = true
        var isTimePickerPresented: Bool = false
        var notificationTime: Date = Date()
    }

    // MARK: - Action

    enum Action {
        case toggleNotification(Bool)
        case setNotificationTime(Date)
        case timeViewTapped
        case timeConfirmButtonTapped
        case timePickerViewPresented(Bool)
    }

    // MARK: - body

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .toggleNotification(isActive):
                state.isActiveNotification = isActive

                return .none

            case let .setNotificationTime(time):
                state.notificationTime = time

                return .none

            case .timeViewTapped:
                // TODO: timepickerview 노출 이벤트
                state.isTimePickerPresented = true
                return .none

            case .timeConfirmButtonTapped:
                //TODO: 타임 피커 완료 버튼 클릭 시 이벤트
                state.isTimePickerPresented = false
                return .none

            case .timePickerViewPresented(_):
                return .none
            }
        }
    }
}

extension Date {
    func formatTimeString() -> String {
        let format = "HH:mm"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: self)
    }
}
