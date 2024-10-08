//
//  NotificationSettingView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import ComposableArchitecture
import SwiftUI

struct NotificationSettingView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<NotificationSettingFeature>

    // MARK: - Body

    var body: some View {
        VStack {
            NavigationBarView(title: "알림 관리하기")
            VStack(spacing: 16) {
                Toggle(
                    isOn: $store.isActiveNotification.sending(\.toggleNotification)
                ) {
                    Text("알림 활성화")
                }
                .frame(height: 50)
                if store.isActiveNotification {
                    HStack {
                        Text("알림 시간 설정")
                        Spacer()
                        NotificationTimeView(store: store)
                    }
                    .frame(height: 50)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

fileprivate struct NotificationTimeView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<NotificationSettingFeature>

    // MARK: - Body

    var body: some View {
        Button {
            store.send(.timeViewTapped)
        } label: {
            Text(store.notificationTime.toString(format: "HH:mm"))
                .frame(width: 90, height: 40)
                .foregroundStyle(.black)
        }
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(.black, lineWidth: 1) // FIXME: 색상 변경
        }
        .sheet(isPresented: $store.isTimePickerPresented.sending(\.timePickerViewPresented)) {
            TimePickerView(store: store)
        }
    }
}

fileprivate struct TimePickerView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<NotificationSettingFeature>

    // MARK: - Body

    var body: some View {
        NavigationView {
            DatePicker(
                "",
                selection: $store.notificationTime.sending(\.setNotificationTime),
                displayedComponents: .hourAndMinute
            )
            .environment(\.locale, Locale(identifier: "ko_KR"))
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .navigationBarItems(
                trailing: Button("완료") {
                    store.send(.timeConfirmButtonTapped)
                }
            )
        }
    }
}

#Preview {
    NotificationSettingView(
        store: Store(initialState: NotificationSettingFeature.State()) {
            NotificationSettingFeature()
        }
    )
}
