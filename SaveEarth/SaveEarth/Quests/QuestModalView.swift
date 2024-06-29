//
//  QuestModalView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct QuestModalView<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content
    private var extraHeight: CGFloat = 20
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    content
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("닫기")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    }
                    .padding(.bottom, extraHeight)
                    .padding(.horizontal)
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .frame(width: geometry.size.width, height: geometry.size.height / 3 + extraHeight)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 100 {
                                isPresented = false
                            }
                        }
                )
            }
        }
        .background(
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }
        )
    }
}
