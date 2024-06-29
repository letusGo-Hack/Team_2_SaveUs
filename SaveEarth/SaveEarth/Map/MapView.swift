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
    
    var desiredCoordinate: CLLocationCoordinate2D {
        return .init(latitude: lat, longitude: lon)
    }
    
    private let latMeters: CLLocationDistance = 1_000
    private let lonMeters: CLLocationDistance = 1_000
    
    private var region: MKCoordinateRegion {
        return .init(
            center: self.desiredCoordinate,
            latitudinalMeters: latMeters,
            longitudinalMeters: lonMeters
        )
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
                }
            }
        }
        .edgesIgnoringSafeArea(.all)

    }
    
}
