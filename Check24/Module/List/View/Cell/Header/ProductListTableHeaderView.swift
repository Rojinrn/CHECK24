//
//  ProductListTableHeaderView.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit

final class ProductListHeaderView: UITableViewHeaderFooterView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(label)
        contentView.addSubview(subLabel)
        label.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: subLabel.topAnchor, constant: -8),
            subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            subLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(firstText: String, secendText: String) {
        label.text = firstText
        subLabel.text = secendText
    }
}
