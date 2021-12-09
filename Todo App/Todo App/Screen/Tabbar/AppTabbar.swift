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
        allTab.title = "All"
        allTab.image = UIImage(systemName: "doc.text.magnifyingglass")

        let todoTab = tabBar.items![1]
        todoTab.title = "Todo"
        todoTab.image = UIImage(systemName: "doc.text.viewfinder")
        
        let completedTab = tabBar.items![2]
        completedTab.title = "Completed"
        completedTab.image = UIImage(systemName: "hand.thumbsup")
    }

}

extension UIViewController {
    fileprivate func nestedInNavigation() -> UINavigationController {
        let navigation = UINavigationController(rootViewController: self)
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }
}
