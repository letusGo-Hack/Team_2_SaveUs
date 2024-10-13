//
//  MissionList.swift
//  SaveEarth
//
//  Created by 김용우 on 10/12/24.
//

import SwiftUI

struct MissionList: View {
  @State var missionList: [Mission]
  let toggle: (Int) -> Void

  init(
    missionList: [Mission],
    toggle: @escaping (Int) -> Void
  ) {
    self._missionList = State(initialValue: missionList)
    self.toggle = toggle
  }

  var body: some View {
    LazyVStack(spacing: 8) {
      Button(
        action: {},
        label: {
          HStack(spacing: 16) {
            Spacer()
            Text("오늘의 할일 추가히기")
            Image(systemName: "plus")
              .padding(.vertical, 24)
            Spacer()
          }
        }
      )
      .background(
        RoundedRectangle(cornerRadius: 4, style: .continuous)
          .fill(.white)
          .stroke(Color(red: 0.86, green: 0.86, blue: 0.86), lineWidth: 1)
          .shadow(color: .black.opacity(0.25), radius: 2)
      )
      .padding(.horizontal, 16)
      .padding(.top, 24)
      ForEach(missionList.indices, id: \.self) { index in
        Button(
          action: { toggle(index) },
          label: {
            HStack(spacing: 16) {
              Text(missionList[index].title)
                .font(.notoSansKR(size: 16, weight: .medium))
                .foregroundStyle(.black)
                .padding(.vertical, 24)
                .padding(.leading, 16)
              Spacer()
              Image(missionList[index].isClear ? "Group 38" : "Group 29")
                .padding(.trailing, 16)
            }
          }
        )
        .background(
          RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(.white)
            .stroke(Color(red: 0.86, green: 0.86, blue: 0.86), lineWidth: 1)
            .shadow(color: .black.opacity(0.25), radius: 2)
        )
        .padding(.horizontal, 16)
      }
      Spacer()
    }
    .padding(.top, 21)
    .background(
      Color.gray.opacity(0.3)
    )
  }
}

#if DEBUG
#Preview {
  MissionList(missionList: Mission.preview) { _ in }
}
#endif
