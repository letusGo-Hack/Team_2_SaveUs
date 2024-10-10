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
  @Environment(\.modelContext) private var context

  // MARK: - Body

  var body: some View {
    NavigationStack(path: $navigator.path) {
      MainView(
        store: withDependencies {
          $0.weatherManager = .liveValue
          $0.dayInfoModel = .liveValue
          $0.dayInfoModel.updateContext(to: context)
        } operation: {
          .init(
            initialState: MainFeature.State()
          ) {
            MainFeature()._printChanges()
          }
        }
      )
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
  }
}

// TODO: 삭제 예정
extension WeatherManager: DependencyKey {
  static var liveValue: WeatherManager { .init() }
}

extension DependencyValues {

  var weatherManager: WeatherManager {
    get { self[WeatherManager.self] }
    set { self[WeatherManager.self] = newValue }
  }
}
