//
//  TCANavigationApp.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture
import SwiftUI

@main
// Store를 집어넣는 방법 2가지
struct TCANavigationApp: App {
    // 1. 전역적으로 쓸 수 있는 방법 (앱 생명주기)
    static let stackBaseStore = Store(initialState: StackBaseFeature.State()) {
        StackBaseFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            // StackBase (navigation)
            StackBaseView(store: TCANavigationApp.stackBaseStore)
        }
    }
}

/*
 important
 자식뷰(A) 내에서 자식뷰(B)로 push가 가능하지만, B에서 A로 데이터를 전달하는 방법은 아직 찾지 못했습니다.
 */
