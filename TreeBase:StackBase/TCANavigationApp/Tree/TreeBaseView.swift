//
//  TreeBaseView.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

struct TreeBaseView: View {
    
    // Presents을 쓰려면 Bindable을 사용 -> 바인딩을 해야하기 때문
    @Bindable var store: StoreOf<TreeBaseFeature>
    
    var body: some View {
        NavigationStack {
            List {
                Button("popover") {
                    store.send(.popoverButtonTapped)
                }
                
                Button("sheet") {
                    store.send(.sheetButtonTapped)
                }
                
                Button("alert") {
                    store.send(.alertButtonTapped)
                }
            }
            .popover(item: $store.scope(state: \.destination?.first, action: \.destination.first)) { store in
                NavigationStack {
                    ChildFirstView(store: store)
                }
            }
            .sheet(item: $store.scope(state: \.destination?.second, action: \.destination.second)) { store in
                NavigationStack {
                    ChildSecondView(store: store)
                }
            }
            .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))

        }
    }
}

