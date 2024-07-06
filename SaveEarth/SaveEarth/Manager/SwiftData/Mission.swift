//
//  Mission.swift
//  SaveEarth
//
//  Created by 김용우 on 7/6/24.
//

import Foundation
import SwiftData

@Model
class Mission {
    #Unique<Mission>([\.id])
    let id: UUID
    let title: String
    let isClear: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        isClear: Bool
    ) {
        self.id = id
        self.title = title
        self.isClear = isClear
    }
}
