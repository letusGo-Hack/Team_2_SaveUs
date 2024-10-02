//
//  ChildFirstView.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

struct ChildFirstView: View {
    @Bindable var store: StoreOf<ChildFirstFeature> // Store의 State와 바인딩하려면 @Bindable 채택
    
    var body: some View {
        Form {
            // text가 변화하면 setName이 호출되고 해당 함수가 store의 name을 변화시킨 후 UI에 반영
            TextField("Name", text: $store.name.sending(\.setName))
            Button("저장하기") {
                store.send(.confirmButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("", systemImage: "chevron.backward") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}
