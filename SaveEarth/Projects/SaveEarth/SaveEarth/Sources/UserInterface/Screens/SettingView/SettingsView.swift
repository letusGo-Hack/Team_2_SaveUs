//
//  SettingView.swift
//  SaveEarth
//
//  Created by 김용우 on 8/25/24.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {

  // MARK: - Property
  @Environment(Navigator.self) var navigator
  let exampleMessage: Int

  // MARK: - Body

  var body: some View {
    VStack {
      Text("설정 화면")
      Spacer()
      Text("의존성 주입 값: \(exampleMessage)")
      Spacer()
      HStack {
        Spacer()
        Button(
          action: {
            let dependencyNumber = exampleMessage + 1
            navigator.push(.setting(dependencyNumber))
          },
          label: {
            Text("설정화면 추가")
          }
        )
        Spacer()
        Button(
          action: {
            navigator.pop()
          },
          label: {
            Text("pop")
          }
        )
        Spacer()
        Button(
          action: {
            navigator.pop(2)
          },
          label: {
            Text("pop count 2")
          }
        )
        Spacer()
        Button(
          action: {
            navigator.popToRoot()
          },
          label: {
            Text("popToRoot")
          }
        )
        Spacer()
      }
    }
  }
}
