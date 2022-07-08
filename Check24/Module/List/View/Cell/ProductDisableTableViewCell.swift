//
//  ProductDisableTableViewCell.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit

import UIKit
import Kingfisher

class ProductDisableTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var rateStackView: UIStackView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(item: Product) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
       
        setStar(star: item.rating)
        guard let url = URL(string: item.imageURL) else {
            return
        }
        productImageView.kf.setImage(with: url)
        
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
            for _ in 1...(5-rateStackView.arrangedSubviews.count) {
                let starEmpty = UIImage(systemName: "star")
                let imageView = UIImageView(image: starEmpty)
                imageView.tintColor = .systemYellow

                rateStackView.addArrangedSubview(imageView)
            }
        }
    }
}
