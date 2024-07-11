//
//  TargetScript+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension TargetScript {
  
  static func prebuildScript(scriptPath: Path, name: String) -> TargetScript {
    return .pre(script: scriptPath.pathString, name: name)
  }
  
}
