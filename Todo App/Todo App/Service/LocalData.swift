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
    
    func add<T: Object>(data: T) -> Error? {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
            return nil
        } catch {
            return error
        }
    }
    
    func update(write: () -> Void) -> Error? {
        do {
            let realm = try Realm()
            try realm.write {
                write()
            }
            return nil
            
        } catch {
            return error
        }
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
