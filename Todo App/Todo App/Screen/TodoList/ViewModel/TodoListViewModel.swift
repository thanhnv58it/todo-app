//
//  TodoListViewModel.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import Foundation
import RxSwift
import RxRelay

class TodoListViewModel {
    
    typealias DataType = TodoListViewController.DataType
    
    let relayTodoItems: BehaviorRelay<[TodoModel]> = BehaviorRelay(value: [])
    let errorObservable = PublishSubject<String?>()

    func getQuery(type: DataType) -> NSPredicate? {
        switch type {
        case .all:
            return nil
        case .todo:
            return NSPredicate(format: "isDone == %@", NSNumber(value: false))
        case .completed:
            return NSPredicate(format: "isDone == %@", NSNumber(value: true))
        }
    }
    
    func getTodoItems(_ type: DataType) {
        let query = getQuery(type: type)
        let items = LocalData.shared.getAll(type: TodoModel.self, query: query)
        relayTodoItems.accept(Array(items).reversed())
    }
    
    func updateMarkedAsDone(input: TodoModel) {
        let error = LocalData.shared.update {
            input.isDone = !input.isDone
        }
        errorObservable.onNext(error?.localizedDescription)
    }
}
