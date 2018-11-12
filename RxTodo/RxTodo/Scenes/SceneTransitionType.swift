//
//  SceneTransitionType.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import Foundation

enum SceneTransitionType {
  
  // вы можете расширить его, чтобы добавить анимированные типы перехода,
  // интерактивные переходы и даже child view controllers!
  
  case root       // make view controller the root view controller
  case push       // push view controller to navigation stack
  case modal      // present view controller modally
  
}
