//
//  TaskItem.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import Foundation
import RealmSwift

class TaskItem: Object {
  
  @objc dynamic var uid: Int = 0
  @objc dynamic var title: String = ""
  
  @objc dynamic var added: Date = Date()
  @objc dynamic var checked: Date? = nil
  
  override class func primaryKey() -> String? { return "uid" }
  
  
}
