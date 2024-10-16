//
//  TopInterface.swift
//  SaveEarth
//
//  Created by 김용우 on 10/12/24.
//

import SwiftUI

struct TopInterface: View {
  let temperatureDifference: Int

  @Environment(Navigator.self) var navigator

  @State var locationToggle: Bool = false

  enum LocationBundle: CaseIterable {
    case northPole
    case southPole
    case userLocation

    var label: String {
      switch self {
        case .northPole:    "북극"
        case .southPole:    "남극"
        case .userLocation: "내 위치"
      }
    }

    var flag: CGFloat {
      switch self {
        case .userLocation: -4
        default:            -1.25
      }
    }
  }

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      HStack(alignment: .center, spacing: .zero) {
        Button(
          action: { navigator.push(.setting) },
          label: {
            Image(asset: Gen.Images.group15)
              .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          }
        )
        Text("오늘 지구는 평균보다")
          .font(.notoSansKR(size: 14, weight: .medium))
        Text(String(format: "%d℃", temperatureDifference))
          .foregroundStyle(.red)
          .padding(.leading, 8)
        Image(asset: Gen.Images.group16)
          .foregroundStyle(.red)
        Spacer()
      }
      .background(
        RoundedRectangle(cornerRadius: 8, style: .circular)
          .fill(.white)
          .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
      )
      VStack(spacing: 9) {
        Button(
          action: { withAnimation { locationToggle.toggle() } },
          label: {
            VStack(spacing: 2) {
              Image(asset: Gen.Images.group21)
              Text("위치 수정")
                .font(.sfPro(size: 9))
                .foregroundStyle(.white)
            }
            .frame(width: 48, height: 48)
          }
        )
        .background(
          RoundedRectangle(cornerRadius: 8, style: .circular)
            .fill(Color(red: 0.18, green: 0.2, blue: 0.23))
            .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
        )
        if locationToggle {
          VStack(alignment: .center, spacing: 8) {
            ForEach(LocationBundle.allCases, id: \.self) { location in
              Button(
                action: {
                  // TODO: 위치 변경
                  withAnimation { locationToggle.toggle() }
                },
                label: {
                  HStack {
                    Circle()
                      .fill(.white)
                      .stroke(Color(red: 0.72, green: 0.75, blue: 0.81), lineWidth: 1)
                      .shadow(color: .black.opacity(0.25), radius: 5)
                      .frame(width: 48, height: 48)
                      .overlay {
                        Text(location.label)
                          .font(.notoSansKR(size: 12))
                      }
                  }
                }
              )
            }
          }
          .transition(.move(edge: .top).combined(with: .opacity))
        }
      }
    }
    .padding(.horizontal, 12)
    .onDisappear {
      locationToggle = false
    }
  }
}

#Preview {
  TopInterface(temperatureDifference: 3)
}
