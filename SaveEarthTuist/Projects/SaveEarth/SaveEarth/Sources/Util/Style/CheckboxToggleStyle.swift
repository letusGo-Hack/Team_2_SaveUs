//
//  CheckboxToggleStyle.swift
//  SaveEarth
//
//  Created by 김용우 on 7/7/24.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    Button(action: {
      configuration.isOn.toggle()
    }) {
      HStack {
        Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
          .foregroundColor(configuration.isOn ? .blue : .gray)
        configuration.label
          .foregroundStyle(.black)
      }
    }
  }
}
