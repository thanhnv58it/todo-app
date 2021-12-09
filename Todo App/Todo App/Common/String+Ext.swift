//
//  String+Ext.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import Foundation

extension String {

    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }

}
