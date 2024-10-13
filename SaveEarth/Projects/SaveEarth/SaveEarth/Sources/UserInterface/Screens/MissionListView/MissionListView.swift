//
//  MissionListView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftData
import SwiftUI

struct MissionListView: View {
  @Query(sort: \DayInfo.date) var dayInfos: [DayInfo]
  var missionList: [Mission] {
    dayInfos.first(where: { $0.isToday })?.missionList ?? []
  }

  var body: some View {
    VStack {
      MissionBoard(missionList: missionList)
      MissionList(
        missionList: missionList,
        toggle: toggle
      )
    }
    .toolbar {
      MissionListViewToolbar()
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct MissionBoard: View {
  let missionList: [Mission]
  var leftCount: Int { missionList.filter({ !$0.isClear }).count }

  var body: some View {
    VStack {
      HStack {
        Rectangle().fill(.clear)
          .aspectRatio(1, contentMode: .fit)
          .overlay(alignment: .center) {
            VStack(spacing: 8) {
              Text("오늘의 총 할 일")
                .font(.notoSansKR(size: 14, weight: .medium))
              Text("\(missionList.count)")
                .font(.notoSansKR(size: 48, weight: .medium))
            }
            .padding(.vertical, 21)
          }
        Rectangle().fill(.clear)
          .aspectRatio(1, contentMode: .fit)
          .overlay(alignment: .center) {
            VStack(spacing: 8) {
              Text("완료한 할일")
                .font(.notoSansKR(size: 14, weight: .medium))
              Text("\(missionList.filter(\.isClear).count)")
                .font(.notoSansKR(size: 48, weight: .medium))
            }
            .padding(.vertical, 21)
          }
      }
      .padding(.horizontal, 50)
      Text(String(format: "이제 %d개만 더하면 목표 달성이에요!", leftCount))
        .font(.notoSansKR(size: 18, weight: .medium))
        .foregroundStyle(Color(red: 0, green: 0.18, blue: 0.82))
        .padding(.top, 12)
    }
  }
}

#Preview {
  NavigationView {
    MissionListView()
      .modelContainer(for: DayInfo.self)
  }
}
