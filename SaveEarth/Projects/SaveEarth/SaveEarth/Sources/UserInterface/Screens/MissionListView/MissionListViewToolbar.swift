//
//  MissionListViewToolbar.swift
//  SaveEarth
//
//  Created by 김용우 on 10/13/24.
//

import SwiftUI

struct MissionListViewToolbar: ToolbarContent {
  @Environment(\.dismiss) var dismiss

  var body: some ToolbarContent {
    ToolbarItem(placement: .topBarLeading) {
      Button(
        action: { dismiss() },
        label: {
          Image(asset: Gen.Images.group43)
        }
      )
    }
    ToolbarItem(placement: .principal) {
      Text("오늘의 할일 목록")
        .font(.notoSansKR(size: 16, weight: .medium))
    }
    ToolbarItem(placement: .topBarTrailing) {
      Button(
        action: {},
        label: {
          Text("편집")
            .font(.notoSansKR(size: 12, weight: .medium))
            .padding(.trailing, 8)
        }
      )
    }
  }
}

#Preview {
  NavigationView {
    Color.clear
      .toolbar {
        MissionListViewToolbar()
      }
  }
}
