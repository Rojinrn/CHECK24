//
//  ProductDetailsVM.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import Foundation

final class ProductDetailsVM: BaseVM {
    let product: Product

    init(product: Product) {
        self.product = product
    }
    
    func deleteFavorite() {
        AppData.deleteFavorite(productId: product.id)
    }
    
    func addToFavorite() {
        AppData.addFavorite(productId: product.id)
    }
}
