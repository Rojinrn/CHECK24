//
//  EndPoint.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import Foundation

enum EndPoint: String {
    case productList = "https://app.check24.de/products-test.json"

    var url: URL{
        URL(string: self.rawValue)!
    }

}
