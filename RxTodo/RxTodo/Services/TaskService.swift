//
//  TaskService.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

struct TaskService: TaskServiceType {

  init() {
    // create a few default tasks
    let realm = try! Realm()
    if realm.objects(TaskItem.self).count == 0 {
      ["Chapter 5: Filtering operators",
       "Chapter 4: Observables and Subjects in practice",
       "Chapter 3: Subjects",
       "Chapter 2: Observables",
       "Chapter 1: Hello, RxSwift"].forEach {
        createTask(title: $0)
      }
    }
  }
  
  //MARK: - Publick
  @discardableResult
  func createTask(title: String) -> Observable<TaskItem> {
    let result = withRealm("creating") { realm -> Observable<TaskItem> in
      let task = TaskItem()
      task.title = title
      try realm.write {
        task.uid = (realm.objects(TaskItem.self).max(ofProperty: "uid") ?? 0) + 1
        realm.add(task)
      }
      return .just(task)
    }
    return result ?? .error(TaskSeviceError.creationFailed)
  }
  
  @discardableResult
  func delete(task: TaskItem) -> Observable<Void> {
    let result = withRealm("deleting") { realm -> Observable<Void> in
      try realm.write {
        realm.delete(task)
      }
      return .empty()
    }
    return result ?? .error(TaskSeviceError.deletionFailde(task))
  }
  
  @discardableResult
  func update(task: TaskItem, title: String) -> Observable<TaskItem> {
    let result = withRealm("updating title") { realm -> Observable<TaskItem> in
      try realm.write {
        task.title = title
      }
      return .just(task)
    }
    return result ?? .error(TaskSeviceError.updateFailded(task))
  }
  
  @discardableResult
  func toggle(task: TaskItem) -> Observable<TaskItem> {
    let result = withRealm("toggling") { realm -> Observable<TaskItem> in
      try realm.write {
        if task.checked == nil {
          task.checked = Date()
        } else {
          task.checked = nil
        }
      }
      return .just(task)
    }
     return result ?? .error(TaskSeviceError.toggleFailed(task))
  }
  
  @discardableResult
  func tasks() -> Observable<Results<TaskItem>> {
    let result = withRealm("getting tasks") { realm -> Observable<Results<TaskItem>> in
      let tasks = realm.objects(TaskItem.self)
      return Observable.collection(from: tasks)
    }
    return result ?? .empty()
  }
  
  //MARK: - Private
  
  private func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
    do {
      let realm = try Realm()
      return try action(realm)
    } catch let err {
      print("Failed \(operation) realm with error: \(err)")
      return nil
    }
  }
  
}
