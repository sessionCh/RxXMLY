//
//  HCMineViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import ReusableKit
import Then
import RxGesture

// MARK:- 复用
private enum Reusable {
    
    static let settingCell = ReusableCell<HCSettingCell>()
}

// MARK:- 常量
fileprivate struct Metric {
    
    static let searchBarLeft: CGFloat = 12.0
    static let searchBarRight: CGFloat = 12.0
    
    static let cellHeight: CGFloat = 49.0
    static let sectionHeight: CGFloat = 10.0
    
    static let marginTop: CGFloat = 90.0 // 调整顶部背景图片位置
    static let navbarColorChangePoint: CGFloat = -Metric.marginTop / 2 // 调整导航栏渐变开始位置
}

class HCMineViewController: HCBaseViewController {
    
    // viewModel
    private var viewModel = HCSettingViewModel()
    private var vmOutput: HCSettingViewModel.HCSettingOutput?
    
    // View
    private var titleView: UIView?
    private var tableView: UITableView!
    private lazy var imageView = UIImageView().then {
        $0.backgroundColor = kThemeWhiteColor
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "favicon")
    }
    
    // DataSuorce
    var dataSource : RxTableViewSectionedReloadDataSource<HCSettingSection>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.scrollViewDidScroll(tableView)
        
        if let tabbarVC = self.tabBarController as? HCMainViewController {
            tabbarVC.isHiddenPlayView(false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 修正 Push 后导航栏灰色
        self.navigationController?.navigationBar.backgroundColor = kThemeWhiteColor
        self.navigationController?.navigationBar.barTintColor = kThemeWhiteColor
        // 移除
        self.navigationController?.navigationBar.Mg_reset()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        initTitleView()
        initUI()
        bindUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        titleView?.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-0.5) // 修正偏差
            make.left.equalToSuperview().offset(Metric.searchBarLeft)
            make.right.equalToSuperview()
        }
    }
}

// MARK:- 初始化协议部分
extension HCMineViewController: HCNavTitleable {
    
    // MARK:- 标题组件
    private func initTitleView() {
        
        let mineNavigationBar = HCMineNavigationBar()
        mineNavigationBar.itemClicked = { [weak self] (model) in
            guard let `self` = self else { return }
            self.jump2Login()
        }
        titleView = self.titleView(titleView: mineNavigationBar)
    }
}

// MARK:- 初始化部分
extension HCMineViewController {
    
    // MARK:- 初始化视图
    private func initUI() {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        let headerView = HCMineHeaderView.loadFromNib()
        // 点击登录
        headerView.loginLab.rx.tapGesture().when(.recognized)
            .subscribe({ [weak self] _ in
                guard let `self` = self else { return }
                self.jump2Login()
            }).disposed(by: rx.disposeBag)
        headerView.loginImg.rx.tapGesture().when(.recognized)
            .subscribe({ [weak self] _ in
                guard let `self` = self else { return }
                self.jump2Login()
            }).disposed(by: rx.disposeBag)
        
        let tableHeaderView = UIView(frame: headerView.bounds)
        tableHeaderView.addSubview(headerView)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60.0))
        // 调整视图范围
        tableView.contentInset = UIEdgeInsetsMake(Metric.marginTop, 0, 0, 0)
        // 调整滚动条范围
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(-kNavibarH, 0, 0, 0)
        
        // 设置背景图片
        if let imageSize = imageView.image?.size {
            // 以屏幕宽度为基准，等比获得图片高度
            let imageRealHeight = imageSize.height * kScreenW / imageSize.width
            let imageTopMargin = (Metric.marginTop + kNavibarH + tableHeaderView.height - imageRealHeight) / 2
            // 证图片居中
            imageView.frame = CGRect(x: 0, y: imageTopMargin, width: kScreenW, height: imageRealHeight)
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: Metric.marginTop + kNavibarH + tableHeaderView.height)
        }
        
        view.addSubview(tableView)
        view.addSubview(imageView)
        view.insertSubview(tableView, aboveSubview: imageView)
        self.tableView = tableView
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        // 注册cell
        tableView.register(Reusable.settingCell)
    }
    
    // MARK:- 绑定视图
    func bindUI() {
        
        dataSource = RxTableViewSectionedReloadDataSource(configureCell: { (ds, tv, indexPath, item) -> UITableViewCell in
            if indexPath.row == 0 {
                // 充当 SectionHeader 占位
                let placeCell = UITableViewCell()
                placeCell.backgroundColor = kThemeGainsboroColor
                return placeCell
            }
            let cell = tv.dequeue(Reusable.settingCell, for: indexPath)
            cell.model = item
            return cell
        })
        
        vmOutput = viewModel.transform(input: HCSettingViewModel.HCSettingInput(type: .mine))
        
        vmOutput?.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
}

// MARK:- UITableViewDelegate
extension HCMineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 充当 SectionHeader 数据模型
        if indexPath.row == 0 {
            return Metric.sectionHeight
        }
        return Metric.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 充当 SectionHeader 数据模型
        if indexPath.row == 0 { return }

        if indexPath.section == 3 && indexPath.row == 2 {
            self.jump2Setting()
        } else {
            self.jump2Setting()
        }
    }
}

private let tempScale: CGFloat = 104 / 600

// MARK:- UIScrollView
extension HCMineViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 调整导航栏背景色渐变
        let offsetY: CGFloat = scrollView.contentOffset.y
        HCLog(" offsetY:\(offsetY)")
        if offsetY < Metric.navbarColorChangePoint {
            let alpha: CGFloat = max(0, 1 - (Metric.navbarColorChangePoint - offsetY) / kNavibarH)
            HCLog(" alpha:\(alpha)")
            self.navigationController?.navigationBar.Mg_setBackgroundColor(backgroundColor: kThemeWhiteColor.withAlphaComponent(alpha))
        } else {
            self.navigationController?.navigationBar.Mg_setBackgroundColor(backgroundColor: kThemeWhiteColor.withAlphaComponent(1))
        }
        
        // 缩放图片
        if (offsetY < 0) {
            // 减去初始部分
            let scaleXY = 1  - tempScale + offsetY / (-600)
            imageView.transform = CGAffineTransform(scaleX: scaleXY, y: scaleXY)
        }
    }
}

// MARK:- 控制器跳转
extension HCMineViewController {
    
    // MARK:- 登录
    func jump2Login() {
        
        let VC = HCBaseNavigationController(rootViewController: HCLoginViewController())
        self.present(VC, animated: true, completion: nil)
    }
    
    // MARK:- 设置
    func jump2Setting() {
        
        let VC = HCSettingViewController()
        VC.hidesBottomBarWhenPushed = true
        if let tabbarVC = self.tabBarController as? HCMainViewController {
            tabbarVC.isHiddenPlayView(true)
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
