//
//  BottomInterface.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct BottomInterface: View {
  @Binding var missionList: [Mission]

  @Environment(Navigator.self) var navigator

  @State var isPresentedModal: Bool = false
  var leftCount: Int { missionList.filter({ !$0.isClear }).count }
  var firstTodo: Mission? { missionList.filter({ !$0.isClear }).first }

  var body: some View {
    VStack(alignment: .center, spacing: 16) {
      HStack(alignment: .center) {
        VStack(alignment: .leading) {
          HStack {
            Text("오늘의 남은 작은 할 일")
              .font(.notoSansKR(size: 14, weight: .medium))
            Text(String(format: "%d개", leftCount))
              .font(.notoSansKR(size: 24, weight: .bold))
          }
          Text("오늘의 작은 할 일을 끝마치고 지구를 지켜보아요")
            .font(.notoSansKR(size: 12))
            .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
        }
        Spacer()
        Button(
          action: {},
          label: {
            Text("더보기")
              .font(.notoSansKR(size: 14, weight: .bold))
              .foregroundStyle(.blue)
          }
        )
      }
      .padding(.horizontal, 17)
      .padding(.top, 24)
      Button(
        action: {
          if let _ = firstTodo {
            
          } else {
            // TODO: 화면이동
          }
        },
        label: {
          HStack {
            Text(firstTodo?.title ?? "오늘 완료한 작은 할 일들을 보러갈게요")
              .font(.notoSansKR(size: 16, weight: .medium))
              .foregroundStyle(.black)
              .padding(.vertical, 24)
              .padding(.leading, 16)
            Spacer()
            Group {
              if let _ = firstTodo {
                Image(systemName: "app")
              } else {
                Image("Group 29")
              }
            }
            .padding(.trailing, 16)
          }
        }
      )
      .background(
        RoundedRectangle(cornerRadius: 8, style: .circular)
          .fill(.white)
          .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
      )
      .padding(.horizontal, 16)
      .padding(.bottom, 16)
    }
    .background(
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .fill(.white)
    )
    .sheet(isPresented: $isPresentedModal) {
      MissionListModal(missionList: $missionList)
        .presentationDetents([.height(260)])
    }
    .onChange(of: missionList, initial: false) { oldValue, newValue in
      if newValue.allSatisfy(\.isClear) {
        isPresentedModal = false
      }
    }
  }
}

#if DEBUG
extension Mission {
  static var preview: [Mission] = [
    .init(title: "테스트 1", isClear: true),
    .init(title: "테스트 2", isClear: false)
  ]
}

#Preview {
  BottomInterface(missionList: .constant(Mission.preview))
    .environment(Navigator())
}
#endif
