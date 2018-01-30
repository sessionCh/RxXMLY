//
//  HCScrollBarView.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TYCyclePagerView
import Kingfisher

class HCScrollBarView: UIView {
    
    var picArr = Variable<[String]>([])
    
    private let pagerView = TYCyclePagerView().then {
        $0.isInfiniteLoop = true;
        $0.autoScrollInterval = 3.0;
    }
    
    private let pageControl = TYPageControl().then {
        $0.currentPageIndicatorSize = CGSize(width: 8, height: 8)
        $0.contentHorizontalAlignment = .right
        $0.contentInset = UIEdgeInsetsMake(0, 0, 0, 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
        bindUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HCScrollBarView {
    
    
    private func initUI() {
        
        // 轮播图
        pagerView.addSubview(pageControl)
        self.addSubview(pagerView)
        
        pagerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(26)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
        }
        
        pagerView.register(UINib(nibName: String(describing: HCScrollBarCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: HCScrollBarCell.self))
        pagerView.delegate = self
        pagerView.dataSource = self
    }

    func bindUI() {
        
        // 刷新轮播图
        picArr.asObservable().subscribe { (_) in
            self.pagerView.reloadData()
            self.pageControl.numberOfPages = self.picArr.value.count
            }.disposed(by: rx.disposeBag)
    }
}

extension HCScrollBarView: TYCyclePagerViewDataSource, TYCyclePagerViewDelegate {
    
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return picArr.value.count
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: pagerView.frame.width, height: pagerView.frame.height)
        layout.itemSpacing = 0
        layout.itemHorizontalCenter = true
        
        return layout
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HCScrollBarCell", for: index) as! HCScrollBarCell
        cell.imageView.kf.setImage(with: URL(string: picArr.value[index]))
        return cell
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didScrollFrom fromIndex: Int, to toIndex: Int) {
        pageControl.currentPage = toIndex
    }
}

