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
    
    static let imageHeight: CGFloat = 260.0
    static let scrollDownLimit: CGFloat = 400
}

class HCMineViewController: HCBaseViewController {
    
    // viewModel
    private var viewModel = HCMineViewModel()
    private var vmOutput: HCMineViewModel.HCMineOutput?
    
    // View
    private var titleView: UIView?
    private var tableView: UITableView!
    private lazy var imageView = UIImageView().then {
        $0.backgroundColor = kThemeWhiteColor
        $0.image = UIImage(named: "favicon")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    // DataSuorce
    var dataSource : RxTableViewSectionedReloadDataSource<HCMineSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initTitleView()
        initUI()
        bindUI()
    }
    
    deinit {
        tableView.delegate = nil
        HCLog("deinit: \(type(of: self))")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        titleView?.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-0.5) // 修正偏差
            make.left.equalToSuperview().offset(Metric.searchBarLeft)
            make.right.equalToSuperview().offset(-Metric.searchBarRight)
        }
    }
}

// MARK:- 初始化部分
extension HCMineViewController: HCNavTitleable {
    
    // MARK:- 标题组件
    private func initTitleView() {
        
        let mineNavigationBar = HCMineNavigationBar()
        mineNavigationBar.itemClicked = { (model) in }
        titleView = self.titleView(titleView: mineNavigationBar)
    }

    // MARK:- 初始化视图
    private func initUI() {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = kThemeGainsboroColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsetsMake(Metric.imageHeight, 0, 0, 0)
        
        // 添加顶部图片
        imageView.frame = CGRect(x: 0, y: -Metric.imageHeight, width: kScreenW, height: Metric.imageHeight)
        tableView.addSubview(imageView)

        view.addSubview(tableView)
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
        
        dataSource = RxTableViewSectionedReloadDataSource(configureCell: { (ds, tv, indexPath, item) -> HCSettingCell in
            let cell = tv.dequeue(Reusable.settingCell, for: indexPath)
            cell.model = item
            return cell
        })
        
        vmOutput = viewModel.transform(input: HCMineViewModel.HCMineInput())
        
        vmOutput?.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
}

// MARK:- UITableViewDelegate
extension HCMineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metric.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Metric.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK:- UIScrollView
extension HCMineViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        // 限制下拉距离
        if offsetY < -Metric.scrollDownLimit {
            scrollView.contentOffset = CGPoint.init(x: 0, y: -Metric.scrollDownLimit)
        }

        // 改变图片框的大小 (上滑的时候不改变)
        let newOffsetY = scrollView.contentOffset.y
        if (newOffsetY < -Metric.imageHeight) {
            imageView.frame = CGRect(x: 0, y: newOffsetY, width: kScreenW, height: -newOffsetY)
        }
        
        // SectionHeader 跟随父视图移动 (实际效果并没有一起移动，后面再解决)
        let offset = scrollView.contentOffset.y + Metric.imageHeight
        if offset <= Metric.sectionHeight && offset >= 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        } else if offset >= Metric.sectionHeight {
            scrollView.contentInset = UIEdgeInsetsMake(-Metric.sectionHeight + Metric.imageHeight, 0, 0, 0);
        }
    }
}

