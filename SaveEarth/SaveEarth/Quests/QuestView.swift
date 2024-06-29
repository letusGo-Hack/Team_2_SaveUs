//
//  QuestView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct Quest: Identifiable {
    var id: UUID
    var isChecked: Bool
    let questTitle: String
}

struct QuestView: View {
    @Binding var quests: [Quest]
    
    var body: some View {
        VStack {
            List {
                ForEach($quests) { $quest in
                    HStack {
                        Toggle(isOn: $quest.isChecked) {
                            Text(quest.questTitle)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                    }
                }
            }
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                configuration.label
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    QuestView(quests: .constant([
        .init(id: UUID(), isChecked: false, questTitle: "1111111"),
        .init(id: UUID(), isChecked: false, questTitle: "2222222"),
        .init(id: UUID(), isChecked: false, questTitle: "3333333")
    ]))
}
