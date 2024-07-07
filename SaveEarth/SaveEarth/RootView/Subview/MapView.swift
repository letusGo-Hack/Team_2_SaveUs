//
//  MapView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var latitude: CGFloat
    @Binding var longitude: CGFloat
    
    private let distanceInMeters: CLLocationDistance = 15_000_000
    private var desiredCoordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    private var region: MKCoordinateRegion {
        .init(
            center: desiredCoordinate,
            span: MKCoordinateSpan(
                latitudeDelta: distanceInMeters,
                longitudeDelta: distanceInMeters
            )
        )
    }
    
    var body: some View {
        Map(
            initialPosition: .region(region),
            bounds: .init(
                centerCoordinateBounds: region,
                minimumDistance: distanceInMeters,
                maximumDistance: distanceInMeters
            )
        )
    }
}
