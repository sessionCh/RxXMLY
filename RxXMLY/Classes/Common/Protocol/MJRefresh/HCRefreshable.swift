//
//  HCRefreshable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import MJRefresh

enum HCRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

protocol OutputRefreshProtocol {

    var refreshStatus : Variable<HCRefreshStatus> { get }
}
extension OutputRefreshProtocol {
    func autoSetRefreshHeaderStatus(header: MJRefreshHeader?, footer: MJRefreshFooter?) -> Disposable {
        return refreshStatus.asObservable().subscribe(onNext: { (status) in
            switch status {
            case .beingHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                footer?.beginRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            case .noMoreData:
                footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
        })
    }
}

protocol HCRefreshable {
    
}

extension HCRefreshable where Self : UIViewController {
    
    
    func initRefreshGifHeader(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshHeader {
        
        let header = HCRefreshGifHeader(refreshingBlock: { action() })
        let iamges = [UIImage(named: "pullToRefresh_0")!,
                     UIImage(named: "pullToRefresh_1")!,
                     UIImage(named: "pullToRefresh_2")!,
                     UIImage(named: "pullToRefresh_3")!,
                     UIImage(named: "pullToRefresh_4")!,
                     UIImage(named: "pullToRefresh_5")!,
                     UIImage(named: "pullToRefresh_6")!,
                     UIImage(named: "pullToRefresh_6")!,
                     UIImage(named: "pullToRefresh_7")!,
                     UIImage(named: "pullToRefresh_8")!,
                     UIImage(named: "pullToRefresh_9") as Any]
        
        header?.setTitle("分享付费专辑，还可以赚钱哦", for: .pulling)
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.setImages(iamges, for: .pulling)
        scrollView.mj_header = header
        return scrollView.mj_header
    }
    
    func initRefreshHeader(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshHeader {
        scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { action() })
        return scrollView.mj_header
    }
    
    func initRefreshFooter(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshFooter {
        scrollView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { action() })
        return scrollView.mj_footer
    }
}

extension HCRefreshable where Self : UIScrollView {
    
    func initRefreshGifHeader(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshHeader {
        
        let header = HCRefreshGifHeader(refreshingBlock: { action() })
        let iamges = [UIImage(named: "pullToRefresh_0")!,
                      UIImage(named: "pullToRefresh_1")!,
                      UIImage(named: "pullToRefresh_2")!,
                      UIImage(named: "pullToRefresh_3")!,
                      UIImage(named: "pullToRefresh_4")!,
                      UIImage(named: "pullToRefresh_5")!,
                      UIImage(named: "pullToRefresh_6")!,
                      UIImage(named: "pullToRefresh_6")!,
                      UIImage(named: "pullToRefresh_7")!,
                      UIImage(named: "pullToRefresh_8")!,
                      UIImage(named: "pullToRefresh_9") as Any]
        header?.setTitle("分享付费专辑，还可以赚钱哦", for: .pulling)
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.setImages(iamges, for: .pulling)
        scrollView.mj_header = header
        return scrollView.mj_header
    }

    func initRefreshHeader(_ action: @escaping () -> Void) -> MJRefreshHeader {
        mj_header = MJRefreshNormalHeader(refreshingBlock: { action() })
        return mj_header
    }
    
    func initRefreshFooter(_ action: @escaping () -> Void) -> MJRefreshFooter {
        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { action()})
        return mj_footer
    }
}

