//
//  TKTagView.swift
//  TKTagView
//
//  Created by Toseef Khilji on 15/10/18.
//  Copyright © 2018 ASApps. All rights reserved.
//

import Foundation
import UIKit

open class TKTagView: UIControl {

    private let cellId = "TKBCell"
    private var collectionView: UICollectionView!

    var onSelctionChange: (([Int])->Void)?

    @IBInspectable var stringItems: String = ""{
        didSet {
            self.items = stringItems.components(separatedBy: ",")
            reload()
        }
    }

    var items: [String] = [] {
        didSet {
            reload()
        }
    }

    var selectedIndexes: [Int] = []

    var textColor : UIColor = .blue {
        didSet {
            setSelectedColors()
        }
    }

    var selectedTextColor : UIColor = .white {
        didSet {
            setSelectedColors()
        }
    }

    var tagColor : UIColor = .white {
        didSet {
            setSelectedColors()
        }
    }

    var selectedTagColor : UIColor = .blue {
        didSet {
            setSelectedColors()
        }
    }

    var minimumLineSpacing : CGFloat = 10
    var minimumInteritemSpacing : CGFloat = 10
    var allowsMultipleSelection: Bool = true
    var scrollDirection: UICollectionView.ScrollDirection = .vertical

    /// Determines how the cells are horizontally aligned in a row.
    /// - Note: The default is `.left`.
    public var horizontalAlignment: HorizontalAlignment = .left

    /// Determines how the cells are vertically aligned in a row.
    /// - Note: The default is `.center`.
    public var verticalAlignment: VerticalAlignment = .center

    private var isAutoSelection = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required public init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }


    func setupView(){

        let theme = Theme()
        Theme.setCurrent(theme)

        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment)
        alignedFlowLayout.minimumLineSpacing = minimumLineSpacing
        alignedFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        alignedFlowLayout.estimatedItemSize = .init(width: 50, height: 40)
        alignedFlowLayout.scrollDirection = scrollDirection

        collectionView = UICollectionView(frame: bounds, collectionViewLayout: alignedFlowLayout)
        collectionView.allowsMultipleSelection = allowsMultipleSelection
        addSubview(collectionView)

        collectionView.register(UINib.init(nibName: "TKBCell", bundle: nil), forCellWithReuseIdentifier: "TKBCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }

    func setSelectedIndex() {

        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1)) {
            let ipaths = self.selectedIndexes.map { IndexPath(row: $0, section: 0) }
            self.isAutoSelection = true
            for ipths in ipaths {
                if self.collectionView.isValidIndexPath(indexPath: ipths) {
                    self.collectionView.selectItem(at: ipths, animated: true, scrollPosition: .left)
                    self.collectionView(self.collectionView, didSelectItemAt: ipths)
                } else {
                    print("Invalid Index passed")
                }
            }
            self.isAutoSelection = false
        }
    }

    func setSelectedColors(){
        var theme = Theme()
        theme.selectedTagColor = selectedTagColor
        theme.tagColor = tagColor
        theme.textColor = textColor
        theme.selectedTextColor = selectedTextColor
        Theme.setCurrent(theme)
        collectionView.reloadData()
    }

    func reload() {
        collectionView.reloadData()
        setSelectedIndex()
    }
}

extension TKTagView: UICollectionViewDelegate, UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TKBCell
        cell.item = items[indexPath.row]
        return cell
    }

    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard !isAutoSelection else { return }

        if !selectedIndexes.contains(indexPath.item) {
            selectedIndexes.append(indexPath.item)
        }

        if let handler = onSelctionChange {
            handler(selectedIndexes)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        if selectedIndexes.contains(indexPath.item) {
            selectedIndexes.remove(object: indexPath.item)
        }
        if let handler = onSelctionChange {
            handler(selectedIndexes)
        }
    }
}

struct Theme {
    var textColor: UIColor = .blue
    var selectedTextColor: UIColor = .white
    var tagColor: UIColor = .white
    var selectedTagColor: UIColor = .blue
    var font : UIFont = UIFont.systemFont(ofSize: 17)
}

extension Theme {
    static var current: Theme!
    static func setCurrent(_ theme: Theme) {
        Theme.current = theme
    }
}
