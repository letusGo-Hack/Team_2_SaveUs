//
//  SettingView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<SettingFeature>

    // MARK: - Body

    var body: some View {
        VStack {
            NavigationBarView(title: "Save Earth, Save Us")

            Spacer()

            DetailWorkCountView(store: store)

            Spacer()

            DetailWorkCountChartView(store: store)

            Spacer()
                .frame(height: 16)

            Button {
                store.send(.showTotalTasksButtonTapped)
            } label: {
                Text("지금까지 한 일 보기")
                    .font(.system(size: 14, weight: .bold))
                    .frame(width: 260, height: 42)
            }
            .tint(.white)

            .background(Color.black)
            .clipShape(.rect(cornerRadius: 10))

            Spacer()
                .frame(height: 16)

            SettingListView(store: store)

            Spacer()

            FooterView(store: store)
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

struct NavigationBarView: View {

    // MARK: - Property

    let title: String

    init(title: String) {
        self.title = title
    }

    // MARK: - Body

    var body: some View {
        HStack(spacing: 0) {
            Button {

            } label: {
                Image(systemName: "chevron.backward")
                    .frame(width: 48, height: 48)
            }

            Spacer()

            Text(title)

            Spacer()

            Spacer()
                .frame(width: 48)

        }
        .frame(height: 54)
    }
}

fileprivate struct DetailWorkCountView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<SettingFeature>

    // MARK: - Body

    var body: some View {
        HStack {
            VStack {
                Text("지금까지 한 일")

                Spacer()
                    .frame(height: 8)

                Text(String(store.totalTasks))
                    .font(.system(size: 48, weight: .medium))
            }
            .frame(width: 145, height: 118)

            VStack {
                Text("하루 평균 한 일")

                Spacer()
                    .frame(height: 8)

                Text(String(store.avgTasksPerDay))
                    .font(.system(size: 48, weight: .medium))
            }
            .frame(width: 145, height: 118)
        }
    }
}

fileprivate struct DetailWorkCountChartView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<SettingFeature>

    // MARK: - Body

    var body: some View {
        Rectangle()
            .frame(width: .infinity)
            .frame(height: 200)
            .background(.blue)
    }
}

fileprivate struct SettingListView: View {

    // MARK: - Property

    let store: StoreOf<SettingFeature>

    // MARK: - Body

    var body: some View {
        List {
            Button(action: {
                store.send(.notificationSettingButtonTapped)
            }) {
                HStack {
                    Text("알림 관리하기")
                        .font(.system(size: 14, weight: .regular))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }

            Button(action: {
                store.send(.reviewButtonTapped)
            }) {
                HStack {
                    Text("리뷰 하러가기")
                        .font(.system(size: 14, weight: .regular))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }

            Button(action: {
                store.send(.showGitHubButtonTapped)
            }) {
                HStack {
                    Text("GitHub 보러가기")
                        .font(.system(size: 14, weight: .regular))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }

            Button(action: {
                store.send(.feedbackButtonTapped)
            }) {
                HStack {
                    Text("피드백 주기")
                        .font(.system(size: 14, weight: .regular))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
        }
        .listStyle(.plain)
    }
}

fileprivate struct FooterView: View {

    // MARK: - Property

    var store: StoreOf<SettingFeature>

    // MARK: - Body

    var body: some View {
        VStack {
            Text("© 2024 SaveUs Team. All rights reserved.")

            Spacer()
                .frame(height: 4)

            // TODO: 현재 버전은

            Text("현재 버전: \(store.currentVersion)")
        }
        .font(.system(size: 12, weight: .regular))
    }
}

#Preview {
    SettingView(
        store: Store(initialState: SettingFeature.State()) {
            SettingFeature()
        }
    )
}
