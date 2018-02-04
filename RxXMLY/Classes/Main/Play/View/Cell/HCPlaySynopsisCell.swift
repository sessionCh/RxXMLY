//
//  HCPlaySynopsisCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/4.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  声音简介

import UIKit
import ReusableKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let cellHeight: CGFloat = 10000.0
}

class HCPlaySynopsisCell: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webViewHeightCons: NSLayoutConstraint!
    
    // MARK:- 成功回调
    typealias AddBlock = ()->Void
    var updatelUI: AddBlock? = {
        () in return
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
}

// MARK:- 初始化
extension HCPlaySynopsisCell {
    
    func initUI() {
        
        // 设置样式
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.bounces = false
        
        // 初始化
        self.titleLab.text = "声音简介"
        guard let path = Bundle.main.path(forResource: "play_synopsis", ofType:"html") else { return }
        let urlStr = URL(fileURLWithPath: path)
        HCLog(urlStr)
        self.webView.loadRequest(URLRequest(url: urlStr))
    }
    
    func cellHeight() -> CGFloat {
        
        if self.height < Metric.cellHeight {
            return self.height
        }
        return Metric.cellHeight
    }
    
    static func cellHeight() -> CGFloat {
        return Metric.cellHeight
    }
}

// MARK:- 代理
extension HCPlaySynopsisCell: UIWebViewDelegate {

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if navigationType == .other, let url = request.url {
            let beel = url.scheme?.hasPrefix("ready") ?? false
            if beel {
                let contentHeight = CGFloat(Float(url.host ?? "0")!)
                // 重置高度
                self.webViewHeightCons.constant = contentHeight
                self.height = self.bottomView.top + self.webViewHeightCons.constant
                // 通知更新
                self.updatelUI?()
            }
        }
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
}
