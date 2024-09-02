//
//  OnboardingStore.swift
//  SaveEarth
//

import Foundation

import ComposableArchitecture

@Reducer
struct OnboardingStore {

  // MARK: - State

  @ObservableState
  struct State: Equatable {
    var currentPage: Int = 0
    var onboardingData: [OnboardingModel] = [
      OnboardingModel(
        image: "bell",
        title: "Push Notifications",
        contents: "Enable notifications to stay up to date with our app.",
        buttonTitle: "현재는 어떤가요?"
      ),
      OnboardingModel(
        image: "bookmark",
        title: "Bookmarks",
        contents: "Save your favorite content for easy access later.",
        buttonTitle: "무엇이 있나요?"
      ),
      OnboardingModel(
        image: "airplane",
        title: "Travel Mode",
        contents: "Access your content offline while traveling.",
        buttonTitle: "아.. 그렇군요"
      ),
      OnboardingModel(
        image: "house",
        title: "Welcome Home",
        contents: "You're all set! Enjoy using our app.",
        buttonTitle: "지구를 지키러 갈께요"
      )
    ]
    var isLastPage: Bool {
      currentPage == onboardingData.count - 1
    }
  }

  // MARK: - Action

  enum Action {
    case setPage(Int)
    case moveToNextpage
    case startApp
  }

  // MARK: - Body

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .setPage(page):
        state.currentPage = page
        return .none
      case .moveToNextpage:
        state.currentPage += 1
        return .none
      case .startApp:
        print("App Start")
        return .none
      }
    }
  }
}
