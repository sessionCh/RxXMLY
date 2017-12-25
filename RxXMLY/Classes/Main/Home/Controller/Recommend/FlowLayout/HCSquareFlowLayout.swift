//
//  HCSquareFlowLayout.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

class HCSquareFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        self.scrollDirection = .horizontal
        self.itemSize = HCSquareCell.itemSize()
        let margin = HCSquareCell.itemMargin()
        self.minimumLineSpacing = margin
        self.sectionInset = UIEdgeInsetsMake(margin, margin * 2, margin, margin * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

