//
//  HCBoutiqueSingleIndexFlowLayout.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/17.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

class HCBoutiqueSingleIndexFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        self.scrollDirection = .horizontal
        self.itemSize = HCBoutiqueIndexCell.singleItemSize()
        self.minimumLineSpacing = 0.0
        let margin = HCBoutiqueIndexCell.itemMargin()
        self.sectionInset = UIEdgeInsetsMake(0, margin * 1.5, 0, 0)
    }
    
    init(_ scrollDirection: UICollectionViewScrollDirection) {
        
        super.init()
        if scrollDirection == .horizontal {
            
            self.scrollDirection = scrollDirection
            self.itemSize = HCBoutiqueIndexCell.singleItemSize()
            self.minimumLineSpacing = 0.0
            let margin = HCBoutiqueIndexCell.itemMargin()
            self.sectionInset = UIEdgeInsetsMake(0, margin * 1.5, 0, 0)
            
        } else {
            self.scrollDirection = scrollDirection
            self.itemSize = HCBoutiqueIndexCell.itemSize()
            self.minimumLineSpacing = 0.0
            let margin = HCBoutiqueIndexCell.itemMargin()
            self.sectionInset = UIEdgeInsetsMake(0, margin * 1.5, 0, margin * 1.5)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
