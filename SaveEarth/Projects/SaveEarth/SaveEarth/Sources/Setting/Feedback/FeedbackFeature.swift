//
//  FeedbackFeature.swift
//  SaveUs
//
//  Created by 이재훈 on 9/3/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct FeedbackFeature {

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        var email: String = ""
        var feedback: String = ""
        var isEmailValid: Bool = false
    }

    // MARK: - Action

    enum Action {
        case feedbackChanged(String)
        case emailChanged(String)
        case confirmButtonTapped
    }

    // MARK: - body

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .feedbackChanged(feedback):
                state.feedback = feedback
                
                return .none

            case let .emailChanged(email):
                state.email = email
                state.isEmailValid = isValidEmail(email)

                return .none

            case .confirmButtonTapped:
                // TODO: 확인 버튼 클릭 시 이벤트

                return .none
            }
        }
    }
}

private extension FeedbackFeature {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
