//
//  TaskServiceType.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

enum TaskSeviceError: Error {
  case creationFailed
  case updateFailded(TaskItem)
  case deletionFailde(TaskItem)
  case toggleFailed(TaskItem)
}

protocol TaskServiceType {
  
  @discardableResult
  func createTask(title: String) -> Observable<TaskItem>
  
  @discardableResult
  func delete(task: TaskItem) -> Observable<Void>
  
  @discardableResult
  func update(task: TaskItem, title: String) -> Observable<TaskItem>
  
  @discardableResult
  func toggle(task: TaskItem) -> Observable<TaskItem>
  
  func tasks() -> Observable<Results<TaskItem>>
  
}
