//
//  TreeBaseFeature.swift
//  TCANavigationApp
//
//  Created by 이재훈 on 9/25/24.
//

import ComposableArchitecture

@Reducer
struct TreeBaseFeature {
    @ObservableState
    struct State { // Equatable을 채택하는 이유는 Test를 위함이지만 Xcode 오류로 채택하지 않음
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case popoverButtonTapped
        case sheetButtonTapped
        case alertButtonTapped
        
        case destination(PresentationAction<Destination.Action>)
        enum Alert {
            case confirm(String)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .popoverButtonTapped:
                state.destination = .first(.init())
                return .none
                
            case .sheetButtonTapped:
                state.destination = .second(.init())
                return .none
                
            case .alertButtonTapped:
                state.destination = .alert(
                    // cancel버튼은 자동으로 제공
                    AlertState {
                        TextState("확인을 누르시면 '팝업 처리'가 print됩니다.")
                    } actions: {
                        // 해당 버튼 콜은 .destination(.dismiss)를 호출하지 않음
                        ButtonState(role: .destructive, action: .confirm("팝업 처리")) {
                            TextState("Delete")
                        }
                    }
                )
                return .none
                
            case let .destination(.presented(.alert(.confirm(string)))):
                print(string)
                return .none
                
            case let .destination(.presented(.first(.delegate(.confirm(name))))):
                print(name) // 자식 Store>State의 요소 접근 가능
                return .none
                
            case let .destination(.presented(.second(.delegate(.sendMessage(value))))):
                // 자식 View가 Presenting이라도 호출
                print(value)
                return .none
            
            case .destination(.dismiss):
                print("dismiss")
                return .none
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) // 액션으로 한 Feature가 하위 reducer가 반응
    }
}

extension TreeBaseFeature {
    
    @Reducer
    enum Destination {
        case first(ChildFirstFeature)
        case second(ChildSecondFeature)
        case alert(AlertState<TreeBaseFeature.Action.Alert>)
    }
}

// extension TreeBaseFeature.Destination.State: Equatable {}
