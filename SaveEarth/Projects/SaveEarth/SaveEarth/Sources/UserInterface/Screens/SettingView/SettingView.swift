//
//  SettingView.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import SwiftUI

struct SettingView: View {

  // MARK: - Property

  let store: StoreOf<SettingFeature>

  // MARK: - Body

  var body: some View {
    VStack {
      Text("설정 화면")
      Spacer()
      Text("의존성 주입 값: \(store.state.exampleMessage)")
      Spacer()
      HStack {
        Spacer()
        Button(
          action: { store.send(.pushSettingView) },
          label: {
            Text("설정화면 추가")
          }
        )
        Spacer()
        Button(
          action: { store.send(.controlViewStack(.pop())) },
          label: {
            Text("pop")
          }
        )
        Spacer()
        Button(
          action: { store.send(.controlViewStack(.pop(2))) },
          label: {
            Text("pop count 2")
          }
        )
        Spacer()
        Button(
          action: { store.send(.controlViewStack(.popToRoot)) },
          label: {
            Text("popToRoot")
          }
        )
        Spacer()
      }
    }
  }
}
