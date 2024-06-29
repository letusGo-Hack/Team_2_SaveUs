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
                Text("미션") // TODO: 미션 관련 뷰
            } else {
                ProgressView()
            }
        }
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
