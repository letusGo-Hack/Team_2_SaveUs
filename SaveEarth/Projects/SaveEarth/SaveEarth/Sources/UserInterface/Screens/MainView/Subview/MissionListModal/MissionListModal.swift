//
//  MissionListModal.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import ComposableArchitecture
import SwiftUI

struct MissionListModal: View {
  @Bindable var store: StoreOf<MissionListModalFeature>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        VStack {
          List {
            ForEach(
              viewStore.binding(
                get: \.missionList,
                send: MissionListModalFeature.Action.toggle
              )
            ) { $mission in
              HStack {
                Toggle(
                  isOn: $mission.isClear
                ) {
                  Text(mission.title)
                }
                .toggleStyle(CheckboxToggleStyle())
              }
            }
          }
        }
        Button(
          action: { viewStore.send(.dismiss) },
          label: {
            HStack {
              Spacer()
              Text("닫기")
                .foregroundStyle(.black)
                .padding(.vertical)
              Spacer()
            }
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
            .padding(.horizontal)
          }
        )
      }
    }
  }
}

#Preview {
  MissionListModal(
    store: .init(
      initialState: MissionListModalFeature.State(missionList: [])
    ) {
      MissionListModalFeature()
    }
  )
}
