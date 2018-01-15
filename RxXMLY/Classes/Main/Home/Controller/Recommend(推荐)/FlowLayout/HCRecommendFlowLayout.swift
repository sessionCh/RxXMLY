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
        self.minimumLineSpacing = 0.0
        self.sectionInset = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
