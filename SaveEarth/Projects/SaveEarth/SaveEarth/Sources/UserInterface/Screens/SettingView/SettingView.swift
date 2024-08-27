//
//  SettingView.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import SwiftUI

struct SettingView: View {
  let store: StoreOf<SettingFeature>

  var body: some View {
    VStack {
      Text("설정 화면")
      Button(
        action: { store.send(.dismiss) },
        label: {
          Text("pop")
        }
      )
    }
  }
}
