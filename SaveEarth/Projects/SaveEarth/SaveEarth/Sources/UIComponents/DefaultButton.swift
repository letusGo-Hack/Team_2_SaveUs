//
//  DefaultButton.swift
//  SaveEarth
//

import SwiftUI

struct DefaultButton: View {

  // MARK: - Constant

  private enum Constant {
    static let height: CGFloat = 48
    static let radius: CGFloat = 24
  }

  var title: String
  var action: () -> Void

  var body: some View {
    Button(
      action: action,
      label: {
        Text(title)
          .foregroundColor(DesignSystem.AppColor.appPrimary2)
          .font(.system(size: 16, weight: .bold))
          .frame(height: Constant.height)
          .frame(maxWidth: .infinity)
          .background(DesignSystem.AppColor.appWhite)
          .clipShape(.rect(cornerRadius: Constant.radius))
      }
    )
  }
}
