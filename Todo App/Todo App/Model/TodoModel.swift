//
//  TodoModel.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    @Persisted var id = ""
    @Persisted var title: String = ""
    @Persisted var des: String = ""
    @Persisted var isDone: Bool = false
    
    convenience init(title: String, description: String) {
        self.init()
        self.title = title
        self.des = description
        self.id = NSUUID().uuidString
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
