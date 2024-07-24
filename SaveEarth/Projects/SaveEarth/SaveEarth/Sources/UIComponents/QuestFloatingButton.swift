//
//  QuestFloatingButton.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct QuestFloatingButton: View {

    var numberOfQuests: UInt
    let buttonAction: () -> Void

    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text("\(numberOfQuests)개의 퀘스트가 있어요!") // 가제목
                .padding()
        }
        .foregroundStyle(.white)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        .padding(.init([.trailing, .leading]), 20)
    }
}

#Preview {
    QuestFloatingButton(numberOfQuests: UInt(3)) {}
}
