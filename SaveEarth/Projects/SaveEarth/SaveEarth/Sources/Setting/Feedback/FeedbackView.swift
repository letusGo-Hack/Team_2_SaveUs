//
//  FeedbackView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import ComposableArchitecture
import SwiftUI

struct FeedbackView: View {
    // MARK: - Preperty

    @Bindable var store: StoreOf<FeedbackFeature>

    // MARK: - Body

    var body: some View {
        VStack {
            NavigationBarView(title: "피드백 주기")
            VStack {
                Spacer()
                FeedbackInputView(feedback: $store.feedback.sending(\.feedbackChanged))
                Spacer()
                EmailInputView(store: store)
                Spacer()
                SaveUsButtonView(store: store)
            }
            .padding(.horizontal)
        }
    }
}

fileprivate struct FeedbackInputView: View {

    // MARK: - Preperty

    @Binding var feedback: String

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("어떤 점이 불편하셨나요?")
                .font(.system(size: 14))
            TextEditor(text: $feedback)
                .frame(height: 226)
                .clipShape(.rect(cornerRadius: 4))
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.gray, lineWidth: 1) // FIXME: 색상 변경
                }
        }
    }
}

fileprivate struct EmailInputView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<FeedbackFeature>

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("답변 받으실 메일을 입력해주세요")
                .font(.system(size: 14))
            VStack {
                TextField("이메일 주소를 입력하세요", text: $store.email.sending(\.emailChanged))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(store.isEmailValid ? Color.clear : Color.red, lineWidth: 1)
                    )
                if store.isEmailValid == false {
                    HStack {
                        Text("유효한 이메일 주소를 입력해주세요.")
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }

                }
            }
        }
    }
}

fileprivate struct SaveUsButtonView: View {

    // MARK: - Property

    @Bindable var store: StoreOf<FeedbackFeature>

    // MARK: - Property

    var body: some View {
        let isActiveButton = store.isEmailValid && store.feedback.isEmpty == false
        Button {
            store.send(.confirmButtonTapped)
        } label: {
            HStack {
                Spacer()
                Text(isActiveButton ? "피드백을 남길게요" : "아직 보낼 수 없어요")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .disabled(isActiveButton == false)
                Spacer()
            }
        }
        .background(isActiveButton ? .black : .gray)
        .clipShape(.capsule)
    }
}

#Preview {
    FeedbackView(
        store: Store(initialState: FeedbackFeature.State()) {
            FeedbackFeature()
        }
    )
}
