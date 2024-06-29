//
//  MapView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI
import Charts
import MapKit

struct MapView: View {
    
    var desiredCoordinate: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion
//    private var chartView: AnyView
    
    init(centerLatitude: CGFloat, centerLongitude: CGFloat) {
        self.desiredCoordinate = .init(latitude: centerLatitude, longitude: centerLongitude)
        self._region = State(initialValue: MKCoordinateRegion(
            center: desiredCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        ))
//        self.chartView = Text("")
    }
    
    // MARK: - views
    
    var body: some View {
        Map(
            initialPosition: .region(region)
        ) {
            Annotation("", coordinate: desiredCoordinate) {
                VStack {
                    Image(systemName: "pin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
//                    self.chartView
//                        .frame(width: 200, height: 200) // FIXME: 위치 고려
                }
            }
        }
        .edgesIgnoringSafeArea(.all)

    }
    
}
