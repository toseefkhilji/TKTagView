//
//  UICollectionView+Extension.swift
//  TKTagView
//
//  Created by Toseef Khilji on 17/10/18.
//  Copyright © 2018 ASApps. All rights reserved.
//

import UIKit

extension UICollectionView {

    /// Check if given indexpath is Valid or not
    func isValidIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfItems(inSection: indexPath.section)
    }
}

extension Array where Element: Equatable {

    /// Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
