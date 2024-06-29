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
    @Binding var lat: CGFloat
    @Binding var lon: CGFloat
    
    // MARK: - private properties
    
    private var desiredCoordinate: CLLocationCoordinate2D {
        return .init(latitude: lat, longitude: lon)
    }
    
    private let distanceInMeters: CLLocationDistance = 15_000_000
    
    // 대략적인 미터를 도로 변환
    private var region: MKCoordinateRegion {
        return MKCoordinateRegion(
            center: self.desiredCoordinate,
            span: MKCoordinateSpan(
                latitudeDelta: distanceInMeters,
                longitudeDelta: distanceInMeters
            )
        )
    }
    
    // MARK: - views
    
    var body: some View {
        Map(initialPosition: .region(region), bounds: .init(centerCoordinateBounds: region, minimumDistance: distanceInMeters, maximumDistance: distanceInMeters)) {
            Annotation("", coordinate: desiredCoordinate) {
                VStack {
                    Image(systemName: "pin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
