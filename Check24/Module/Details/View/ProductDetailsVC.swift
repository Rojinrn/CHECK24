//
//  ProductDetailsVC.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit

protocol ProductDetailsProtocol: AnyObject {
    var goToWebView: ((String) -> Void)? { get set }
}

class ProductDetailsVC: UIViewController {
    private let viewModel: ProductDetailsVM
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var productImageView: UIImageView!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var rateStackView: UIStackView!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var reloadFavorite: (() -> Void)?
    var goToWebView: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(viewModel: ProductDetailsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        nameLabel.text = viewModel.product.name
        priceLabel.text = viewModel.product.priceFormatted
        dateLabel.text = viewModel.product.dateFormatted
        descriptionLabel.text = viewModel.product.description
        detailLabel.text = viewModel.product.longDescription
        
        setStar(star: viewModel.product.rating)
        setupFavoriteButton()
        
        guard let url = URL(string: viewModel.product.imageURL) else {
            return
        }
        productImageView.kf.setImage(with: url)
    }
    
    private func setupFavoriteButton() {
        let title = viewModel.product.isFavourite ? "Vergessen" : "Vormerken"
        favoriteButton.setTitle(title, for: .normal)
    }
    
    private func setStar(star: Double) {
        rateStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for _ in 1...Int(star) {
            let starFull = UIImage(systemName: "star.fill")
            let imageView = UIImageView(image: starFull)
            imageView.tintColor = .systemYellow
            rateStackView.addArrangedSubview(imageView)
        }
        
        let reminder = star.truncatingRemainder(dividingBy: 1)
        if reminder >= 0.5 {
            let starHalf = UIImage(systemName: "star.leadinghalf.filled")
            let imageView = UIImageView(image: starHalf)
            imageView.tintColor = .systemYellow

            rateStackView.addArrangedSubview(imageView)
        }
        
        if rateStackView.arrangedSubviews.count != 5 {
            for _ in 1...(5 - rateStackView.arrangedSubviews.count) {
                let starEmpty = UIImage(systemName: "star")
                let imageView = UIImageView(image: starEmpty)
                imageView.tintColor = .systemYellow

                rateStackView.addArrangedSubview(imageView)
            }
        }
    }

    @IBAction func favoriteBtnAction(_ sender: Any) {
        let id = viewModel.product.id
        if AppData.isFavorite(productId: id) {
            AppData.deleteFavorite(productId: id)
        } else {
            AppData.addFavorite(productId: id)
        }
        viewModel.isFavouriteChanged.send()
        setupFavoriteButton()
    }
    
    @IBAction func footerBtnDidAction(_ sender: Any) {
        self.goToWebView?("https://m.check24.de/rechtliche-hinweise/?deviceoutput=app")
    }
}
