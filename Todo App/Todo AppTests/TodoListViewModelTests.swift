//
//  TodoListViewModelTests.swift
//  Todo AppTests
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import XCTest
@testable import Todo_App

class TodoListViewModelTests: TestCaseBase {
    
    let viewModel = TodoListViewModel()
    var initData: [TodoModel]!
    
    override func setUp() {
        super.setUp()
        
        initData = [ TodoModel(title: "First", description: "First description"),
                        TodoModel(title: "Second", description: "Second description"),
                        TodoModel(title: "Third", description: "Third description")]
        initData.last?.isDone = true
        initData.forEach{_ = LocalData.shared.add(data: $0)}
    }
    
    func testGetAllItems() throws {
        viewModel.getTodoItems(.all)
        
        XCTAssertEqual(viewModel.relayTodoItems.value.count, initData.count)
    }
    
    func testGetTodoItems() throws {
        viewModel.getTodoItems(.todo)
        
        XCTAssertEqual(viewModel.relayTodoItems.value.count, initData.filter{!$0.isDone}.count)
    }
    
    func testGetCompletedItems() throws {
        viewModel.getTodoItems(.completed)
        
        XCTAssertEqual(viewModel.relayTodoItems.value.count, initData.filter{$0.isDone}.count)
    }
    
    func testUpdateCompletedItem() throws {
        viewModel.getTodoItems(.completed)
        guard let input = viewModel.relayTodoItems.value.first else {
            XCTFail("Not found completed element")
            return
        }
        viewModel.updateMarkedAsDone(input: input)
        viewModel.getTodoItems(.completed)

        XCTAssertEqual(viewModel.relayTodoItems.value.count, 0)
    }
    
    func testUpdateTodoItems() throws {
        viewModel.getTodoItems(.todo)
        viewModel.relayTodoItems.value.forEach { item in
            viewModel.updateMarkedAsDone(input: item)
        }
       
        viewModel.getTodoItems(.completed)

        XCTAssertEqual(viewModel.relayTodoItems.value.count, initData.count)
    }

}
