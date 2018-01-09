//
//  UINavigationBar+ChangeColor.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/9.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

// MARK:- 方法一
extension UINavigationBar {
    
    // MARK:- RunTime
    private struct NavigationBarKeys {
        static var overlayKey = "overlayKey"
    }
    
    var overlay: UIView? {
        get {
            return objc_getAssociatedObject(self, &NavigationBarKeys.overlayKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &NavigationBarKeys.overlayKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    // MARK:- 接口
    func Mg_setBackgroundColor(backgroundColor: UIColor) {
        if overlay == nil {
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            overlay = UIView.init(frame: CGRect.init(x: 0, y: 0, width: bounds.width, height: bounds.height+20))
            overlay?.isUserInteractionEnabled = false
            overlay?.autoresizingMask = UIViewAutoresizing.flexibleWidth
        }
        overlay?.backgroundColor = backgroundColor
        subviews.first?.insertSubview(overlay!, at: 0)
    }
    
    
    func Mg_setTranslationY(translationY: CGFloat) {
        transform = CGAffineTransform.init(translationX: 0, y: translationY)
    }
    
    func Mg_setElementsAlpha(alpha: CGFloat) {
        for (_, element) in subviews.enumerated() {
            if element.isKind(of: NSClassFromString("UINavigationItemView") as! UIView.Type) ||
                element.isKind(of: NSClassFromString("UINavigationButton") as! UIButton.Type) ||
                element.isKind(of: NSClassFromString("UINavBarPrompt") as! UIView.Type)
            {
                element.alpha = alpha
            }
            
            if element.isKind(of: NSClassFromString("_UINavigationBarBackIndicatorView") as! UIView.Type) {
                element.alpha = element.alpha == 0 ? 0 : alpha
            }
        }
        
        items?.forEach({ (item) in
            if let titleView = item.titleView {
                titleView.alpha = alpha
            }
            for BBItems in [item.leftBarButtonItems, item.rightBarButtonItems] {
                BBItems?.forEach({ (barButtonItem) in
                    if let customView = barButtonItem.customView {
                        customView.alpha = alpha
                    }
                })
            }
        })
    }
    
    /// viewWillDisAppear调用
    func Mg_reset() {
        setBackgroundImage(nil, for: UIBarMetrics.default)
        overlay?.removeFromSuperview()
        overlay = nil
    }
}

// MARK:- 方法二
extension UINavigationBar {
    
    // MARK:- 接口
    /**
     *  隐藏导航栏下的横线，背景色置空 viewWillAppear调用
     */
    func star() {
        let shadowImg: UIImageView? = self.findNavLineImageViewOn(view: self)
        shadowImg?.isHidden = true
        self.backgroundColor = nil
    }
    
    /**
     在func scrollViewDidScroll(_ scrollView: UIScrollView)调用
     @param color 最终显示颜色
     @param scrollView 当前滑动视图
     @param value 滑动临界值，依据需求设置
     */
    func change(_ color: UIColor, with scrollView: UIScrollView, andValue value: CGFloat) {
        if scrollView.contentOffset.y < -value{
            // 下拉时导航栏隐藏，无所谓，可以忽略
            self.isHidden = true
        } else {
            self.isHidden = false
            // 计算透明度
            let alpha: CGFloat = scrollView.contentOffset.y / value > 1.0 ? 1 : scrollView.contentOffset.y / value
            //设置一个颜色并转化为图片
            let image: UIImage? = imageFromColor(color: color.withAlphaComponent(alpha))
            self.setBackgroundImage(image, for: .default)
        }
    }
    
    /**
     *  还原导航栏  viewWillDisAppear调用
     */
    func reset() {
        let shadowImg = findNavLineImageViewOn(view: self)
        shadowImg?.isHidden = false
        self.setBackgroundImage(nil,for: .default)
    }
    
    // MARK:- 其他内部方法
    //寻找导航栏下的横线  （递归查询导航栏下边那条分割线）
    fileprivate func findNavLineImageViewOn(view: UIView) -> UIImageView? {
        if (view.isKind(of: UIImageView.classForCoder())  && view.bounds.size.height <= 1.0) {
            return view as? UIImageView
        }
        for subView in view.subviews {
            let imageView = findNavLineImageViewOn(view: subView)
            if imageView != nil {
                return imageView
            }
        }
        return nil
    }
    
    // 通过"UIColor"返回一张“UIImage”
    fileprivate func imageFromColor(color: UIColor) -> UIImage {
        //创建1像素区域并开始图片绘图
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        //创建画板并填充颜色和区域
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        //从画板上获取图片并关闭图片绘图
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
