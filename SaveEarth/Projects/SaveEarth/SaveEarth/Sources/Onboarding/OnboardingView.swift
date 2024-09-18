//
//  OnboardingView.swift
//  SaveEarth
//

import SwiftUI

import ComposableArchitecture

struct OnboardingView: View {

  // MARK: Property

  @Bindable var store: StoreOf<OnboardingFeature>

  // MARK: - Body

  var body: some View {
    WithPerceptionTracking {
      ZStack(alignment: .bottom) {
        DesignSystem.AppColor.appPrimary3
          .edgesIgnoringSafeArea(.all)

        TabView(selection: $store.currentPage.sending(\.setPage)) {
          ForEach(store.onboardingData.indices, id: \.self) { index in
            ZStack(alignment: .bottom) {
              OnboardingPageView(model: store.onboardingData[index])
                .tag(index)
            }
          }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .animation(.easeInOut, value: store.currentPage)

        VStack {
          PageIndicator(
            currentPage: store.currentPage,
            pageCount: store.onboardingData.count
          )
          .padding(.bottom)

          AppButton(
            title: store.onboardingData[store.currentPage].buttonTitle,
            style: store.isLastPage ? .primary : .default
          ) {
            store.send(.appButtonTapped)
          }
          .padding(.horizontal, 20)
        }
      }
    }
  }
}

#Preview {
  OnboardingView(
    store: Store(initialState: OnboardingFeature.State()) {
      OnboardingFeature()
    }
  )
}
