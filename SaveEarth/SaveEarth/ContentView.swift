//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var desiredLatitude: CGFloat = 76.571640
    @State var desiredLongitude: CGFloat = -41.666646
    
    var body: some View {
        MapView(lat: $desiredLatitude, lon: $desiredLongitude)            
    }
}

#Preview {
    ContentView()
}
