//
//  EditTaskViewController.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 13/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class EditTaskViewController: UIViewController, BindableType {
  
  @IBOutlet var titleView: UITextView!
  @IBOutlet var okButton: UIBarButtonItem!
  @IBOutlet var cancelButton: UIBarButtonItem!
  
  var viewModel: EditTaskViewModel!
  
  func bindViewModel() {
    titleView.text = viewModel.itemTitle
    
    cancelButton.rx.action = viewModel.onCancel
    
    okButton.rx.tap
      .withLatestFrom(titleView.rx.text.orEmpty)
      .subscribe(viewModel.onUpdate.inputs)
      .disposed(by: self.rx.disposeBag)
    
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    titleView.becomeFirstResponder()
  }
}
