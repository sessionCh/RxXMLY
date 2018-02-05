
//
//  HCPlayUserInfoCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/6.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReusableKit
import NSObject_Rx

fileprivate struct Metric {
    
    static let cellHeight : CGFloat = 280
}

class HCPlayUserInfoCell: UITableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var introLab: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var descLab: UILabel!
    
    var userInfoModel: Variable<HCPlayUserInfoModel?> = Variable(nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
}

// MARK:- 初始化
extension HCPlayUserInfoCell {
    
    private func initUI() {
        
        iconImg.layer.masksToBounds = true
        iconImg.layer.cornerRadius =  iconImg.width / 2
    }
    
    private func bindUI() {
        
        userInfoModel.asObservable().subscribe(onNext: { [weak self] model in
            
            guard let `self` = self else { return }
            
            if let smallLogo = model?.smallLogo {
                self.iconImg.kf.setImage(with: URL(string: smallLogo))
            }
            self.titleLab.text = model?.nickname
            
            if let count = model?.followers {
                let introStr = "已被\(self.defaultPlaysCount(count))万人关注"
                self.introLab.text = introStr
            }
            
            self.descLab.text = model?.personalSignature
            
        }).disposed(by: rx.disposeBag)
    }
    
    private func defaultPlaysCount(_ playsCount: Int) -> String {
        if playsCount < 10000 {
            return "\(playsCount)"
        } else {
            let result = String(format: "%.1f万", Float(playsCount) / 10000.0)
            return result
        }
    }

    static func cellHeight() -> CGFloat {
        
        return Metric.cellHeight
    }
}

