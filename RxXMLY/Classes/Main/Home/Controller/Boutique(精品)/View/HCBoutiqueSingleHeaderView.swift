//
//  HCBoutiqueSingleHeaderView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/17.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReusableKit

fileprivate struct Metric {
    
    static let defaultHeight : CGFloat = 135.0
}

fileprivate enum Reusable {
    static let boutiqueIndexCell = ReusableCell<HCBoutiqueIndexCell>(nibName: "HCBoutiqueIndexCell")
}

class HCBoutiqueSingleHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var collectionViewRightCons: NSLayoutConstraint!
    
    // MARK:- 成功回调
    typealias AddBlock = (_ indexModel: HCBoutiqueIndexModel)->Void
    var didSelectItem: AddBlock? = {
        (_) in return
    }
    typealias RightBtnBlock = (_ isUp: Bool)->Void
    var rightBtnClick: RightBtnBlock? = {
        (_) in return
    }
    
    var isUp: Bool = false
    var boutiqueIndexArr = Variable<[HCBoutiqueIndexModel]>([])
    var modelArr: [HCBoutiqueIndexModel] = []
    var selectedModel: HCBoutiqueIndexModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
    
    static func defaultHeaderSize() -> CGSize {
        
        return CGSize(width: kScreenW, height: Metric.defaultHeight)
    }
}

extension HCBoutiqueSingleHeaderView {
    
    private func initUI() {
        bottomLine.backgroundColor = kThemeLightGreyColor
        btnView.layer.shadowColor = kThemeLightGreyColor.cgColor
        btnView.layer.shadowOpacity = 2.0
        btnView.layer.shadowOffset = CGSize(width: 0, height: 0)
        btnView.layer.shadowRadius = 5
        collectionView.isUserInteractionEnabled = true
        collectionView.collectionViewLayout = HCBoutiqueSingleIndexFlowLayout()
        collectionView.register(Reusable.boutiqueIndexCell)
    }
    
    private func bindUI() {
        
        rightBtn.rx.tap.do(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.isUp = !self.isUp
            self.rightBtnClick?(true)
            if self.isUp == true {
                self.height = 80.0
                self.btnView.isHidden = true
                self.collectionView.collectionViewLayout = HCBoutiqueSingleIndexFlowLayout(.vertical)
                
            } else {
                self.height = 40.0
                self.btnView.isHidden = false
                self.collectionViewRightCons.constant = 0
                self.collectionView.collectionViewLayout = HCBoutiqueSingleIndexFlowLayout(.horizontal)
            }
            
            self.layoutIfNeeded()
            self.collectionView.reloadData()
            
        }).subscribe().disposed(by: rx.disposeBag)
        
        boutiqueIndexArr.asObservable().subscribe(onNext: { [weak self] (boutiqueIndexArr) in
            guard let `self` = self else { return }
            self.modelArr = boutiqueIndexArr
            if self.selectedModel == nil {
                self.selectedModel = boutiqueIndexArr.first
            }
            self.collectionView.reloadData()
        }).disposed(by: rx.disposeBag)
    }
}

// MARK:- 代理
extension HCBoutiqueSingleHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(Reusable.boutiqueIndexCell, for: indexPath)
        let model = self.modelArr[indexPath.row]
        if model.index == selectedModel?.index {
            cell.bottomLine.isHidden = false
        } else {
            cell.bottomLine.isHidden = true
        }
        cell.titleLab.text = model.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = self.modelArr[indexPath.row]
        // 回调
        didSelectItem?(model)
        // 刷新样式
        guard selectedModel?.index != model.index else { return }
        selectedModel = model
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return HCBoutiqueIndexCell.singleItemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin = HCBoutiqueIndexCell.itemMargin()
        
        return UIEdgeInsetsMake(0, margin * 1.5, 0, 0)
    }
}

