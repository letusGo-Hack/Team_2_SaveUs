//
//  SettingView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import SwiftUI

struct SettingView: View {

    // MARK: - Property

    // MARK: - Body

    var body: some View {
        VStack {
            NavigationBarView(title: "Save Earth, Save Us")
            VStack {
                Spacer()
                DetailWorkCountView()
                Spacer()
                VStack(spacing: 16) {
                    DetailWorkCountChartView()
                    Button {
                        // TODO: TotalView 노출
                    } label: {
                        HStack {
                            Spacer()
                            Text("지금까지 한 일 보기")
                                .font(.system(size: 14, weight: .bold))
                                .frame(height: 42)
                            Spacer()
                        }
                    }
                    .tint(.white)
                    .background(Color.black)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding(.horizontal)
            Spacer()
            SettingListView()
            Spacer()
            FooterView()
        }
        .onAppear {
            
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
        HStack {
            Button {
            } label: {
                Image(systemName: "chevron.backward")
                    .frame(width: 48, height: 48)
                    .background(.red)
            }
            Spacer()
            Text(title)
            Spacer()
            Rectangle()
                .fill(.clear)
                .frame(width: 48)
        }
        .frame(height: 54)
    }
}

fileprivate struct DetailWorkCountView: View {

    // MARK: - Property
    @State var totalTasks: Int = 10
    @State var avgTasksPerDay: Int = 10

    // MARK: - Body

    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 8) {
                Text("지금까지 한 일")
                Text("\(totalTasks)")
                    .font(.system(size: 48, weight: .medium))
            }
            Spacer()
            VStack(spacing: 8) {
                Text("하루 평균 한 일")
                Text("\(avgTasksPerDay)")
                    .font(.system(size: 48, weight: .medium))
            }
            Spacer()
        }
        .frame(height: 118)
    }
}

fileprivate struct DetailWorkCountChartView: View {

    // MARK: - Property



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



    // MARK: - Body

    var body: some View {
        List {
            Button(action: {
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
    @State var currentVersion: String = "1.0"

    // MARK: - Body

    var body: some View {
        VStack(spacing: 4) {
            Text("© 2024 SaveUs Team. All rights reserved.")
            Text("현재 버전: \(currentVersion)")
        }
        .font(.system(size: 12, weight: .regular))
    }
}

#Preview {
    SettingView()
}
