//
//  ChildSecondView.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

struct ChildSecondView: View {
    
    let store: StoreOf<ChildSecondFeature>
    
    var body: some View {
        
        VStack {
            Text("Hello")
            Spacer()
            // View 내 자식 View에게 Scope를 이용하여 store 전달
            ChildSecondDetailView(store: store.scope(state: \.detail, action: \.detail))
        }
        
        Text("Hello")
            .toolbar {
                ToolbarItem {
                    Button("", systemImage: "chevron.backward") {
                        store.send(.cancelButtonTapped)
                    }
                }
            }
    }
}

struct ChildSecondDetailView: View {
    let store: StoreOf<ChildSecondDetailFeature>
    
    var body: some View {
        Button("confirm") {
            store.send(.confirmButtontapped)
        }
    }
}
