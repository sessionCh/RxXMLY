//
//  HCPlaySynopsisCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/4.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  声音简介

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources
import ReusableKit
import NSObject_Rx

// MARK:- 常量
fileprivate struct Metric {
    
    static let cellHeight: CGFloat = 400.0
}

class HCPlaySynopsisCell: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailTopView: UIView!
    @IBOutlet weak var detailBottomView: UIView!
    @IBOutlet weak var detailBottomLab: UILabel!
    @IBOutlet weak var detailBottomImg: UIImageView!
    
    // MARK:- 成功回调
    typealias AddBlock = ()->Void
    var updatelUI: AddBlock? = {
        () in return
    }
    
    private var isMore: Variable<Bool> = Variable(false)        // 查看全文
    private var isOpen: Bool = false                            // 展开状态
    var playModel: Variable<HCPlayModel?> = Variable(nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
        
        // 本地测试
        guard let path = Bundle.main.path(forResource: "play_synopsis", ofType:"html") else { return }
        let urlStr = URL(fileURLWithPath: path)
        HCLog(urlStr)
        self.webView.loadRequest(URLRequest(url: urlStr))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK:- 初始化
extension HCPlaySynopsisCell {
    
    func initUI() {
        
        // 设置样式
        self.clipsToBounds = true
        
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.bounces = false
        
        // 背景透明
        self.detailTopView.alpha = 0.6
        // 初始化
        self.titleLab.text = "声音简介"
    }
    
    private func bindUI() {
        
        // 添加事件
        detailBottomView.rx.tapGesture().when(.recognized).subscribe({ [weak self] _ in
            guard let `self` = self else { return }
            
            self.isOpen = !self.isOpen
            
            if self.isOpen {
                // 重置高度
                let newHeight = self.bottomView.top + self.webView.scrollView.contentSize.height
                self.updateUI(newHeight: newHeight)
                
            } else {
                // 重置高度
                let newHeight = Metric.cellHeight
                self.updateUI(newHeight: newHeight)
            }
        }).disposed(by: rx.disposeBag)

        isMore.asObservable().subscribe(onNext: { [weak self] beel in
            
            guard let `self` = self else { return }
            self.detailView.isHidden = !beel
            
        }).disposed(by: rx.disposeBag)

//        playModel.asObservable().subscribe(onNext: { [weak self] model in
//
//            guard let `self` = self else { return }
//            if let shortRichIntro = model?.trackInfo?.shortRichIntro {
//                HCLog(shortRichIntro)
//                self.webView.loadHTMLString(shortRichIntro, baseURL: nil)
//                let newHeight = self.bottomView.top + self.webView.scrollView.contentSize.height
//                self.updateUI(newHeight: newHeight)
//            }
//        }).disposed(by: rx.disposeBag)
    }

    // MARK:- 更新UI
    private func updateUI(newHeight: CGFloat) {
        
        // 误差大于1，重新设置高度
        if fabs(self.height - newHeight) > 1.0 {
            // 重置高度
            self.webViewHeightCons.constant = self.webView.scrollView.contentSize.height
            self.height = newHeight
            // 通知更新
            self.updatelUI?()
        }
        
        // 展开状态
        if self.isOpen {
            self.detailTopView.isHidden = true
            self.detailBottomLab.text = "收起"
            self.detailBottomImg.image = UIImage(named: "cell_arrow_all_up")
        } else {
            self.detailTopView.isHidden = false
            self.detailBottomLab.text = "查看全文"
            self.detailBottomImg.image = UIImage(named: "cell_arrow_all")
        }
    }

    func cellHeight() -> CGFloat {
        
        if isOpen {
            return self.height
        }
        
        if self.height < Metric.cellHeight {
            self.isMore.value = false
            return self.height
        }
        self.isMore.value = true
        return Metric.cellHeight
    }
    
    static func cellHeight() -> CGFloat {
        return Metric.cellHeight
    }
}

// MARK:- 代理
extension HCPlaySynopsisCell: UIWebViewDelegate {

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 重置高度
        let newHeight = self.bottomView.top + self.webView.scrollView.contentSize.height
        self.updateUI(newHeight: newHeight)
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
}
