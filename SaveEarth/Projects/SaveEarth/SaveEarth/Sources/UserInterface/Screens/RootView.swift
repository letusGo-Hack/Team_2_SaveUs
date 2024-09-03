//
//  RootView.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {

  // MARK: - Property

  @Bindable var store: StoreOf<RootFeature>

  // MARK: - Body

  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      Button(
        action: {
          Deeplink.openSelf(path: "push/setting?exampleMessage=1")
        },
        label: {
          Text("설정 화면 이동")
        }
      )
    } destination: { store in
      switch store.case {
        case .setting(let store):
          SettingView(store: store)
      }
    }
    .onOpenURL { deeplink in
      print(deeplink) // FIXME: 확인 LOG
      guard let urlComponents = URLComponents(string: deeplink.absoluteString) else {
        return
      }

      if let viewStackControl = ViewStackControl(of: urlComponents) { // ViewStackControl
        store.send(.controlViewStack(viewStackControl))
      }
    }
  }
}

// MARK: - View Dependency

