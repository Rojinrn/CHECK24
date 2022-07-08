//
//  LoaderPresenting.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit

protocol LoaderPresenting {
    var loadingViewStyle: LoadingView.BackgroundStyle { get }
    var loaderPresentingView: UIView { get }
    var loaderInsets: UIEdgeInsets { get }
    
    func showLoader()
    func stopLoader()
}

extension LoaderPresenting where Self: UIViewController {
    var loadingViewStyle: LoadingView.BackgroundStyle { .semiTransparent }
    var loaderPresentingView: UIView { view }
    var loaderInsets: UIEdgeInsets { .zero }
    
    var loadingView: LoadingView? {
        loaderPresentingView.subviews.first(where: { $0 is LoadingView }) as? LoadingView
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            let loadingView = LoadingView(backgroundStyle: self.loadingViewStyle)
            
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            self.loaderPresentingView.addSubview(loadingView)
            
            NSLayoutConstraint.activate([
                loadingView.topAnchor.constraint(equalTo: self.loaderPresentingView.topAnchor, constant: self.loaderInsets.top),
                loadingView.trailingAnchor.constraint(equalTo: self.loaderPresentingView.trailingAnchor),
                loadingView.leadingAnchor.constraint(equalTo: self.loaderPresentingView.leadingAnchor),
                loadingView.bottomAnchor.constraint(equalTo: self.loaderPresentingView.bottomAnchor, constant: -self.loaderInsets.bottom)
            ])
        }
    }
    
    func stopLoader() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
