//
//  Scene+ViewController.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 13/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import UIKit

extension Scene {
  
  func viewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    switch self {
    case .tasks(let viewModel):
      let nc = storyboard.instantiateViewController(withIdentifier: "Tasks") as! UINavigationController
      var vc = nc.viewControllers.first as! TasksViewController
      vc.bindViewModel(to: viewModel)
      return nc
      
    case .editTask(let viewModel):
      let nc = storyboard.instantiateViewController(withIdentifier: "EditTask") as! UINavigationController
      var vc = nc.viewControllers.first as! EditTaskViewController
      vc.bindViewModel(to: viewModel)
      return nc
    }
  }
  
}
