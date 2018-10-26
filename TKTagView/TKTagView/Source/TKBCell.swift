//
//  TKBCell.swift
//  TKBreadCrumpView
//
//  Created by Toseef Khilji on 10/07/18.
//  Copyright © 1518 My Owan. All rights reserved.
//

import UIKit

class TKBCell: UICollectionViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lblItem: UILabel!

    var item: String! {
        didSet {
            self.lblItem.text = item
        }
    }

    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? Theme.current.selectedTagColor : Theme.current.tagColor
            containerView.layer.borderWidth = isSelected ? 0 : 1.0
            containerView.layer.borderColor = isSelected ? UIColor.clear.cgColor : Theme.current.selectedTagColor.cgColor
            lblItem.textColor = isSelected ? Theme.current.selectedTextColor : Theme.current.textColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.backgroundColor = Theme.current.tagColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = Theme.current.selectedTagColor.cgColor
        lblItem.textColor = Theme.current.textColor
        lblItem.font = Theme.current.font
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
