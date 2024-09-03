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
  @Environment(\.modelContext) private var context

  // MARK: - Body

  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
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

extension WeatherManager: DependencyKey {
  static var liveValue: WeatherManager { .init() }
}

extension DependencyValues {

  var weatherManager: WeatherManager {
    get { self[WeatherManager.self] }
    set { self[WeatherManager.self] = newValue }
  }
}
