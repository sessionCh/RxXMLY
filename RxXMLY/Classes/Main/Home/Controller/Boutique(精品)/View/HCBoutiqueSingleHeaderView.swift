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
    
    static let singleHeight : CGFloat = 44.0
    static let twoHeight : CGFloat = 80.0

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
    @IBOutlet weak var topViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var collectionViewRightCons: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    
    // MARK:- 成功回调
    typealias AddBlock = (_ indexModel: HCBoutiqueIndexModel)->Void
    var didSelectItem: AddBlock? = {
        (_) in return
    }
    typealias RightBtnBlock = (_ isUp: Bool)->Void
    var rightBtnClick: RightBtnBlock? = {
        (_) in return
    }
    
    let horizontalLayout = HCBoutiqueSingleIndexFlowLayout(.horizontal)
    let verticalLayout = HCBoutiqueSingleIndexFlowLayout(.vertical)

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
    
    static func singleHeight() -> CGFloat {
        
        return Metric.singleHeight
    }

    private func initUI() {
        
        self.frame = CGRect(x: 0, y: 0, width: kScreenW, height: Metric.singleHeight)
        
        backgroundView.alpha = 0.35
        backgroundView.backgroundColor = kThemeBlackColor
        
        bottomLine.backgroundColor = kThemeLightGreyColor
        
        btnView.layer.shadowColor = kThemeLightGreyColor.cgColor
        btnView.layer.shadowOpacity = 0.8
        btnView.layer.shadowOffset = CGSize(width: -2, height: 0)
        btnView.layer.shadowRadius = 5
        collectionView.collectionViewLayout = self.horizontalLayout
        collectionView.register(Reusable.boutiqueIndexCell)
    }
    
    private func updateUI(isUp: Bool) {
        
        // 重新设置布局
        self.collectionView.collectionViewLayout.invalidateLayout()
        
        if isUp == true {
            
            self.superview?.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kNavibarH)
            self.frame = (self.superview?.bounds)!
            self.height = (self.superview?.height)!
            self.btnView.isHidden = true
            self.topViewHeightCons.constant = Metric.twoHeight
            self.collectionViewRightCons.constant = -Metric.twoHeight
            DispatchQueue.main.async {
                self.collectionView.setCollectionViewLayout(self.verticalLayout, animated: true)
            }

        } else {
            self.superview?.frame = CGRect(x: 0, y: 0, width: kScreenW, height: Metric.singleHeight)
            self.frame = (self.superview?.bounds)!
            self.btnView.isHidden = false
            self.topViewHeightCons.constant = Metric.singleHeight
            self.collectionViewRightCons.constant = 0
            DispatchQueue.main.async {
                self.collectionView.setCollectionViewLayout(self.horizontalLayout, animated: true)
            }
        }
        self.collectionView.reloadData()
        self.superview?.layoutIfNeeded()
    }
    
    private func bindUI() {
        
        rightBtn.rx.tap.do(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.isUp = !self.isUp            
            self.updateUI(isUp: self.isUp)
            
        }).subscribe().disposed(by: rx.disposeBag)
        
        backgroundView.rx.tapGesture().when(.recognized).subscribe({ [weak self] _ in
            guard let `self` = self else { return }
            self.isUp = false
            self.updateUI(isUp: self.isUp)
            
            DispatchQueue.main.async {
                if let model = self.selectedModel {
                    self.collectionView.scrollToItem(at: IndexPath(row: model.index - 1, section: 0), at: .centeredHorizontally, animated: true)
                }
            }
        }).disposed(by: rx.disposeBag)
        
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
        if self.isUp == true {
            return 2
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isUp == true {
            return self.modelArr.count / 2
        }
        return self.modelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(Reusable.boutiqueIndexCell, for: indexPath)
        let index = indexPath.row + indexPath.section * self.modelArr.count / 2
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
        
        let index = indexPath.row + indexPath.section * self.modelArr.count / 2
        let model = self.modelArr[index]
   
        // 刷新样式
        self.isUp = false
        self.updateUI(isUp: self.isUp)

        guard selectedModel?.index != model.index else { return }
        selectedModel = model
        collectionView.reloadData()
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(row: model.index - 1, section: 0), at: .centeredHorizontally, animated: true)
        }

        // 回调
        didSelectItem?(model)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.isUp == true {
            return HCBoutiqueIndexCell.singleItemSize()
        }
        return HCBoutiqueIndexCell.itemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin = HCBoutiqueIndexCell.itemMargin()
        if self.isUp == true {
            return UIEdgeInsetsMake(0, margin * 1.5, 0, margin * 1.5)
        }
        return UIEdgeInsetsMake(0, margin * 1.5, 0, 0)
    }
}

