//
//  StackBaseView.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

struct StackBaseView: View {
    @Bindable var store: StoreOf<StackBaseFeature>
    
    var body: some View {
        // 스택에 push하는 2가지 방법
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                Button("first") {
                    // 1. Store에서 처리하는 방법
                    store.send(.push(.first(.init())))
                }
                // 2. View에서 처리하는 방법 (모듈화가 되지 않기 때문에 추천하지 않음)
                NavigationLink(state: StackBaseFeature.Path.State.second(.init())) {
                    Text("second")
                }
                // 자식 뷰에서 자식 뷰로 이동할 수 있는 뷰
                Button("stackChild") {
                    store.send(.push(.stackChild(.init())))
                }
            }
        } destination: { store in
            switch store.case {
            case .first(let store):
                ChildFirstView(store: store)
                
            case .second(let store):
                ChildSecondView(store: store)
                
            case .stackChild(let store):
                StackChildView(store: store)
            }
        }
    }
}

