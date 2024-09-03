//
//  WorkHistoryView.swift
//  SaveUs
//
//  Created by 이재훈 on 8/14/24.
//

import SwiftUI
import ComposableArchitecture

struct WorkHistoryView: View {
    
    @Bindable var store: StoreOf<WorkHistoryFeature>
    
    var body: some View {
        VStack {
            NavigationBarView(title: "지금까지 한 일")
            List {
                ForEach(store.workLists, id: \.date) { workList in
                    Section(
                        header: Text(workList.date)
                            .font(.system(size: 13))
                    ) {
                        ForEach(workList.list) { work in
                            Button {
                                store.send(.workListCellTapped(work.id))
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

#Preview {
    WorkHistoryView(
        store: Store(initialState: WorkHistoryFeature.State()) {
            WorkHistoryFeature()
        }
    )
}

