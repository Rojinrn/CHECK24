//
//  ProductListVM.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import Foundation
import Combine
import SwiftUI

public enum ProductCategory: Int {
    case all = 0
    case available = 1
    case favorite = 2
}

final class ProductListVM: BaseVM {
    private let networkManager: NetworkManager
    private var allProducts = [Product]()
    private(set) var headerSection: Header?
    private(set) var displayedProductList = CurrentValueSubject<[Product], Never>([])
    private(set) var isLoading = PassthroughSubject<Bool, Never>()
    private(set) var fetchedError = PassthroughSubject<Error, Never>()
    private(set) var category: ProductCategory = .all

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func showProduct(in category: ProductCategory = .all) {
        fetchProducts(category: category)
    }
    
    private func arrangeProducts(category: ProductCategory) {
        self.category = category
        switch category {
        case .all:
            showAllProducts()
        case .available:
            showAvailableProducts()
        case .favorite:
            showFavoriteProducts()
        }
    }
    
    private func showAllProducts() {
        displayedProductList.send(allProducts)
    }
    
    private func showAvailableProducts() {
        let filtered = allProducts.filter { prodcut in
            return prodcut.available == true
        }
        displayedProductList.send(filtered)
    }
    
    private func showFavoriteProducts() {
        displayedProductList.send(allProducts.filter{ $0.isFavourite })
    }
}
//MARK: - API CALL
extension ProductListVM {
    private func fetchProducts(category: ProductCategory) {
        isLoading.send(true)
        networkManager.getRequest(with: EndPoint.productList.url) { [weak self] (response: Result<ProductListResponse, Error>) in
            guard let self = self else {return}
            self.isLoading.send(false)

            switch response {
            case .success(let response):
                self.headerSection = response.header
                self.allProducts = response.products
                self.arrangeProducts(category: category)
            case .failure(let error):
                // TODO: Handle error case
                print(error)
                
            }
        }
    }
}
