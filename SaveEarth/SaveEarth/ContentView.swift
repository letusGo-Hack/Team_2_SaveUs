//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var weatherManager: WeatherManager
    @Query(sort: \DayInfo.date) var dayInfoCollection: [DayInfo]
    
    @State var desiredLatitude: CGFloat = 76.571640
    @State var desiredLongitude: CGFloat = -41.666646
    
    @State private var showQuestModal: Bool = false
    @State private var allQuestCheck: Bool = false
    
    @State private var quests: [Quest] = [
        .init(id: UUID(), isChecked: true, questTitle: "11"),
        .init(id: UUID(), isChecked: true, questTitle: "22"),
        .init(id: UUID(), isChecked: false, questTitle: "33"),
        .init(id: UUID(), isChecked: true, questTitle: "44")
    ]
    
    @State var isSetup: Bool = false
    @State var completion: Float = 0.0
    
    var body: some View {
        ZStack {
            MapView(
                lat: $desiredLatitude,
                lon: $desiredLongitude
            )
            
            TemperatureGradient(complete: $completion)
                .ignoresSafeArea()
            
            if isSetup {
                if showQuestModal {
                    QuestModalView(isPresented: $showQuestModal) {
                        QuestView(quests: $quests, isPresented: $showQuestModal)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: showQuestModal)
                    .ignoresSafeArea(edges: .bottom)
                } else {
                    if self.quests.map({ $0.isChecked }).allSatisfy({ $0 == true }) {
                        CompleteQuestView()
                            .transition(CompleteRotatingTransition())
                    }
                }
            } else {
                ProgressView()
            }
        }
        .animation(.spring(), value: showQuestModal)
        .overlay(alignment: .top, content: {
            if !self.showQuestModal &&
                !self.quests.map({ $0.isChecked }).allSatisfy({ $0 == true }) {
                QuestFloatingButton(numberOfQuests: UInt(self.quests.count)) {
                    self.showQuestModal = true
                }
                .transition(AppearingTransition())
            }
        })
        .animation(.default, value: !showQuestModal)
        
        
        .task {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = Date.now
            let formattedDate = dateFormatter.string(from: currentDate)
            
            if let lastDate: String = dayInfoCollection.last?.date,
               lastDate != formattedDate {
                do {
                    let fetchedData = try await weatherManager.fetchHistoricalTemperature(
                        location: .init(
                            latitude: desiredLatitude,
                            longitude: desiredLongitude
                        )
                    )
                    
                    print(fetchedData)
                    print("현재 \(fetchedData?.currentTemperature)")
                    print("평균 \(fetchedData?.historicTemperature)")
                    print("차이 \(fetchedData?.temperatureDeviation())")
                    
                    
                    let dayInfo = DayInfo(
                        date: formattedDate,
                        temperatureData: .init(
                            historicTemperature: fetchedData?.historicTemperature ?? 0.0,
                            currentTemperature: fetchedData?.currentTemperature ?? 0.0
                        ),
                        missionList: makeMissionList(
                            count: fetchedData?.temperatureDeviation() ?? 0
                        )
                    )
                    
                    context.insert(dayInfo)
                    try context.save()
                    
                    
                    Task { @MainActor in
                        isSetup.toggle()
                    }
                    
                    
                } catch {
                    print("날씨정보 불러오기 실패\(error)")
                    
                }
            }
        }
    }
    
    func makeMissionList(
        count: Int
    ) -> [Mission] {
        var questList: [Quest] = [
            .init(questTitle: "페트병 분리수거 하기"),
            .init(questTitle: "에어컨 1도 낮추기"),
            .init(questTitle: "오늘 하루 텀블러 사용하기"),
            .init(questTitle: "종이컵 사용하지 않기"),
            .init(questTitle: "대중교통 이용하기"),
            .init(questTitle: "낮에는 전등 끄기"),
            .init(questTitle: "사용하지 않는 콘센트 선 뽑아 놓기")
        ]
        var missionList = [Mission]()
        
        while missionList.count == count {
            
            // 배열에서 랜덤 인덱스 선택
            let randomIndex = Int.random(in: 0..<questList.count)
            let randomItem = questList[randomIndex]
            if missionList.contains(where: { $0.title == randomItem.questTitle }) {
                continue
            }
            missionList.append(
                .init(
                    title: randomItem.questTitle,
                    isClear: randomItem.isChecked
                )
            )
        }
        
        return missionList
    }
    
    
    
}

#Preview {
    ContentView()
}
