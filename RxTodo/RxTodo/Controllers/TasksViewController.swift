//
//  TasksViewController.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import UIKit


class TasksViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var statisticsLabel: UILabel!
  @IBOutlet var newTaskButton: UIBarButtonItem!
  
  
  var viewModel: TasksViewModel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    
  }
  
  func bindViewModel() {
    
  }


}
