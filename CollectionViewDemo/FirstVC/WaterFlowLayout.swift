//
//  WaterFlowLayout.swift
//  CollectionViewDemo
//
//  Created by HuangSenhui on 2019/12/29.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

import UIKit

class WaterFlowLayout: UICollectionViewFlowLayout {

    var attributeArray: [UICollectionViewLayoutAttributes]?
            
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        let sectionIndex = collectionView.numberOfSections - 1
        let itemCount = collectionView.numberOfItems(inSection: sectionIndex)
        
        attributeArray = [UICollectionViewLayoutAttributes]()
        let itemW = (self.collectionView!.bounds.size.width - self.minimumInteritemSpacing * 3) / 2
        var column: (oneH: Int,twoH: Int) = (0,0)
        
        for index in 0..<itemCount {
            let indexPath = IndexPath(item: index, section: sectionIndex)
            let attris = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 新的Item放置最短列
            let itemH = index % 2 == 0 ? 280 : 240
            let onLeft = column.oneH <= column.twoH
            if onLeft {
                column.oneH += (itemH + Int(self.minimumInteritemSpacing))
            } else {
                column.twoH += (itemH + Int(self.minimumInteritemSpacing))
            }
            let itemY = onLeft ? column.oneH - itemH : column.twoH - itemH
            let itemX = (self.minimumInteritemSpacing + itemW) * CGFloat(onLeft ? 0 : 1)
            attris.frame = CGRect(x: itemX, y: CGFloat(itemY), width: itemW, height: CGFloat(itemH))
            // 缓存布局
            attributeArray?.append(attris)
        }
        
        if column.oneH <= column.twoH {
            self.itemSize = CGSize(width: itemW, height: CGFloat(column.twoH * 2 / itemCount) - self.minimumLineSpacing)
        } else {
            self.itemSize = CGSize(width: itemW, height: CGFloat(column.oneH * 2 / itemCount) - self.minimumLineSpacing)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributeArray?[indexPath.item]
    }
    
}

