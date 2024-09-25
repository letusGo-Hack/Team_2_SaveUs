//
//  ChildSecondFeature.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ChildSecondFeature {
    @ObservableState
    struct State: Equatable {
        var detail = ChildSecondDetailFeature.State()
    }
    
    enum Action {
        // Subview
        case detail(ChildSecondDetailFeature.Action)
        
        // UI 상호작용 시의 action
        case cancelButtonTapped
        
        // 부모 Store에 전달할 Action
        case delegate(Delegate)
        enum Delegate {
            case sendMessage(String)
            case confirm
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        
        // 하위 뷰로 넘겨줄 Store (런타임 시)
        Scope(state: \.detail, action: \.detail) {
            ChildSecondDetailFeature()
        }
        
        // RootFeature(ChildSecondFeature)의 CORE 로직
        Reduce { state, action in
            switch action {
                // 자식 view의 vlaue를 부모 view로 보내기
            case let .detail(.delegate(.confirm(value))):
                return .send(.delegate(.sendMessage(value)))
                
            case .detail:
                return .none
                
            case .cancelButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .delegate:
                return .none
            }
        }
    }
}

@Reducer
struct ChildSecondDetailFeature {
    @ObservableState
    struct State: Equatable {
        let value = "자식 뷰 버튼입니다."
    }
    
    enum Action {
        case confirmButtontapped
        
        case delegate(Delegate)
        enum Delegate {
            case confirm(String)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .confirmButtontapped:
                return .send(.delegate(.confirm(state.value)))
                
            case .delegate:
                return .none
            }
        }
    }
}
