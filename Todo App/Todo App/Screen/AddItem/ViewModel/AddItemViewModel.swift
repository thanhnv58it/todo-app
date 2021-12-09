//
//  AddItemViewModel.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import Foundation

class AddItemViewModel {
    
    var todoItem: TodoModel?
    
    init(_ input: TodoModel? = nil) {
        self.todoItem = input
    }
    
    func addNewItem(title: String, description: String?) {
        if let current = todoItem {
            current.title = title
            current.des = description ?? ""
            LocalData.shared.update(data: current)
        } else {
            let item = TodoModel(title: title, description: description ?? "")
            LocalData.shared.add(data: item)
        }
    }
}
