//
//  FirstViewController.swift
//  CollectionViewDemo
//
//  Created by HuangSenhui on 2019/12/26.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!

    var items: [String] = {
        var arr = [String]()
        for i in 0..<20 {
            let str = String(i)
            arr.append(str)
        }
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collectionViewLayout
        let layout = WaterFlowLayout()
        
        
        // collectionView
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 20, right: 5)
        view.addSubview(self.collectionView)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(addData), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
        
    }
    
    @objc func addData() {
        for item in 0..<2 {
            self.items.append("\(items.count + item)")
        }
        self.refreshControl.endRefreshing()
        self.collectionView.reloadData()
    }
    
    // MARK: - UICollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .cyan
        cell.titleLabel.text = items[indexPath.item]
        return cell
    }

}

class CollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 21))
        self.contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
