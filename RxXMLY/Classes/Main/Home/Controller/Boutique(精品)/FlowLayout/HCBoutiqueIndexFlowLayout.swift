//
//  HCBoutiqueIndexFlowLayout.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/16.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

class HCBoutiqueIndexFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        self.scrollDirection = .vertical
        self.itemSize = HCBoutiqueIndexCell.itemSize()
        self.minimumLineSpacing = 0.0
        let margin = HCBoutiqueIndexCell.itemMargin()
        self.sectionInset = UIEdgeInsetsMake(0, margin * 1.5, 0, margin * 1.5)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
