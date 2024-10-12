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

  @State var navigator: Navigator = .init()
  @State var weatherManager: WeatherManager = .init()
  @Environment(\.modelContext) private var context

  // MARK: - Body

  var body: some View {
    NavigationStack(path: $navigator.path) {
      MainView()
        .navigationDestination(for: Screen.self) { screen in
          switch screen {
            case .setting(let exampleMessage):
              SettingsView(exampleMessage: exampleMessage)
          }
        }
    }
    .onOpenURL { deeplink in
      print(deeplink) // FIXME: 확인 LOG
      guard let urlComponents = URLComponents(string: deeplink.absoluteString) else {
        return
      }

      if let viewStackControl = ViewStackControl(of: urlComponents) { // ViewStackControl
        navigator.control(by: viewStackControl)
      }
    }
    .environment(weatherManager)
    .environment(navigator)
  }
}
