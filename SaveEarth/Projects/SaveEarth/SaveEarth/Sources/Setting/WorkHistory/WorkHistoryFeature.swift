//
//  WorkHistoryFeature.swift
//  SaveUs
//
//  Created by 이재훈 on 9/3/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WorkHistoryFeature {

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        // FIXME: model 바꾸기
        var workLists: [WorkList] = [.dummy, .dummy2]
    }

    enum Action {
        case workListCellTapped(UUID)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .workListCellTapped(id):
                print(id.uuidString)
                return .none
            }
        }
    }
}

// dummy

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
    static let dummy: WorkList = .init(
        date: "2024.04.10",
        list: [
            .init(title: "쓰레기 분리수거"),
            .init(title: "재활용 안쓰기"),
            .init(title: "물 절약하기"),
            .init(title: "음식물 안 남기기")
        ]
    )

    static let dummy2: WorkList = .init(
        date: "2024.04.11",
        list: [
            .init(title: "에너지 절약하기"),
            .init(title: "대중교통 이용하기"),
            .init(title: "일회용품 줄이기")
        ]
    )
}
