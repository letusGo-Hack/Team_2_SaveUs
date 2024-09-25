//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftData
import SwiftUI

// TODO: 화면 분리 필요

struct ContentView: View {

  @EnvironmentObject private var weatherManager: WeatherManager
  @Environment(\.modelContext) private var context

  @Query(sort: \DayInfo.date) var dayInfos: [DayInfo]
  private var dayInfo: DayInfo? { dayInfos.first(where: { $0.date == Date.now.dateDescription }) }

  @State private var latitude: CGFloat = 76.571640
  @State private var longitude: CGFloat = -41.666646
  @State private var isPresentedModal: Bool = false

  var completeRate: Float {
    guard let dayInfo = self.dayInfo else { return .zero }
    let isClearCount = dayInfo.missionList.filter({ $0.isClear }).count
    Task { @MainActor in
      if isClearCount == dayInfo.missionList.count {
        isPresentedModal = false
      }
    }
    return Float(isClearCount) / Float(dayInfo.missionList.count)
  }

  var content: some View { // UI 그리기
    ZStack {
      MapView(
        latitude: $latitude,
        longitude: $longitude
      )
      .overlay {
        TemperatureGradient(complete: completeRate)
          .ignoresSafeArea()
      }
      .overlay {
        if let dayInfo =  self.dayInfo, dayInfo.missionList.allSatisfy({ $0.isClear }) {
          CompleteQuestView()
        } else {
          Image(systemName: "flame.fill")
            .foregroundColor(.red)
            .font(.largeTitle)
        }
      }
      if let dayInfo = dayInfo {
        VStack {
          Text(completeRate != 1 ? "뜨거운 지구를 구해주세요!! 😱" : "오늘도 지구를 조금 살려냈어요!")
            .font(.title)
            .padding(.vertical)
          Text("Temperature 🌡️")
            .font(.title2)
            .padding()
          HStack {
            Spacer()
            VStack(alignment: .leading) {
              Text("현재온도")
              Text(String(format: "%.2f℃", dayInfo.temperatureData.currentTemperature))
            }
            Spacer()
            VStack(alignment: .leading) {
              Text("평균온도")
              Text(String(format: "%.2f℃", dayInfo.temperatureData.historicTemperature))
            }
            Spacer()
          }
          .font(.title2)
          Spacer()
          if !isPresentedModal, !dayInfo.missionList.allSatisfy({ $0.isClear }) {
            QuestFloatingButton(
              numberOfQuests: UInt(dayInfo.missionList.filter({ !$0.isClear }).count)
            ) {
              isPresentedModal.toggle()
            }
            .transition(AppearingTransition())
            .animation(.spring(), value: isPresentedModal)
          }
        }
      } else {
        ProgressView()
      }
    }
    .sheet(isPresented: $isPresentedModal) {
      MissionList(
        missions: .init(
          get: { dayInfo?.missionList ?? [] },
          set: {
            guard let dayInfo = dayInfo,
                  let index = dayInfos.firstIndex(of: dayInfo)
            else {
              return
            }
            dayInfos[index].missionList = $0
            try? context.save()
          }
        ),
        isPresented: $isPresentedModal
      )
      .presentationDetents([.height(260)]) // TODO: 화면 비율 등 기준 필요
    }
  }

  var body: some View { // View 전처리 또는 의존성 주입 등 ex) onAppear, onDisAppear
    content
      .task {
        let todayDateDescription = Date.now.dateDescription

        if dayInfo == nil {
          do {
            guard let fetchedData = try await weatherManager.fetchHistoricalTemperature(
              location: .init(
                latitude: latitude,
                longitude: longitude
              )
            ) else {
              print("날씨 불러오기 실패 - 데이터 없음")
              return
            }

            Task { @MainActor in
              let currentTemperature = fetchedData.currentTemperature
              let historicTemperature = fetchedData.historicTemperature

              let count = abs(Int(historicTemperature - currentTemperature))
              let dayInfo = DayInfo(
                date: todayDateDescription,
                temperatureData: .init(
                  historicTemperature: historicTemperature,
                  currentTemperature: currentTemperature
                ),
                missionList: Mission.makeMissionList(count: count > 5 ? 5 : count)
              )

              context.insert(dayInfo)
            }
          } catch {
            print("날씨정보 불러오기 실패 - \(error)")
          }
        }
      }
  }
}

fileprivate extension Date {

  var dateDescription: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: self)
  }

}

fileprivate extension Mission {

  static func makeMissionList(
    count: Int
  ) -> [Mission] {
    let questList: [String] = [
      "페트병 분리수거 하기 🫡",
      "에어컨 1도 낮추기 😎",
      "오늘 하루 텀블러 사용하기 😙",
      "종이컵 사용하지 않기",
      "대중교통 이용하기",
      "낮에는 전등 끄기",
      "사용하지 않는 콘센트 선 뽑아 놓기"
    ]
    var indexes = Set<Int>()

    while indexes.count < count {
      let randomIndex = Int.random(in: 0..<questList.count)
      indexes.update(with: randomIndex)
    }

    return indexes.map({ Mission(title: questList[$0]) })
  }

}

#Preview {
  ContentView()
}
