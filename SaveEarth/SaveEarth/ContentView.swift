//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var weatherManager: WeatherManager
    
    @State var desiredLatitude: CGFloat = 76.571640
    @State var desiredLongitude: CGFloat = -41.666646
    
    @State private var showQuestModal: Bool = false
    @State private var quests: [Quest] = [
        .init(id: UUID(), isChecked: true, questTitle: "11"),
        .init(id: UUID(), isChecked: true, questTitle: "22"),
        .init(id: UUID(), isChecked: true, questTitle: "33"),
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
                        QuestView(quests: $quests)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: showQuestModal)
                    .ignoresSafeArea(edges: .bottom)
                }
            } else {
                ProgressView()
            }
        }
        .overlay(alignment: .top, content: {
            QuestFloatingButton(numberOfQuests: UInt(self.quests.count)) {
                self.showQuestModal = true
            }
        })
        .task {
            // TODO: SwiftData 체크
            guard true else { return }

            // TODO: API 요청 - 금일 데이터 없는 경우
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
                
                // TODO: SwiftData 개체 생성
                
                Task { @MainActor in
                    isSetup.toggle()
                }
            } catch {
                print("날씨정보 불러오기 실패\(error)")

            }
        }
    }
    
}

#Preview {
    ContentView()
}
