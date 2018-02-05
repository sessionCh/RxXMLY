//
//  HCPlayViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/23.
//  Copyright © 2018年 sessionCh. All rights reserved.
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
    
    static let playAlbumCell = ReusableCell<HCPlayAlbumCell>(nibName: "HCPlayAlbumCell")
    static let playSynopsisCell = ReusableCell<HCPlaySynopsisCell>(nibName: "HCPlaySynopsisCell")
}

// MARK:- 常量
fileprivate struct Metric {
    
    static let sectionHeight: CGFloat = 10.0
    
    static let changeColorPoint: CGFloat = 100.0 // 调整顶部背景图片位置
}

class HCPlayViewController: HCBaseViewController {

    // viewModel
    private var viewModel = HCPlayViewModel()
    private var vmOutput: HCPlayViewModel.HCPlayOutput?
    
    // View
    private var tableView: UITableView!
    private var playSynopsisCell: HCPlaySynopsisCell?
    private var titleView: HCPlayTitleView?

    // DataSuorce
    var dataSource : RxTableViewSectionedReloadDataSource<HCPlaySection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initEnableMudule()
        initUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.scrollViewDidScroll(tableView)

        if let tabbarVC = self.tabBarController as? HCMainViewController {
            tabbarVC.isHiddenPlayView(false)
        }
        
        if let navigationBar = self.navigationController?.navigationBar {
            view.insertSubview(navigationBar, aboveSubview: tableView)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        tableView.delegate = nil
        HCLog("deinit: \(type(of: self))")
    }
}

// MARK:- 初始化协议
extension HCPlayViewController: HCNavBackable, HCNavUniversalable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 登录页面 返回、注册
        let models = [HCNavigationBarItemMetric.downBack,
                      HCNavigationBarItemMetric.share,
                      HCNavigationBarItemMetric.more]
        self.universals(modelArr: models) { [weak self] (model) in
            guard let `self` = self else { return }
            HCLog(model.description)
            let type = model.type
            switch type {
            case .back:
                self.navigationController?.dismiss(animated: true, completion: nil)
                break
            default: break
            }
        }
        
        // 设置 样式
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: kThemeTomatoColor], for: .normal)
    }
}

// MARK:- 初始化部分
extension HCPlayViewController {
        
    // MARK:- 初始化视图
    private func initUI() {
        
        // TitleView
        let titleView = HCPlayTitleView.loadFromNib()
        titleView.isHidden = true
        self.titleView = titleView
        self.navigationController?.navigationBar.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        // TableView
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = kThemeGainsboroColor
        tableView.separatorStyle = .none
        
        let headerView = HCPlayHeaderView.loadFromNib()
        headerView.frame = CGRect(x: 0, y: kNavibarH, width: headerView.width, height: headerView.height)
        let tableHeaderView = UIView()
        tableHeaderView.backgroundColor = kThemeWhiteColor
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: headerView.width, height: headerView.height + kNavibarH)
        tableHeaderView.addSubview(headerView)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60.0))
        // 调整视图范围
        tableView.contentInset = UIEdgeInsetsMake(-kNavibarH, 0, 0, 0)
        // 调整滚动条范围
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(-kNavibarH, 0, 0, 0)

        view.addSubview(tableView)
        self.tableView = tableView
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        // 注册cell
        tableView.register(Reusable.playAlbumCell)
        tableView.register(Reusable.playSynopsisCell)
    }
    
    // MARK:- 绑定视图
    func bindUI() {
        
        dataSource = RxTableViewSectionedReloadDataSource(configureCell: { [weak self] (ds, tv, indexPath, item) -> UITableViewCell in
            
            guard let `self` = self else { return UITableViewCell.init() }
            
            let dsSection = ds[indexPath.section]

            if indexPath.row == 0 {
                // 充当 SectionHeader 占位
                let placeCell = UITableViewCell()
                placeCell.selectionStyle = .none
                placeCell.backgroundColor = kThemeGainsboroColor
                return placeCell
            } else if indexPath.row == 1 {
                
                let cell = tv.dequeue(Reusable.playAlbumCell, for: indexPath)
                cell.selectionStyle = .none
                cell.playModel.value = dsSection.playModel
                return cell
            } else if indexPath.row == 2 && indexPath.section == 0 {
                
                let cell = tv.dequeue(Reusable.playSynopsisCell, for: indexPath)
                cell.selectionStyle = .none
                // 更新UI
                cell.updatelUI = { [weak self] in
                    guard let `self` = self else { return }
                    self.tableView.reloadData()
                }
                cell.playModel.value = dsSection.playModel
                self.playSynopsisCell = cell
                return cell
            }
            // 待完善...
            else {
               
                let cell = tv.dequeue(Reusable.playAlbumCell, for: indexPath)
                cell.selectionStyle = .none
                cell.playModel.value = dsSection.playModel
                return cell
            }
            
            return UITableViewCell.init()
        })
        
        vmOutput = viewModel.transform(input: HCPlayViewModel.HCPlayInput())
        vmOutput?.requestCommand.onNext(true)
        vmOutput?.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
}

// MARK:- UITableViewDelegate
extension HCPlayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 充当 SectionHeader 数据模型
        if indexPath.row == 0 {
            return Metric.sectionHeight
        } else if indexPath.row == 1 {
            return HCPlayAlbumCell.cellHeight()
        } else if indexPath.row == 2 && indexPath.section == 0 {
            if let cellHeight = playSynopsisCell?.cellHeight() {
                return cellHeight
            }
            return HCPlaySynopsisCell.cellHeight()
        }
        return HCPlayAlbumCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 充当 SectionHeader 数据模型
        if indexPath.row == 0 { return }
    }
}

// MARK:- UIScrollView
extension HCPlayViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 调整导航栏背景色渐变
        let offsetY: CGFloat = scrollView.contentOffset.y
        HCLog(" offsetY:\(offsetY)")
        
        if offsetY > Metric.changeColorPoint {
            
            let alpha: CGFloat = min(1, (offsetY - Metric.changeColorPoint) / Metric.changeColorPoint)
            HCLog(" alpha:\(alpha)")
            
            // 不透明才显示标题栏
            if alpha >= 1 {
                self.titleView?.isHidden = false
            } else {
                self.titleView?.isHidden = true
            }
            
            // 改变导航栏背景色
            let changeColor = kThemeWhiteColor.withAlphaComponent(alpha)
            
            self.navigationController?.navigationBar.backgroundColor = changeColor
            self.navigationController?.navigationBar.barTintColor = changeColor
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.Mg_setBackgroundColor(backgroundColor: changeColor)

        } else {
            self.navigationController?.navigationBar.Mg_setBackgroundColor(backgroundColor: kThemeWhiteColor.withAlphaComponent(0))
        }
    }
}

// MARK:- 控制器跳转
extension HCPlayViewController {
    
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

