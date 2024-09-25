//
//  ChildFirstFeature.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture

@Reducer
struct ChildFirstFeature {
    @ObservableState
    struct State: Equatable {
        var name: String = ""
    }
    
    enum Action {
        // UI 상호작용 시의 action
        case cancelButtonTapped
        case confirmButtonTapped
        case setName(String)
        
        // 부모 Store에 전달할 Action
        case delegate(Delegate)
        enum Delegate {
            case confirm(String)
        }
    }
    
    @Dependency(\.dismiss) var dismiss // view를 닫기 위한 Effect
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .confirmButtonTapped:
                return .run { [name = state.name] send in // State를 inout형식으로 전달하지 못함
                    await send(.delegate(.confirm(name))) // 부모 Store에 값 전달
                    await self.dismiss()
                }
                
            case let .setName(name):
                state.name = name
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
