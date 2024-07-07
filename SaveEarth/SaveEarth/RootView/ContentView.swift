//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject private var weatherManager: WeatherManager
    
    @Environment(\.modelContext) private var context
    @Query(sort: \DayInfo.date) var dayInfos: [DayInfo]
    
    @State private var dayInfo: DayInfo?
    
    @State private var latitude: CGFloat = 76.571640
    @State private var longitude: CGFloat = -41.666646
    
    @State private var isPresentedModal: Bool = false
    
    var completion: Float {
        guard let dayInfo = self.dayInfo else { return .zero }
        let isClearCount = dayInfo.missionList.filter({ $0.isClear }).count
        
        Task { @MainActor in
            if isClearCount == dayInfo.missionList.count {
                isPresentedModal = false
            }
        }
        
        return Float(isClearCount) / Float(dayInfo.missionList.count)
    }
    
    var content: some View {
        ZStack {
            MapView(
                latitude: $latitude,
                longitude: $longitude
            )
            .overlay {
                TemperatureGradient(complete: completion)
                    .ignoresSafeArea()
            }
            .overlay {
                if let dayInfo =  self.dayInfo, dayInfo.missionList.allSatisfy({ $0.isClear }) {
                    CompleteQuestView()
                        .transition(CompleteRotatingTransition())
                } else {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                }
            }
            if let dayInfo = dayInfo {
                VStack {
                    Text(completion != 1 ? "뜨거운 지구를 구해주세요!! 😱" : "오늘도 지구를 조금 살려냈어요!")
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
                        QuestFloatingButton(numberOfQuests: UInt(dayInfo.missionList.count)) {
                            self.isPresentedModal = true
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
                missions: .init(get: { dayInfo?.missionList ?? [] }, set: { dayInfo?.missionList = $0 }),
                isPresented: $isPresentedModal
            )
            .presentationDetents([.medium, .large])
        }
    }
    
    var body: some View {
        content
            .task {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let todayDateDescription = dateFormatter.string(from: Date.now)
                
                if let dayInfo = dayInfos.first(where: { $0.date == todayDateDescription }) {
                    self.dayInfo = dayInfo
                } else {
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
                            
                            self.dayInfo = dayInfo
                            // TODO: SwiftData 추가
                        }
                        
                        
                    } catch {
                        print("날씨정보 불러오기 실패 - \(error)")
                    }
                }
            }
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
