//
//  HCBoutiqueIndexHeaderView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/15.
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

class HCBoutiqueIndexHeaderView: UICollectionReusableView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomLeftLab: UILabel!
    @IBOutlet weak var bottomRightView: UIView!
        
    // MARK:- 成功回调
    typealias AddBlock = (_ indexModel: HCBoutiqueIndexModel)->Void
    var didSelectItem: AddBlock? = {
        (_) in return
    }
    
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

extension HCBoutiqueIndexHeaderView {
    
    private func initUI() {
        
        topView.backgroundColor = kThemeWhiteColor
        bottomLine.backgroundColor = kThemeLightGreyColor
        collectionView.collectionViewLayout = HCBoutiqueIndexFlowLayout()
        collectionView.register(Reusable.boutiqueIndexCell)
    }
    
    private func bindUI() {
        
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
extension HCBoutiqueIndexHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.modelArr.count / 2
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(Reusable.boutiqueIndexCell, for: indexPath)
        let index = self.modelArr.count / 2 * indexPath.section + indexPath.row
        let model = self.modelArr[index]
        if model.index == selectedModel?.index {
            cell.bottomLine.isHidden = false
        } else {
            cell.bottomLine.isHidden = true
        }
        cell.titleLab.text = model.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = self.modelArr.count / 2 * indexPath.section + indexPath.row
        let model = self.modelArr[index]
        // 回调
        didSelectItem?(model)
        // 刷新样式
        guard selectedModel?.index != model.index else { return }
        selectedModel = model
        collectionView.reloadData()
    }
}
