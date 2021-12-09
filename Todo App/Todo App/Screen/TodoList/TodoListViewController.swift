//
//  TodoListViewController.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class TodoListViewController: UIViewController {
    
    enum DataType {
        case all
        case todo
        case completed
        
        var title: String {
            switch self {
            case .all:
                return "screen_all".localized()
            case .todo:
                return "screen_todo".localized()
            case .completed:
                return "screen_completed".localized()
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = TodoListViewModel()
    
    var dataType: DataType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindErrorData()
        bindTodoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTodoItems(dataType)
    }
    
    private func setupUI() {
        navigationItem.title = dataType.title
        
        let buttonBar = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(rightBarButtonAction))
        buttonBar.tintColor = .white
        navigationItem.rightBarButtonItem = buttonBar
    }

    @objc func rightBarButtonAction() {
        let add = AddItemViewController(nibName: AddItemViewController.nibName, bundle: nil)
        let navigation = UINavigationController(rootViewController: add)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }

    @objc func markAsDoneAction(_ sender: UIButton) {
        let current = viewModel.relayTodoItems.value[sender.tag]
        viewModel.updateMarkedAsDone(input: current)
        viewModel.getTodoItems(dataType)
    }

}

extension TodoListViewController {
    
    fileprivate func bindErrorData() {
        viewModel.errorObservable.bind { [weak self] (message) in
            guard let message = message else {
                return
            }
            self?.showErrorAlert(message: message)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindTodoData() {
        viewModel.relayTodoItems.bind(to: tableView.rx.items) { [weak self] (tableView, index, element) in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "defaultCell")
            cell.textLabel?.text = element.title
            cell.detailTextLabel?.text = element.des
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.accessoryView = self?.checkMarkButton(isSelected: element.isDone, index: index)
            return cell
        }.disposed(by: disposeBag)
    }
                                      
    private func checkMarkButton(isSelected: Bool, index: Int) -> UIButton {
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 44, height: 44)))
        button.setImage(UIImage(named: "check-normal"), for: .normal)
        button.setImage(UIImage(named: "check-selected"), for: .selected)
        button.tintColor = isSelected ? .green : .white
        button.isSelected = isSelected
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        button.removeTarget(self, action: nil, for: .touchUpInside)
        button.tag = index
        button.addTarget(self, action: #selector(markAsDoneAction), for: .touchUpInside)
        return button
    }
}
