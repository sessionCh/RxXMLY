
//
//  HCPlayHeaderView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/24.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReusableKit
import NSObject_Rx

class HCPlayHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var topTitleLab: UILabel!
    @IBOutlet weak var topImgBackgroundView: UIView!
    @IBOutlet weak var topImgView: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomCenterView: UIView!
    
    @IBOutlet weak var danmuBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var clockBtn: UIButton!
    @IBOutlet weak var listLab: UILabel!
    @IBOutlet weak var clockLab: UILabel!

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var playModel: Variable<HCPlayModel?> = Variable(nil)

    private lazy var progressView = HCPlayProgressView.loadFromNib()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
}

extension HCPlayHeaderView {
    
    private func initUI() {
        
        // 设置样式
        topImgBackgroundView.layer.shadowColor = kThemeGreyColor.cgColor
        topImgBackgroundView.layer.shadowOpacity = 0.8
        topImgBackgroundView.layer.shadowOffset = CGSize(width: -3, height: -3)
        topImgBackgroundView.layer.shadowRadius = 6
        
//        topImgView.layer.masksToBounds = true
//        topImgView.layer.cornerRadius = 30.0
        
        progressView.frame = bottomCenterView.bounds
        bottomCenterView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        // 初始化
        topTitleLab.text = "【免费试听】中国有嘻哈火了，是因为经济不好了？？？？"
        topImgView.image = UIImage(named: "favicon")
    }
    
    private func bindUI() {
        
        playModel.asObservable().subscribe(onNext: { [weak self] model in
            
            guard let `self` = self else { return }
            self.topTitleLab.text = model?.trackInfo?.title
            
            if let coverLarge = model?.trackInfo?.coverLarge {
                self.topImgView.kf.setImage(with: URL(string: coverLarge))
            }
        }).disposed(by: rx.disposeBag)
    }
}
