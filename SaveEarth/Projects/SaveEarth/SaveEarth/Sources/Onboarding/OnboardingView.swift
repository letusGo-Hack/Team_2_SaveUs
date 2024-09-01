//
//  OnboardingView.swift
//  SaveEarth
//

import SwiftUI

import ComposableArchitecture

struct OnboardingView: View {

  // MARK: Property

  var store: StoreOf<OnboardingStore>

  // MARK: - Body

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack(alignment: .bottom) {
        DesignSystem.AppColor.appPrimary3
          .edgesIgnoringSafeArea(.all)

        TabView(selection: viewStore.binding(
          get: \.currentPage,
          send: OnboardingStore.Action.setPage
        )) {
          ForEach(viewStore.onboardingData.indices, id: \.self) { index in
            ZStack(alignment: .bottom) {
              OnboardingPageView(model: viewStore.onboardingData[index])
                .tag(index)

            }
          }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .animation(.easeInOut, value: viewStore.currentPage)

        VStack {
          PageIndicator(
            currentPage: viewStore.currentPage,
            pageCount: viewStore.onboardingData.count
          )
          .padding(.bottom)

          if viewStore.isLastPage {
            PrimaryButton(title: viewStore.onboardingData[viewStore.currentPage].buttonTitle) {
              viewStore.send(.startApp)
            }
            .padding(.horizontal, 20)
          } else {
            DefaultButton(title: viewStore.onboardingData[viewStore.currentPage].buttonTitle) {
              viewStore.send(.moveToNextpage)
            }
            .padding(.horizontal, 20)
          }
        }
      }
    }
  }
}

#Preview {
  OnboardingView(
    store: Store(initialState: OnboardingStore.State()) {
      OnboardingStore()
    }
  )
}
