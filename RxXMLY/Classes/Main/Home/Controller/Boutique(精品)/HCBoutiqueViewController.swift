//
//  HCBoutiqueViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/14.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MJRefresh
import ReusableKit

class HCBoutiqueViewController: UIViewController, HCRefreshable {
    var refreshHeader: MJRefreshHeader!
    
    // ViewModel
    private var viewModel = HCBoutiqueViewModel()
    private var vmOutput: HCBoutiqueViewModel.HCBoutiqueOutput?
    
    // View
    private var collectionView: UICollectionView!
    
    // DataSuorce
    var dataSource : RxCollectionViewSectionedReloadDataSource<HCBoutiqueSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindUI()
        
        refreshHeader.beginRefreshing()
    }
}

// MARK:- 初始化部分
extension HCBoutiqueViewController {
    
    private func initUI() {
        
        let layout = HCRecommendFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = kThemeWhiteColor
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        // 设置代理
        collectionView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        // 注册cell
        collectionView.register(Reusable.recommendCell)
        collectionView.register(Reusable.recommendSingleCell)
        collectionView.register(Reusable.recommendTopHeader, kind: SupplementaryViewKind.header)
        collectionView.register(Reusable.recommendHeader, kind: SupplementaryViewKind.header)
        collectionView.register(Reusable.boutiqueIndexHeader, kind: SupplementaryViewKind.header)
        collectionView.register(Reusable.recommendFooter, kind: SupplementaryViewKind.footer)
        collectionView.register(Reusable.boutiqueFooter, kind: SupplementaryViewKind.footer)
    }
    
    func bindUI() {
        
        dataSource = RxCollectionViewSectionedReloadDataSource<HCBoutiqueSection>(configureCell: { (ds, cv, indexPath, item) -> UICollectionViewCell in
            
            if indexPath.section == 0 {
                
                let cell = cv.dequeue(Reusable.recommendCell, for: indexPath)
                // 属性有变化
                var newItem = item
                newItem.pic = item.coverMiddle
              
                cell.item = newItem
                
                return cell
            }
            
            let cell = cv.dequeue(Reusable.recommendSingleCell, for: indexPath)
            // 属性有变化
            var newItem = item
            newItem.pic = item.coverMiddle
            newItem.subtitle = item.intro
            newItem.playsCount = item.playsCounts
            newItem.tracksCount = item.tracks
            
            cell.cellType = .read
            cell.item = newItem

            return cell
            
        }, configureSupplementaryView: { (ds, cv, kind, indexPath) in
            
            let dsSection = ds[indexPath.section]
            
            if kind == UICollectionElementKindSectionHeader {
                
                // 滚动条头部
                if indexPath.section == 0 {
                    
                    let recommendTopHeader = cv.dequeue(Reusable.recommendTopHeader, kind: .header, for: indexPath)
                    recommendTopHeader.bottomView.isHidden = true
                    recommendTopHeader.bottomViewTopCons.constant = -recommendTopHeader.bottomView.height
                    let picArr = dsSection.focusList?.map({ (model) -> String in
                        return model.cover
                    }) ?? []
                    recommendTopHeader.picArr.value = picArr
                    recommendTopHeader.categoryModel.value = dsSection.category
                    
                    if let squareList = dsSection.squareList {
                        recommendTopHeader.squareArr.value = squareList
                    }
                    
                    return recommendTopHeader
                }
                    // 每日优选
                else if indexPath.section == 1 {
                    
                    let recommendHeader = cv.dequeue(Reusable.boutiqueIndexHeader, kind: .header, for: indexPath)
                    
//                    recommendHeader.categoryModel.value = dsSection.category
                    
                    return recommendHeader
                }
                    // 其他头部
                else {
                    
                    let recommendHeader = cv.dequeue(Reusable.recommendHeader, kind: .header, for: indexPath)
                    
                    recommendHeader.categoryModel.value = dsSection.category
                    
                    return recommendHeader
                }
            } else {
                
                if indexPath.section == 10 {
                    
                    let boutiqueFooter = cv.dequeue(Reusable.boutiqueFooter, kind: .footer, for: indexPath)
 
                    return boutiqueFooter
                }
                
                let recommendFooter = cv.dequeue(Reusable.recommendFooter, kind: .footer, for: indexPath)
                
                return recommendFooter
            }
        })
        
        vmOutput = viewModel.transform(input: HCBoutiqueViewModel.HCBoutiqueInput())
        
        vmOutput?.sections.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        refreshHeader = initRefreshGifHeader(collectionView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(true)
        }
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: nil).disposed(by: rx.disposeBag)
    }
}

// MARK:- 布局
extension HCBoutiqueViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            
            return HCRecommendCell.itemSize()
        }
        
        return HCRecommendSingleCell.itemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
        
            return HCRecommendTopHeaderView.headerSize(type: .boutique)
        } else if section == 1 {
            
            return HCBoutiqueIndexHeaderView.defaultHeaderSize()
        }
        
        return HCRecommendHeaderView.minHeaderSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 10 {
            return HCBoutiqueFooterView.defaultHeaderSize()
        }
        return HCRecommendFooterView.footerSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = kThemeOrangeRedColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = kThemeWhiteColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: MetricGlobal.margin, bottom: 0, right: MetricGlobal.margin)
        } else {
            return UIEdgeInsets.zero
        }
    }
}

private enum Reusable {
    
    static let recommendCell = ReusableCell<HCRecommendCell>(nibName: "HCRecommendCell")
    
    static let recommendSingleCell = ReusableCell<HCRecommendSingleCell>(nibName: "HCRecommendSingleCell")
    
    static let recommendTopHeader = ReusableView<HCRecommendTopHeaderView>(identifier: "HCRecommendTopHeaderView", nibName: "HCRecommendTopHeaderView")
    
    static let recommendHeader = ReusableView<HCRecommendHeaderView>(identifier: "HCRecommendHeaderView", nibName: "HCRecommendHeaderView")
    
    static let recommendFooter = ReusableView<HCRecommendFooterView>(identifier: "HCRecommendFooterView", nibName: "HCRecommendFooterView")
    
    static let boutiqueIndexHeader = ReusableView<HCBoutiqueIndexHeaderView>(identifier: "HCBoutiqueIndexHeaderView", nibName: "HCBoutiqueIndexHeaderView")
    
    static let boutiqueFooter = ReusableView<HCBoutiqueFooterView>(identifier: "HCBoutiqueFooterView", nibName: "HCBoutiqueFooterView")
}


