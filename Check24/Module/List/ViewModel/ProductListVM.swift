//
//  ProductListVM.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import Foundation
import Combine

public enum ProductCategory: Int {
    case all = 0
    case available = 1
    case favorite = 2
}

final class ProductListVM: BaseVM {
    private let networkManager: NetworkManager
    private var allProducts = [Product]()
    private(set) var headerSection: Header?
    @Published private(set) var displayedProductList = [Product]()
    var isLoading = PassthroughSubject<Bool, Never>()
    var fetchedError = PassthroughSubject<Error, Never>()

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func showProduct(in category: ProductCategory = .all) {
        fetchProducts(category: category)
    }
    
    private func arrangeProducts(category: ProductCategory) {
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
        displayedProductList = allProducts
    }
    
    private func showAvailableProducts() {
        let filtered = allProducts.filter { prodcut in
            return prodcut.available == true
        }
        displayedProductList = filtered
    }
    
    private func showFavoriteProducts() {
        displayedProductList = allProducts.filter({ product in
            product.isFavourite
        })
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
