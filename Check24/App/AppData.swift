//
//  AppData.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import Foundation

struct AppData {
    @Storage(key: "favouriteList", defaultValue: [])
    static var favouriteList: [Int]
    
    static func isFavorite(productId: Int) -> Bool {
        return AppData.favouriteList.contains(productId)
    }
    static func deleteFavorite(productId: Int) {
        guard let index = AppData.favouriteList.firstIndex(of: productId) else { return }
        AppData.favouriteList.remove(at: index)
    }
    static func addFavorite(productId: Int) {
        if AppData.favouriteList.contains(productId) {
            return
        }
        AppData.favouriteList.append(productId)
    }
}
