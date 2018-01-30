//
//  HCMineHeaderView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/8.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

class HCMineHeaderView: UIView, NibLoadable {

    @IBOutlet weak var loginLab: UILabel!
    @IBOutlet weak var loginImg: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.backgroundColor = kThemeGainsboroColor
    }
}
