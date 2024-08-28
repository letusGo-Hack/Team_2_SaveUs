//
//  Screen+init.swift
//  SaveEarth
//
//  Created by 김용우 on 8/28/24.
//

extension Screen {

  init?(key: String, query: String?) {
    guard let queryDictionary = query.flatMap({
      Dictionary(
        uniqueKeysWithValues: $0
          .replacingOccurrences(of: "?", with: "")
          .components(separatedBy: "&")
          .map({ $0.components(separatedBy: "=") })
          .map({ ($0[0], $0[1]) })
      )
    }) else {
      return nil
    }
    switch key {
      case "setting":
        guard let exampleMessage = queryDictionary["exampleMessage"].flatMap({ Int($0) }) else {
          return nil
        }
        self = .setting(.init(exampleMessage: exampleMessage))
      default:
        return nil
    }
  }

}
