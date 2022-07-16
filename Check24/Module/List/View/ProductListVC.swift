//
//  ProductListVC.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit
import Combine

protocol ProductListVCProtocol: AnyObject {
    var goToDetails: ((Product) -> Void)? { get set }
    var goToWebView: ((String) -> Void)? { get set }
}

class ProductListVC: UIViewController, ProductListVCProtocol, LoaderPresenting {
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: ProductListVM
    private var subscribers = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()
    
    var goToDetails: ((Product) -> Void)?
    var goToWebView: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindView()
        
        segmentedControl.addTarget(self, action: #selector(ProductListVC.indexChanged(_:)), for: .valueChanged)
        refreshControl.addTarget(self, action: #selector(ProductListVC.refreshData(_:)), for: .valueChanged)
        
        viewModel.showProduct()
    }
    
    init(viewModel: ProductListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ProductTableViewCell.self)
        tableView.register(ProductDisableTableViewCell.self)
        tableView.register(ProductListHeaderView.self)
        tableView.register(ProductListFooterView.self)
        tableView.refreshControl = refreshControl
    }
    
    private func bindView() {
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else {
                    return
                }
                isLoading ? self.showLoader() : self.stopLoader()
                
            }.store(in: &subscribers)
        
        viewModel.displayedProductList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        guard let category = ProductCategory(rawValue: sender.selectedSegmentIndex) else {
            fatalError("no corresponding category type for the index selected by segment control")
        }
        viewModel.showProduct(in: category)
    }
    
    @objc private func refreshData(_ sender: Any) {
        guard let category = ProductCategory(rawValue: segmentedControl.selectedSegmentIndex) else {
            fatalError("no corresponding category type for the index selected by segment control")
        }
        viewModel.showProduct(in: category)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayedProductList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = viewModel.displayedProductList.value[indexPath.row]
        if product.available {
            let cell: ProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(item: product)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell: ProductDisableTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(item: product)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.displayedProductList.value[indexPath.row]
        goToDetails?(product)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(ProductListHeaderView.self)
        guard let headerSection = viewModel.headerSection else {
            return nil
        }
        header.configure(firstText: headerSection.headerTitle, secendText: headerSection.headerDescription)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = viewModel.headerSection else {
            return 0
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeue(ProductListFooterView.self)
        footer.configure(text: "© 2016 Check24") { [weak self] in
            guard let self = self else {
                return
            }
            self.goToWebView?("https://m.check24.de/rechtliche-hinweise/?deviceoutput=app")
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
}
