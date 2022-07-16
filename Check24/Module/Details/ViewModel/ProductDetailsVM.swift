//
//  ProductDetailsVM.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import Foundation
import Combine

final class ProductDetailsVM: BaseVM {
    let product: Product
    let isFavouriteChanged = PassthroughSubject<Void, Never>()

    init(product: Product) {
        self.product = product
    }
}
