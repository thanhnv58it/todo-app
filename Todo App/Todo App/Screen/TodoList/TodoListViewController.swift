//
//  TodoListViewController.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import UIKit

class TodoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        navigationItem.title = "All Items"
        
        let buttonBar = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(rightBarButtonAction))
        buttonBar.tintColor = .white
        navigationItem.rightBarButtonItem = buttonBar
    }

    @objc func rightBarButtonAction() {
        let add = AddItemViewController(nibName: AddItemViewController.nibName, bundle: nil)
        let navigation = UINavigationController(rootViewController: add)
        navigationController?.present(navigation, animated: true, completion: nil)
    }

    @objc func markAsDoneAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.tintColor = sender.isSelected ? .green : .white
    }

}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    private func checkMarkButton(isSelected: Bool, index: Int) -> UIButton {
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 44, height: 44)))
        button.setImage(UIImage(named: "check-normal"), for: .normal)
        button.setImage(UIImage(named: "check-selected"), for: .selected)
        button.tintColor = isSelected ? .green : .white
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        button.removeTarget(self, action: nil, for: .touchUpInside)
        button.tag = index
        button.addTarget(self, action: #selector(markAsDoneAction), for: .touchUpInside)
        return button
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "defaultCell")
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Description DescriptionDescriptionDescriptionD escriptionDescrip tionDescriptionDescriptionDes criptionDescription"
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        cell.accessoryView = checkMarkButton(isSelected: false, index: indexPath.row)
        return cell
    }

}
