//
//  SceneCoordinatorType.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
  
  /// transmition to another scene
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Completable
  
  /// pop scene for navigation stack or dismiss current modal
  @discardableResult
  func pop(animated: Bool) -> Completable
  
}

extension SceneCoordinatorType {
  
  @discardableResult
  func pop() -> Completable {
    return pop(animated: true)
  }
  
}
