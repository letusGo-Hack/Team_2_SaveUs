//
//  FeedbackView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import SwiftUI

struct FeedbackView: View {
    // MARK: - Preperty
    @State private var feedback: String = ""
    @State private var email: String = ""

    // MARK: - Body

    var body: some View {
        VStack {
            NavigationBarView(title: "피드백 주기")
            VStack {
                Spacer()
                FeedbackInputView(feedback: $feedback)
                Spacer()
                EmailInputView(email: $email)
                Spacer()
                SaveUsButtonView(email: $email, feedback: $feedback)
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

    @Binding var email: String
    
    // MARK: - Body
    
    var body: some View {
        let isValidEmail = email.isValidEmailFormat()
        VStack(alignment: .leading) {
            Text("답변 받으실 메일을 입력해주세요")
                .font(.system(size: 14))
            VStack {
                TextField("이메일 주소를 입력하세요", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(isValidEmail ? Color.clear : Color.red, lineWidth: 1)
                    )
                if isValidEmail == false {
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

    @Binding var email: String
    @Binding var feedback: String

    // MARK: - Property

    var body: some View {
        let isActiveButton = email.isValidEmailFormat() && feedback.isEmpty == false
        Button {
            // TODO: 데이터 보내기
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

fileprivate extension String {
    func isValidEmailFormat() -> Bool {
        self.hasSuffix(".com") && self.contains("@")
    }
}

#Preview {
    FeedbackView()
}
