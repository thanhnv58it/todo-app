//
//  AddItemViewModelTests.swift
//  Todo AppTests
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import XCTest
import RxSwift
@testable import Todo_App

class AddItemViewModelTests: TestCaseBase {

    let viewModel = AddItemViewModel()
    
    let bag = DisposeBag()
    
    func testAddNewItems() throws {
    
        viewModel.errorObservable.bind { error in
            guard let error = error else {
                return
            }
            
            XCTFail(error)
        }.disposed(by: bag)
        
        viewModel.savingStatusObservable.bind { status in
            guard status else {
                XCTFail("TestAddNewItems error")
                return
            }
        }.disposed(by: bag)
        
        let inputArray = Array(repeating: 1, count: 100)
        let source = inputArray.enumerated().compactMap{TodoModel(title: "Item \($0.offset)", description: "Description for item \($0.offset)")}
        source.forEach { item in
            viewModel.addNewItem(title: item.title, description: item.des)
        }
        
        let saved = LocalData.shared.getAll(type: TodoModel.self, query: nil)
        
        XCTAssertEqual(saved.count, source.count)
    }
}
