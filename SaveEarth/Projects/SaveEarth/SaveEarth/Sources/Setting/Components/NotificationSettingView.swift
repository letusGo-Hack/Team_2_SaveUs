//
//  NotificationSettingView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import SwiftUI

struct NotificationSettingView: View {

    // MARK: - Property
    @State private var isActiveNotification: Bool = false
    // MARK: - Body

    var body: some View {
        VStack {
            NavigationBarView(title: "알림 관리하기")
            VStack(spacing: 16) {
                Toggle(
                    isOn: $isActiveNotification
                ) {
                    Text("알림 활성화")
                }
                .frame(height: 50)
                if isActiveNotification {
                    HStack {
                        Text("알림 시간 설정")
                        Spacer()
                        NotificationTimeView()
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
    @State private var isTimePickerPresented: Bool = false
    @State private var notificationTime: Date = Date()

    // MARK: - Body

    var body: some View {
        Button {
            isTimePickerPresented = true
        } label: {
            Text(notificationTime.toString(format: "HH:mm"))
                .frame(width: 90, height: 40)
                .foregroundStyle(.black)
        }
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(.black, lineWidth: 1) // FIXME: 색상 변경
        }
        .sheet(isPresented: $isTimePickerPresented) {
            TimePickerView(isTimePickerPresented: $isTimePickerPresented, notificationTime: $notificationTime)
        }
    }
}

fileprivate struct TimePickerView: View {

    // MARK: - Property
    @Binding var isTimePickerPresented: Bool
    @Binding var notificationTime: Date

    // MARK: - Body

    var body: some View {
        NavigationView {
            DatePicker(
                "",
                selection: $notificationTime,
                displayedComponents: .hourAndMinute
            )
            .environment(\.locale, Locale(identifier: "ko_KR"))
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .navigationBarItems(
                trailing: Button("완료") {
                    isTimePickerPresented = false
                }
            )
        }
    }
}

#Preview {
    NotificationSettingView()
}
