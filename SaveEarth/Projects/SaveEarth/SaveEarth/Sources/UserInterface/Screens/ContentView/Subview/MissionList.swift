//
//  missions.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct MissionList: View {
  @Binding var missions: [Mission]
  @Binding var isPresented: Bool

  var body: some View {
    VStack {
      VStack {
        List {
          ForEach($missions) { $mission in
            HStack {
              Toggle(isOn: $mission.isClear) {
                Text(mission.title)
              }
              .toggleStyle(CheckboxToggleStyle())
            }
          }
        }
      }
      Button(
        action: { isPresented.toggle() },
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
    .onChange(of: missions) { oldValue, newValue in
      if newValue.allSatisfy({ $0.isClear }) {
        isPresented = false
      }
    }
  }
}

#Preview {
  MissionList(
    missions: .constant([
      .init(title: "title 1", isClear: true),
      .init(title: "title 2", isClear: false),
      .init(title: "title 3", isClear: true)
    ]),
    isPresented: .constant(false)
  )
}
