//
//  AppTabbar.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import UIKit

class AppTabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTabbar()
    }
    
    private func setupUI() {
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = UIColor.black
        tabBar.backgroundColor = UIColor.black
    }

    private func setupTabbar() {
        let all = TodoListViewController(nibName: TodoListViewController.nibName, bundle: nil)
        all.dataType = .all
        
        let todo = TodoListViewController(nibName: TodoListViewController.nibName, bundle: nil)
        todo.dataType = .todo

        let completed = TodoListViewController(nibName: TodoListViewController.nibName, bundle: nil)
        completed.dataType = .completed

        self.viewControllers = [all, todo, completed].map{$0.nestedInNavigation()}
        
        let allTab = tabBar.items![0]
        allTab.title = "tab_all".localized()
        allTab.image = UIImage(systemName: "doc.text.magnifyingglass")

        let todoTab = tabBar.items![1]
        todoTab.title = "tab_todo".localized()
        todoTab.image = UIImage(systemName: "doc.text.viewfinder")
        
        let completedTab = tabBar.items![2]
        completedTab.title = "tab_completed".localized()
        completedTab.image = UIImage(systemName: "hand.thumbsup")
    }

}

extension UIViewController {
    fileprivate func nestedInNavigation() -> UINavigationController {
        let navigation = UINavigationController(rootViewController: self)
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "alert_error".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
