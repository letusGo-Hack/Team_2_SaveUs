//
//  MissionListView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftData
import SwiftUI

struct MissionListView: View {
  @Environment(\.dismiss) var dismiss
  var body: some View {
    VStack {
      HStack {
        VStack {
          
        }
        VStack {
          
        }
      }
      Text(String(format: "이제 %d개만 더하면 목표 달성이에요!", leftCount))
        .font(.notoSansKR(size: 18, weight: .medium))
        .foregroundStyle(Color(red: 0, green: 0.18, blue: 0.82))
    }
  }
}


#Preview {
  MissionListView()
    .modelContainer(for: DayInfo.self)
}
