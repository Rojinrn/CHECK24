//
//  ProductCoordinator.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit
import SafariServices

class ProductCoordinator: BaseCoordinator {

    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }

    deinit {
        print("deinit list coordinator")
    }
    
    override func start() {
        goToProductList()
    }
    
    private func goToProductList() {
        let productListVM = ProductListVM(networkManager: NetworkManager())
        let productListVC = ProductListVC(viewModel: productListVM)
        productListVC.goToDetails = { product in
            self.goToProductDetails(product)
        }
        
        productListVC.goToWebView = { link in
            guard let url = URL(string: link) else {
                return
            }
            self.goToWebView(url)
        }
        
        productListVC.navigationItem.title = "CHECK24"
        self.navigationController.viewControllers = [productListVC]
    }
    
    private func goToProductDetails(_ product: Product) {
        let productDetailsVM = ProductDetailsVM(product: product)
        let productDetailsVC = ProductDetailsVC(viewModel: productDetailsVM)
        //TODO: impelement later
        productDetailsVC.reloadFavorite = {
            
        }
        
        productDetailsVC.goToWebView = { link in
            guard let url = URL(string: link) else {
                return
            }
            self.goToWebView(url)
        }
      
        productDetailsVC.navigationItem.title = product.name
        self.navigationController.pushViewController(productDetailsVC, animated: true)
    }
    
    private func goToWebView(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        self.navigationController.present(safariVC, animated: true)
    }

    

}

