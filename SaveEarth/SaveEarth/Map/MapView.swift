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
    
    @State var isTapped: Bool = false
    private let distanceInMeters: CLLocationDistance = 15_000_000

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
        Map(
            initialPosition: .region(region),
            bounds: .init(
                centerCoordinateBounds: region,
                minimumDistance: distanceInMeters,
                maximumDistance: distanceInMeters
            )
        ) {
            Annotation("", coordinate: desiredCoordinate) {
                VStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .symbolEffect(.scale.up, isActive: isTapped)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
