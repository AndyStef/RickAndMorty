//
//  StoryboardIdentifiable.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension StoryboardIdentifiable where Self: UIView {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension UIViewController: StoryboardIdentifiable {}
extension UITableViewCell: StoryboardIdentifiable {}
extension UICollectionReusableView: StoryboardIdentifiable {}
extension UITableViewHeaderFooterView: StoryboardIdentifiable {}

extension UIStoryboard {

    /**
     Instantiates view controller with the specified identifier casted to T.
     Usage:
     ````
     let controller: PersonViewController = self.storyboard!.instantiateViewController()
     controller.person = self.person
     self.present(controller, animated: true)
     ````
     - parameter identifier: Controller identifier (Storyboard ID). Default value equals to controller class name
     - returns: Controller with specified identifier casted to T or fatalError if cast is not possible or there is no controller with specified identifier
     */
    func instantiateViewController<T: UIViewController>(withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let controller = self.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("There is no view controller with \(identifier) identifier")
        }

        return controller
    }
}

// MARK: - Dequeuing Cells

extension UICollectionView {

    /**
     Returns a reusable cell object located by its identifier.

     Usage:
     ````
     let cell: ImageCollectionCell = collectionView.dequeueReusableCell(at: indexPath)
     cell.setImage(withURL: items[indexPath.item].url)
     return cell
     ````
     - Parameters:
     - indexPath: The index path specifying the location of the cell
     - identifier: cell reuse identifier. Default value equals to cell class name
     - returns: Collection view cell with specified identifier casted to T or fatalError if cast is not possible or there is no cell with specified identifier
     */
    func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }
}

extension UITableView {

    /**
     Returns a reusable table view cell object for the specified reuse identifier and adds it to the table.

     Usage:
     ````
     let cell: PersonCollectionCell = tableView.dequeueReusableCell(at: indexPath)
     cell.configure(with: items[indexPath.row]
     return cell
     ````
     - Parameters:
     - indexPath: The index path specifying the location of the cell
     - identifier: cell reuse identifier. Default value equals to cell class name
     - returns: Table view cell with specified identifier casted to T or fatalError if cast is not possible or there is no cell with specified identifier
     */
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }

    /**
     Returns a reusable header or footer view located by its identifier.

     Usage:
     ````
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     let header: RequestStepTableSectionHeaderView = tableView.dequeueReusableHeaderFooterView()
     header.configure(with: items[section])
     return header
     }
     ````
     - parameter identifier: HeaderFooterView reuse identifier. Default value equals to view class name
     - returns: Table view HeaderFooterView object with specified identifier casted to T or fatalError if cast is not possible or there is no view with specified identifier
     */
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("There is no header/footer with \(identifier) identifier")
        }

        return header
    }
}

// MARK: - Registering

extension UITableView {

    /**
     Registers a class for use in creating new table cells.
     - Parameters:
     - class: The class of a cell that you want to use in the table
     - identifier: Cell reuse identifier. Default value equals to cell class name
     */
    func register<T: UITableViewCell>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forCellReuseIdentifier: identifier)
    }

    /**
     Registers a nib object containing a header or footer with the table view under a specified identifier.
     - Warning: I didn't test this method before. In theory, it should work :)
     - Parameters:
     - nib: A nib object class that specifies the nib file to use to create cell
     - nibName: Custom nib name in case it differs from nib class name (which is default value)
     - identifier: Cell reuse identifier. Default value equals to nib class name
     */
    func register<T: UITableViewCell>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }

    /**
     Registers a class for use in creating new table header or footer views.
     - Parameters:
     - class: The class of a headerFooterView that you want to use in the table
     - identifier: View reuse identifier. Default value equals to view class name
     */
    func register<T: UITableViewHeaderFooterView>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    /**
     Registers a nib object containing a header or footer with the table view under a specified identifier.
     - Parameters:
     - nib: A nib object class that specifies the nib file to use to create the header or footer view.
     - nibName: custom nib name in case it differs from nib class name (which is default value)
     - identifier: View reuse identifier. Default value equals to nib class name
     */
    func register<T: UITableViewHeaderFooterView>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UICollectionView {

    /**
     Register a nib file for use in creating new collection view cells.
     - Parameters:
     - nib: A nib object class that specifies the nib file to use to create the cell
     - nibName: Custom nib name in case it differs from nib class name (which is default value)
     - identifier: Cell reuse identifier. Default value equals to nib class name
     */
    func register<T: UICollectionViewCell>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    /**
     Registers a class for use in creating new collection view cells.
     - Parameters:
     - class: The class of a cell that you want to use in the collection view
     - identifier: Cell reuse identifier. Default value equals to cell class name
     */
    func register<T: UICollectionViewCell>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forCellWithReuseIdentifier: identifier)
    }
}

extension UICollectionView {

    /**
     Enum Wrapper for UICollectionElementKindSectionHeader/Footer
     */
    enum ElementKind {
        case header, footer

        fileprivate var name: String {
            switch self {
            case .header: return UICollectionElementKindSectionHeader
            case .footer: return UICollectionElementKindSectionFooter
            }
        }
    }
}

extension UICollectionView {

    /**
     Registers a class for use in creating supplementary views for the collection view.
     - Parameters:
     - class: The class of a headerFooterView that you want to use in the table
     - elementKind: The kind of supplementary view to create
     - identifier: View reuse identifier. Default value equals to view class name
     */
    func register<T: UICollectionReusableView>(class aClass: T.Type, elementKind kind: ElementKind, identifier: String = T.storyboardIdentifier) {
        register(aClass, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: identifier)
    }

    /**
     Register a nib file for use in creating new collection view cells.
     - Parameters:
     - nib: The nib object class containing the view object.
     - nibName: Custom nib name in case it differs from nib class name (which is default value)
     - elementKind: The kind of supplementary view to create
     - identifier: View reuse identifier. Default value equals to nib class name
     */
    func register<T: UICollectionReusableView>(nib: T.Type, nibName: String = T.storyboardIdentifier, elementKind kind: ElementKind, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: identifier)
    }
}

// MARK: - Instantiating view from UINib

extension UINib {

    /**
     Instantiates the view from nib file

     Usage:
     ````
     let inviteView: InviteBannerView = UINib.instantiate()
     inviteView.configure(withType: .friends)
     return inviteView
     ````
     - Parameters:
     - nibName: Custom nib name in case it differs from nib class name (which is default value)
     - owner: The object to use as the owner of the nib file.
     - options: A dictionary containing the options to use when opening the nib file
     - bundle: The bundle in which to search for the nib file. If nil is specified then method looks for nib in main bundle
     - returns: UIView object casted to T or fatalError if case is not possible or there is no nib with specified nibName
     */
    static func instantiate<T: StoryboardIdentifiable>(nibName: String = T.storyboardIdentifier, owner: Any? = nil, options: [AnyHashable: Any]? = nil, bundle: Bundle? = nil) -> T {
        guard let view = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: options).first as? T else {
            fatalError("There is no nib with name \(nibName)")
        }

        return view
    }
}
