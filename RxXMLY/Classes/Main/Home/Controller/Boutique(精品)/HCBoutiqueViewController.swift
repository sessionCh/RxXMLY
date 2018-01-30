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
    private var boutiqueIndexHeader: HCBoutiqueIndexHeaderView?
    private var headerView: UIView?
    private var offsetTop: CGFloat = 0.0

    // DataSuorce
    var dataSource : RxCollectionViewSectionedReloadDataSource<HCBoutiqueSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindUI()
    }
}

// MARK:- 初始化部分
extension HCBoutiqueViewController {
    
    private func initCollectionView() {
        
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
    
    private func initSingleHeaderView() {
    
        // 悬浮滚动条 (直接添加xib显示不出来)
        let singleHeaderView = HCBoutiqueSingleHeaderView.loadFromNib()
        singleHeaderView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: HCBoutiqueSingleHeaderView.singleHeight())
        
        // 点击滚动到指定位置
        singleHeaderView.didSelectItem = { [weak self] (model) in
            guard let `self` = self else { return }
            // 滚动到指定位置
            let indexPath = IndexPath(row: 0, section: model.index)
            let attr = self.collectionView.layoutAttributesForItem(at: indexPath)
            if let rect = attr?.frame {
                var newRect = rect
                newRect.size = self.collectionView.frame.size
                newRect.height = newRect.height - kNavibarH - 30 - 44
                self.collectionView.scrollRectToVisible(newRect, animated: true)
            }
            
            // 同步数据
            self.boutiqueIndexHeader?.selectedModel = model
            self.boutiqueIndexHeader?.collectionView.reloadData()
        }
        let headerView = UIView()
        headerView.frame = singleHeaderView.bounds
        headerView.addSubview(singleHeaderView)
        self.headerView = headerView
        view.addSubview(headerView)
        view.bringSubview(toFront: headerView)
    }
    
    private func initUI() {
        
        // 集合
        initCollectionView()
        
        // 悬浮条
        initSingleHeaderView()
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
                    
                    self.offsetTop = self.collectionView.layoutAttributesForItem(at: indexPath)?.frame.top ?? 0.0
                    
                    let boutiqueIndexHeader = cv.dequeue(Reusable.boutiqueIndexHeader, kind: .header, for: indexPath)
                    // 加载数据
                    if let indexArr = dsSection.indexList {
                        boutiqueIndexHeader.boutiqueIndexArr.value = indexArr
                        // 滚动条
                        let singleHeaderView = self.headerView?.subviews.first as? HCBoutiqueSingleHeaderView
                        singleHeaderView?.boutiqueIndexArr.value = indexArr
                    }
                    
                    // 处理点击事件
                    boutiqueIndexHeader.didSelectItem = { [weak self] (model) in
                        guard let `self` = self else { return }
                        // 滚动到指定位置
                        let indexPath = IndexPath(row: 0, section: model.index)
                        let attr = self.collectionView.layoutAttributesForItem(at: indexPath)
                        if let rect = attr?.frame {
                            var newRect = rect
                            newRect.size = self.collectionView.frame.size
                            newRect.height = newRect.height - kNavibarH - 30
                            self.collectionView.scrollRectToVisible(newRect, animated: true)
                        }
                        
                        // 滚动条 同步数据
                        let singleHeaderView = self.headerView?.subviews.first as? HCBoutiqueSingleHeaderView
                        singleHeaderView?.selectedModel =  model
                        singleHeaderView?.collectionView.reloadData()
                        
                        DispatchQueue.main.async {
                            singleHeaderView?.collectionView.scrollToItem(at: IndexPath(row: model.index - 1, section: 0), at: .centeredHorizontally, animated: true)
                        }
                    }
                    self.boutiqueIndexHeader = boutiqueIndexHeader
                    return boutiqueIndexHeader
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
                if indexPath.section == 0 {
                    recommendFooter.topLine.isHidden = false
                } else {
                    recommendFooter.topLine.isHidden = true
                }

                return recommendFooter
            }
        })
        
        vmOutput = viewModel.transform(input: HCBoutiqueViewModel.HCBoutiqueInput())
        
        vmOutput?.sections.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        refreshHeader = initRefreshGifHeader(collectionView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(true)
        }
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: nil).disposed(by: rx.disposeBag)
        
        // 刷新
        refreshHeader.beginRefreshing()
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
        
        if indexPath.section == 0 {
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
        if section == 0 {
            return UIEdgeInsets(top: 0, left: MetricGlobal.margin * 1.5, bottom: 0, right: MetricGlobal.margin * 1.5)
        }
        return UIEdgeInsets.zero
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        HCLog("\(scrollView.contentOffset) - \(offsetTop)")
        // 减去 分页头部 滚动条徒步
        let margin = offsetTop - HCHomeViewController.pagerBarHeight() - HCBoutiqueSingleHeaderView.singleHeight()
        if scrollView.contentOffset.y > 0 &&
            margin > 0 &&
            scrollView.contentOffset.y >= margin {
            self.headerView?.isHidden = false
        } else {
            self.headerView?.isHidden = true
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


