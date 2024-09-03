//
//  NotificationSettingView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import SwiftUI
import ComposableArchitecture

struct NotificationSettingView: View {
    
    @Bindable var store: StoreOf<NotificationSettingFeature>
    
    var body: some View {
        VStack {
            NavigationBarView(title: "알림 관리하기")
            
            VStack {
                Toggle(
                    isOn: $store.isActiveNotification.sending(\.toggleNotification)
                ) {
                    Text("알림 활성화")
                }
                .frame(height: 50)
                
                if store.isActiveNotification {
                    Spacer()
                        .frame(height: 16)
                    
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
    
    @Bindable var store: StoreOf<NotificationSettingFeature>
    
    var body: some View {
        Button {
            store.send(.timeViewTapped)
        } label: {
            Text(store.notificationTime.formatTimeString())
                .frame(width: 90, height: 40)
                .foregroundStyle(.black)
        }
        
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(.black, lineWidth: 1) // FIXME: 색상 변경
        }
        // FIXME: 바인딩 시 sending 안하고 처리하는 방법 찾아보겠습니다.
        .sheet(isPresented: $store.isTimePickerPresented.sending(\.timePickerViewPresented)) {
            TimePickerView(store: store)
        }
    }
}

fileprivate struct TimePickerView: View {
    @Bindable var store: StoreOf<NotificationSettingFeature>
    
    var body: some View {
        NavigationView {
            DatePicker("", selection: $store.notificationTime.sending(\.setNotificationTime), displayedComponents: .hourAndMinute)
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
