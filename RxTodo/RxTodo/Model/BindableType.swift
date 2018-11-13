//
//  BindableType.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 13/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import UIKit
import RxSwift

protocol BindableType {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func bindViewModel()
}

extension BindableType where Self: UIViewController {
  mutating func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bindViewModel()
  }
}
