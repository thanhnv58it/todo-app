//
//  AddItemViewModel.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import Foundation
import RxSwift

class AddItemViewModel {
    
    let errorObservable = PublishSubject<String?>()
    let savingStatusObservable = PublishSubject<Bool>()

    func addNewItem(title: String, description: String?) {
        let item = TodoModel(title: title, description: description ?? "")
        if let error = LocalData.shared.add(data: item) {
            errorObservable.onNext(error.localizedDescription)
        } else {
            savingStatusObservable.onNext(true)
        }
    }
}
