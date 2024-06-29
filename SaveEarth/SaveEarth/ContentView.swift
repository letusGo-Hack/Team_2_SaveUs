//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var desiredLatitude: CGFloat = 72.5801141
    @State var desiredLongitude: CGFloat = -38.4688798
    
    var body: some View {
        VStack {
            MapView(lat: $desiredLatitude, lon: $desiredLongitude)
        }
    }
}

#Preview {
    ContentView()
}
