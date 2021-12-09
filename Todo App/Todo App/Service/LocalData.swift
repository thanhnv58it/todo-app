//
//  LocalData.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import Foundation
import RealmSwift
import SwiftUI

class LocalData {
    
    static let shared = LocalData()
    
    func add<T: Object>(data: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(data)
        }
        
    }
    
    func update<T: Object>(data: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(data, update: .modified)
        }
        
    }
    
    func update(write: () -> Void) {
        let realm = try! Realm()
        try! realm.write {
            write()
        }
    }
    
    func getAll<T: Object>(type: T.Type) -> Results<T> {
        let realm = try! Realm()
        let result = realm.objects(T.self)
        return result
    }
    
    func getAll<T: Object>(type: T.Type, query: NSPredicate? = nil) -> Results<T> {
        let realm = try! Realm()
        if let query = query {
            return realm.objects(T.self).filter(query)
        } else {
            return realm.objects(T.self)
        }
    }
}
