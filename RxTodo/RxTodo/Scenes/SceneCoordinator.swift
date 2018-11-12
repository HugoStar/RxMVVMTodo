//
//  SceneCoordinator.swift
//  RxTodo
//
//  Created by Мишустин Сергеевич on 12/11/2018.
//  Copyright © 2018 LTD Zebka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {
  
  private var window: UIWindow
  private var currentViewController: UIViewController
  
  required init(window: UIWindow) {
    self.window = window
    currentViewController = window.rootViewController!
  }
  
  static func actualViewControllr(for viewController: UIViewController) -> UIViewController {
    if let navigationController = viewController as? UINavigationController {
      return navigationController.viewControllers.first!
    } else {
      return viewController
    }
  }
  
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
    let subject = PublishSubject<Void>()
    let viewController = scene.viewController()
    switch type {
    case .root:
      currentViewController = SceneCoordinator.actualViewControllr(for: viewController)
      window.rootViewController = viewController
      subject.onCompleted()
    case .push:
      guard let navigationController = currentViewController.navigationController else {
        fatalError("Can't push a view controller without a current navigation controller")
      }
      // one-off subscription to be notified when push complete
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map { _ in }
        .bind(to: subject)
      navigationController.pushViewController(viewController, animated: true)
      currentViewController = SceneCoordinator.actualViewControllr(for: viewController)
    case .modal:
      currentViewController.present(viewController, animated: true) {
        subject.onCompleted()
      }
      currentViewController = SceneCoordinator.actualViewControllr(for: viewController)
    }
    
    return subject.asObserver()
      .take(1)
      .ignoreElements()
  }
  
  @discardableResult
  func pop(animated: Bool) -> Completable {
    let subject = PublishSubject<Void>()
    if let presentor = currentViewController.presentingViewController {
      // dismiss a modal controller
      currentViewController.dismiss(animated: animated) {
        self.currentViewController = SceneCoordinator.actualViewControllr(for: presentor)
        subject.onCompleted()
      }
    } else if let navigationController = currentViewController.navigationController {
      // navigate up the stack
      // one-off subscription to be notified when pop complete
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map{ _ in }
        .bind(to: subject)
      guard navigationController.popViewController(animated: animated) != nil else {
        fatalError("can't navigate back from \(currentViewController)")
      }
      currentViewController = SceneCoordinator.actualViewControllr(for: navigationController.viewControllers.last!)
    } else {
      fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
    }
    return subject.asObserver()
      .take(1)
      .ignoreElements()
  }
}
