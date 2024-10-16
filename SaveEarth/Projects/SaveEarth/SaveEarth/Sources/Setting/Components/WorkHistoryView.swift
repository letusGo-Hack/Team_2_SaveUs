//
//  WorkHistoryView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import SwiftUI

struct WorkHistoryView: View {

    // MARK: - Property

    // MARK: - Body

    var body: some View {
        VStack {
            NavigationBarView(title: "지금까지 한 일")
            List {
                ForEach(WorkList.dummies, id: \.date) { workList in
                    Section(
                        header: Text(workList.date)
                            .font(.system(size: 13))
                    ) {
                        ForEach(workList.list) { work in
                            Button {
                            } label: {
                                HStack {
                                    Text(work.title)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            Spacer()
        }
    }
}

// TODO: data Dummy
struct Work: Identifiable, Equatable {
    let id = UUID()
    let title: String
}

struct WorkList: Equatable {
    static func == (lhs: WorkList, rhs: WorkList) -> Bool {
        lhs.date == rhs.date && lhs.list == rhs.list
    }

    let date: String
    var list: [Work]
}

extension WorkList {
    static let dummies: [WorkList] = [
        .init(
            date: "2024-04-01",
            list: [
                .init(title: "title1"),
                .init(title: "title2"),
                .init(title: "title3"),
                .init(title: "title4"),
                .init(title: "title5")
            ]
        ),
        .init(
            date: "2024-04-02",
            list: [
                .init(title: "title1"),
                .init(title: "title2"),
                .init(title: "title3"),
                .init(title: "title4"),
                .init(title: "title5")
            ]
        ),
        .init(
            date: "2024-04-03",
            list: [
                .init(title: "title1"),
                .init(title: "title2"),
                .init(title: "title3"),
                .init(title: "title4"),
                .init(title: "title5")
            ]
        )
    ]
}

#Preview {
    WorkHistoryView()
}
