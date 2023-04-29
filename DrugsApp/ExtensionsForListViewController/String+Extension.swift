//
//  String+Extension.swift
//  DrugsApp
//
//  Created by MacBook Air on 28.04.2023.
//

import Foundation

extension String {
    var encodeURL: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    var decodeURL: String {
        return self.removingPercentEncoding!
    }
}
