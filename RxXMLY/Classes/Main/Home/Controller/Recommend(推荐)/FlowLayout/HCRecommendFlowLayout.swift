//
//  HCRecommendFlowLayout.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

class HCRecommendFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        self.scrollDirection = .vertical
        self.itemSize = HCRecommendCell.itemSize()
        let margin = HCRecommendCell.itemMargin()
        self.minimumLineSpacing = margin
        self.sectionInset = UIEdgeInsetsMake(margin, margin * 2, margin, margin * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
