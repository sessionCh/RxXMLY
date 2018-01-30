//
//  HCRecommendViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  推荐页面

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MJRefresh
import ReusableKit

class HCRecommendViewController: UIViewController, HCRefreshable {
    
    var refreshHeader: MJRefreshHeader!
    
    // ViewModel
    private var viewModel = HCRecommendViewModel()
    private var vmOutput: HCRecommendViewModel.HCRecommendOutput?
    
    // View
    private var collectionView: UICollectionView!
    
    // DataSuorce
    var dataSource : RxCollectionViewSectionedReloadDataSource<HCRecommendSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindUI()
    }
}

// MARK:- 初始化部分
extension HCRecommendViewController {
    
    private func initUI() {
        
        let layout = HCRecommendFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
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
        collectionView.register(Reusable.recommendFooter, kind: SupplementaryViewKind.footer)
    }
    
    func bindUI() {
        
        dataSource = RxCollectionViewSectionedReloadDataSource<HCRecommendSection>(configureCell: { (ds, cv, indexPath, item) -> UICollectionViewCell in
            
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 8 {
                
                let cell = cv.dequeue(Reusable.recommendCell, for: indexPath)
                
                var newItem = item

                if indexPath.section == 8 {
                    newItem.title = item.name
                    newItem.pic = item.coverLarge
                }
                
                cell.item = newItem
                return cell
            }
            
            let cell = cv.dequeue(Reusable.recommendSingleCell, for: indexPath)
            
            if indexPath.section == 4 {
                cell.cellType = .play
            } else {
                cell.cellType = .read
            }
            
            let dsSection = ds[indexPath.section]

            // 单元格 底部横线
            if let maxIndex = dsSection.category?.list?.count, indexPath.row == maxIndex - 1 {
                cell.bottomLine?.isHidden = false
                cell.bottomLine?.snp.updateConstraints({ (make) in
                    make.left.equalTo(MetricGlobal.margin * 1.5)
                    make.right.equalTo(-MetricGlobal.margin * 1.5)
                })
            } else {
                cell.bottomLine?.isHidden = false
                cell.bottomLine?.snp.updateConstraints({ (make) in
                    make.left.equalTo(cell.leftImgView.right)
                })
            }
            
            cell.item = item
            
            return cell

        }, configureSupplementaryView: { (ds, cv, kind, indexPath) in
            
            let dsSection = ds[indexPath.section]

            if kind == UICollectionElementKindSectionHeader {
                
                // 滚动条头部
                if indexPath.section == 0 {
                    
                    let recommendTopHeader = cv.dequeue(Reusable.recommendTopHeader, kind: .header, for: indexPath)
                    let picArr = dsSection.focusList?.map({ (model) -> String in
                        return model.cover
                    }) ?? []
                    recommendTopHeader.picArr.value = picArr
                    var guessYouLike = dsSection.category
                    guessYouLike?.title = "猜你喜欢"
                    recommendTopHeader.categoryModel.value = guessYouLike
                    
                    if let squareList = dsSection.squareList {
                        recommendTopHeader.squareArr.value = squareList
                    }
                    
                    return recommendTopHeader
                }
                // 其他头部
                else {
                    
                    let recommendHeader = cv.dequeue(Reusable.recommendHeader, kind: .header, for: indexPath)
                    
                    recommendHeader.categoryModel.value = dsSection.category
                    
                    return recommendHeader
                }
            } else {
                
                // 横线
                let recommendFooter = cv.dequeue(Reusable.recommendFooter, kind: .footer, for: indexPath)
                if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 8 {
                    recommendFooter.topLine.isHidden = false
                } else {
                    recommendFooter.topLine.isHidden = true
                }
                return recommendFooter
            }
        })
        
        vmOutput = viewModel.transform(input: HCRecommendViewModel.HCRecommendInput())
        
        vmOutput?.sections.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        refreshHeader = initRefreshGifHeader(collectionView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(true)
        }
        let refreshFooter = initRefreshFooter(collectionView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(false)
        }
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: refreshFooter).disposed(by: rx.disposeBag)
        
        refreshHeader.beginRefreshing()
    }
}

// MARK:- 布局
extension HCRecommendViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 8 {
            
            return HCRecommendCell.itemSize()
        }
        
        return HCRecommendSingleCell.itemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            
            return HCRecommendTopHeaderView.headerSize()
            
        } else if section == 1 || section == 4 || section == 8 {
            
            return HCRecommendHeaderView.minHeaderSize()
        }
        
        return HCRecommendHeaderView.defaultHeaderSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return HCRecommendFooterView.footerSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 8 {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        // HCRecommendSingleCell 设置高亮
        let cell = collectionView.cellForItem(at: indexPath) as? HCRecommendSingleCell
        cell?.contentView.backgroundColor = kThemeOrangeRedColor
        cell?.bottomLine?.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as? HCRecommendSingleCell
        cell?.contentView.backgroundColor = kThemeWhiteColor
        cell?.bottomLine?.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 || section == 1 || section == 8 {
            return UIEdgeInsets(top: 0, left: HCRecommendCell.itemMargin() * 1.5, bottom: 0, right: HCRecommendCell.itemMargin() * 1.5)
        }
        return UIEdgeInsets.zero
    }
}

private enum Reusable {
    
    static let recommendCell = ReusableCell<HCRecommendCell>(nibName: "HCRecommendCell")
    
    static let recommendSingleCell = ReusableCell<HCRecommendSingleCell>(nibName: "HCRecommendSingleCell")

    static let recommendTopHeader = ReusableView<HCRecommendTopHeaderView>(identifier: "HCRecommendTopHeaderView", nibName: "HCRecommendTopHeaderView")
    
    static let recommendHeader = ReusableView<HCRecommendHeaderView>(identifier: "HCRecommendHeaderView", nibName: "HCRecommendHeaderView")
    
    static let recommendFooter = ReusableView<HCRecommendFooterView>(identifier: "HCRecommendFooterView", nibName: "HCRecommendFooterView")
}

