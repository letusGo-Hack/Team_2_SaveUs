//
//  RootView.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
  @Bindable var store: StoreOf<RootFeature>

  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      Button(
        action: {
          store.send(.push(.setting))
        },
        label: {
          Text("설정 화면 이동 \(store.state.path.count)")
        }
      )
    } destination: { store in
      switch store.case {
        case .setting(let store):
          SettingView(store: store)
      }
    }
  }
}
