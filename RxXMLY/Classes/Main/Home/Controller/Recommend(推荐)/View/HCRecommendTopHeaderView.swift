//
//  HCRecommendTopHeaderView.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReusableKit


fileprivate struct Metric {
    
    static let scale : CGFloat = 380 / 375
}

fileprivate enum Reusable {
    static let squareCell = ReusableCell<HCSquareCell>(nibName: "HCSquareCell")
}

public enum HCRecommendTopHeaderViewType {
    
    case none
    case recommend
    case boutique
}

class HCRecommendTopHeaderView: UICollectionReusableView {
    
    var scrollBar: HCScrollBarView!
    var headerView: HCRecommendHeaderView!

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var centerBottomView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomViewTopCons: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var bottomHeaderView: UIView!
    
    var picArr = Variable<[String]>([])
    var squareArr = Variable<[HCSquareModel]>([])
    var categoryModel: Variable<HCCategoryModel?> = Variable(nil)
    var modelArr: [HCSquareModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
}

extension HCRecommendTopHeaderView {
    
    private func initUI() {
        
        // 滚动条
        let scrollBar = HCScrollBarView()
        self.scrollBar = scrollBar
        topView.addSubview(scrollBar)
        scrollBar.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 分类
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = HCSquareFlowLayout()
        collectionView.register(Reusable.squareCell)
        centerBottomView.backgroundColor = kThemeGainsboroColor
 
        // 猜你喜欢
        let headerView = HCRecommendHeaderView.loadFromNib()
        self.headerView = headerView
        bottomHeaderView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindUI() {
 
        // 分类
        squareArr.asObservable().subscribe(onNext: { (squareArr) in
            self.modelArr = squareArr
            self.collectionView.reloadData()
        }).disposed(by: rx.disposeBag)
        
        // 滚动条 立即前往
        picArr.asObservable().subscribe(onNext: { (picArr) in
            self.scrollBar.picArr.value = picArr
            let pic = "http://fdfs.xmcdn.com/group36/M01/FA/C4/wKgJUloqThKzE1oLAAJQ1xgg26s045.png"
            self.bottomBtn.kf.setBackgroundImage(with: URL(string: pic), for: .normal)
        }).disposed(by: rx.disposeBag)

        // 头部标题
        categoryModel.asObservable().subscribe(onNext: { model in
            self.headerView.categoryModel.value = model
        }).disposed(by: rx.disposeBag)
    }
    
    static func headerSize() -> CGSize {
        
        let height = kScreenW * Metric.scale

        return CGSize(width: kScreenW, height: height)
    }
    
    static func headerSize(type: HCRecommendTopHeaderViewType) -> CGSize {
        
        if type == .boutique {
            
            let height = kScreenW * (380 - 83.5) / 375
            
            return CGSize(width: kScreenW, height: height)
        }
        
        let height = kScreenW * Metric.scale
        
        return CGSize(width: kScreenW, height: height)
    }
}

// MARK:- 代理
extension HCRecommendTopHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.modelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(Reusable.squareCell, for: indexPath)
        let model = self.modelArr[indexPath.row]
        cell.titleLab.text = model.title
        cell.iconImg.kf.setImage(with: URL(string: model.coverPath))
        
        return cell
    }
}

