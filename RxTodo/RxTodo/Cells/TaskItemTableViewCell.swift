//
//  TaskTableViewCell.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 13/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import UIKit
import Action
import RxSwift

class TaskItemTableViewCell: UITableViewCell {
  
  @IBOutlet var title: UILabel!
  @IBOutlet var button: UIButton!
  var disposeBag = DisposeBag()
  
  func configure(with item: TaskItem, action: CocoaAction) {
    button.rx.action = action
    
    item.rx.observe(String.self, "title")
      .subscribe(onNext: { [weak self] title in
        self?.title.text = title
      })
    .disposed(by: disposeBag)
    
    item.rx.observe(Date.self, "checked")
      .subscribe(onNext: { [weak self] date in
        let image = UIImage(named: date == nil ? "ItemNotChecked" : "ItemChecked")
        self?.button.setImage(image, for: .normal)
      })
    .disposed(by: disposeBag)
  }
  
  override func prepareForReuse() {
    button.rx.action = nil
    disposeBag = DisposeBag()
    super.prepareForReuse()
  }
  
}
