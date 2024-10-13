//
//  FontSystem.swift
//  SaveEarth
//
//  Created by 김용우 on 10/12/24.
//

import SwiftUI

extension Font {

  static func notoSansKR(size: CGFloat, weight: Font.Weight? = nil) -> Font {
    font("Noto Sans KR", size: size, weight: weight)
  }

  static func sfPro(size: CGFloat, weight: Font.Weight? = nil) -> Font {
    font("SF Pro", size: size, weight: weight)
  }

  static private func font(_ name: String, size: CGFloat, weight: Font.Weight? = nil) -> Font {
    let font: Font = .custom(name, size: size)
    if let weight = weight {
      return font.weight(weight)
    } else {
      return font
    }
  }
}
