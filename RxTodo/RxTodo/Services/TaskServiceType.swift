//
//  TaskServiceType.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import Foundation

enum TaskSeviceError: Error {
  case creationFailed
  case updateFailded(TaskItem)
  case deletionFailde(TaskItem)
  case toggleFailed(TaskItem)
}
