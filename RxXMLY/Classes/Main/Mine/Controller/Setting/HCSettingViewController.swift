//
//  HCSettingViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/10.
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
    
    static let settingCell = ReusableCell<HCSettingCell>()
}

// MARK:- 常量
fileprivate struct Metric {

    static let sectionHeight: CGFloat = 10.0
}

class HCSettingViewController: HCBaseViewController {

    // viewModel
    private var viewModel = HCSettingViewModel()
    private var vmOutput: HCSettingViewModel.HCSettingOutput?
    
    // View
    private var tableView: UITableView!
    
    // DataSuorce
    var dataSource : RxTableViewSectionedReloadDataSource<HCSettingSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 修正 Push 后导航栏灰色
        self.navigationController?.navigationBar.backgroundColor = kThemeWhiteColor
        self.navigationController?.navigationBar.barTintColor = kThemeWhiteColor

        initEnableMudule()
        initUI()
        bindUI()
    }
}

// MARK:- 初始化协议
extension HCSettingViewController: HCNavBackable, HCNavUniversalable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 登录页面 返回、注册
        let models = [HCNavigationBarItemMetric.back]
        self.universals(modelArr: models) { [weak self] (model) in
            guard let `self` = self else { return }
            HCLog(model.description)
            let type = model.type
            switch type {
            case .back:
                self.navigationController?.popViewController(animated: true)
                break
            default: break
            }
        }
    }
}

extension HCSettingViewController {
    
    // MARK:- 初始化视图
    private func initUI() {
        
        self.title = "设置"
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = kThemeGainsboroColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60.0))
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
        
        vmOutput = viewModel.transform(input: HCSettingViewModel.HCSettingInput(type: .setting))
        
        vmOutput?.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
}

// MARK:- UITableViewDelegate
extension HCSettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 充当 SectionHeader 数据模型
        if indexPath.row == 0 {
            return Metric.sectionHeight
        }
        return HCSettingCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 充当 SectionHeader 数据模型
        if indexPath.row == 0 { return }
    }
}

// MARK:- 控制器跳转
extension HCSettingViewController {
    
    // MARK:- 登录
    func jump2Login() {
        
        let VC = HCBaseNavigationController(rootViewController: HCLoginViewController())
        self.present(VC, animated: true, completion: nil)
    }
}

