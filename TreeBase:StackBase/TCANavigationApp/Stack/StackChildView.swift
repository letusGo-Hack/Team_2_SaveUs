//
//  StackChildView.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

// 전역 StackBaseFeature(Path)를 쓰는 방법을 설명하기 위한 View

struct StackChildView: View {
    let store: StoreOf<StackChildFeature>
    
    var body: some View {
        Button("moveToChildFirstView") {
            store.send(.buttonTapped)
        }
    }
}

@Reducer
struct StackChildFeature {
    @ObservableState
    struct State {}
    
    enum Action {
        case buttonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                // MARK: - send 하는 방법
                TCANavigationApp.stackBaseStore.send(.push(.first(.init())))
                return .none
            }
        }
    }
}

