//
//  UITableView+Extensions.swift
//  Check24
//
//  Created by Rojin on 7/8/22.
//

import UIKit

/// This protocol only aggregates the needed properties for the extensions to work and avoid duplicated code.
private protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

private extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

extension UITableView {
    
    func register<Cell: UITableViewCell>(_: Cell.Type) {
        self.register(Cell.nib, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue a \(String(describing: Cell.self)) cell.")
        }
        return cell
    }
    
    func register<T: UITableViewHeaderFooterView>(_ view: T.Type) {
        self.register(view, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_ view: T.Type) -> T {
        self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}
