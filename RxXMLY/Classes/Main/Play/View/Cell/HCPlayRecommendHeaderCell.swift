//
//  HCPlayRecommendHeaderCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/6.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  推荐部分

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources
import ReusableKit
import NSObject_Rx

// MARK:- 常量
fileprivate struct Metric {
    
    static let defaultHeight : CGFloat = 90.0
    static let minHeight : CGFloat = 50.0
}

class HCPlayRecommendHeaderCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var leftTitle: UILabel!
    @IBOutlet weak var leftSubView: UIView!
    @IBOutlet weak var leftSubTitle: UILabel!
    
    @IBOutlet weak var rightSubView: UIView!
    @IBOutlet weak var rightSubTitle: UILabel!
    
    @IBOutlet weak var tagView1: UIView!
    @IBOutlet weak var tagView2: UIView!
    @IBOutlet weak var tagView3: UIView!
    @IBOutlet weak var tagView4: UIView!
    
    @IBOutlet weak var tagLab1: UILabel!
    @IBOutlet weak var tagLab2: UILabel!
    @IBOutlet weak var tagLab3: UILabel!
    @IBOutlet weak var tagLab4: UILabel!
    
    var playModel: Variable<HCPlayModel?> = Variable(nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
}

// MARK:- 初始化
extension HCPlayRecommendHeaderCell {
    
    private func initUI() {
        
        tagView1.backgroundColor = .clear
        tagView1.layer.cornerRadius = tagView1.height / 2
        tagView1.layer.masksToBounds = true
        tagView1.layer.borderColor = UIColor.darkGray.cgColor
        tagView1.layer.borderWidth = 0.6
        
        tagView2.backgroundColor = .clear
        tagView2.layer.cornerRadius = tagView2.height / 2
        tagView2.layer.masksToBounds = true
        tagView2.layer.borderColor = UIColor.darkGray.cgColor
        tagView2.layer.borderWidth = 0.6
        
        tagView3.backgroundColor = .clear
        tagView3.layer.cornerRadius = tagView3.height / 2
        tagView3.layer.masksToBounds = true
        tagView3.layer.borderColor = UIColor.darkGray.cgColor
        tagView3.layer.borderWidth = 0.6
        
        tagView4.backgroundColor = .clear
        tagView4.layer.cornerRadius = tagView4.height / 2
        tagView4.layer.masksToBounds = true
        tagView4.layer.borderColor = UIColor.darkGray.cgColor
        tagView4.layer.borderWidth = 0.6
    }
    
    private func bindUI() {
        
        playModel.asObservable().subscribe(onNext: { [weak self] model in
            
            guard let `self` = self else { return }

            self.leftSubView.isHidden = true
            self.rightSubView.isHidden = true
            
            self.leftTitle.text = model?.noCacheInfo?.recAlbumsPanelTitle
            
            if let keywordStr = model?.albumInfo?.tags {
                
                let keywords = keywordStr.components(separatedBy: ",")
                
                if keywords.count >= 4 {
                    self.height = Metric.defaultHeight
                    self.bottomView.isHidden = false
                    
                    self.tagLab1.text = keywords[0]
                    self.tagLab2.text = keywords[1]
                    self.tagLab3.text = keywords[2]
                    self.tagLab4.text = keywords[3]
                    return
                }
            }
            self.height = Metric.minHeight
            self.bottomView.isHidden = true
            return
            
        }).disposed(by: rx.disposeBag)
    }
    
    static func defaultCellHeight() -> CGFloat {
        
        return Metric.defaultHeight
    }
    
    static func minCellHeight() -> CGFloat {
        
        return  Metric.minHeight
    }
}


