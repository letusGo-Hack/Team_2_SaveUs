//
//  StackBaseFeature.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct StackBaseFeature {
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case push(Path.State)
        case path(StackActionOf<Path>)
    }
    
    var body: some ReducerOf<Self> {
        
        // RootFeature(StackVaseFeature)의 Core 로직
        Reduce { state, action in
            switch action {
            case let .push(path):
                state.path.append(path)
                return .none
                
                // 자식 Store의 액션을 받는 방법
            case let .path(.element(id: id, action: .first(.delegate(.confirm(value))))):
                print("first", id, value)
                return .none
                
            case let .path(.element(id: id, action: .second(.delegate(.sendMessage(value))))):
                print("second", id, value)
                return .none
                
            case let .path(.popFrom(id: id)):
                print("popFrom", id)
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) // 배열 내의 모든 path의 Store Scope를 제공
    }
    
    @Reducer
    enum Path {
        case first(ChildFirstFeature)
        case second(ChildSecondFeature)
        case stackChild(StackChildFeature)
    }
}

@Reducer struct PathFirstFeature {
    @ObservableState
    struct State {
        
    }
}

