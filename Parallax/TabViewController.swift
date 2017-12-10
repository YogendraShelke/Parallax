//
//  TabViewController.swift
//  Parallax
//
//  Created by Yogendra Shelke on 09/12/17.
//  Copyright © 2017 Yogendra Shelke. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
	
	var centerButton: UIButton {
		let button = UIButton(type: .custom)
		button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
		button.setImage(#imageLiteral(resourceName: "ic_add_circle_white_48pt").withRenderingMode(.alwaysTemplate), for: .normal)
		button.setImage(#imageLiteral(resourceName: "ic_add_circle_white_48pt").withRenderingMode(.alwaysTemplate), for: .highlighted)
		button.center = tabBar.center
		button.center.y = tabBar.center.y
		var top: CGFloat = 0
		if let window = UIApplication.shared.delegate?.window as? UIWindow {
			top = window.safeAreaInsets.top
			if (top > 0) {
				button.center.y = tabBar.center.y - 16
			}
		}
		button.tintColor = .red
		button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
		button.layer.shadowOffset = CGSize(width: 0, height: 2)
		button.layer.shadowOpacity = 1.0
		button.layer.shadowRadius = 3.0
		button.layer.masksToBounds = false
		button.addTarget(self, action: #selector(TabBarController.centerButtonClicked(button:)), for: .touchUpInside)
		return button
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		tabBar.barTintColor = .white
		tabBar.tintColor = .red
		tabBar.roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
		tabBar.clipsToBounds = true
		view.addSubview(centerButton)
    }
	
	@objc func centerButtonClicked(button: UIButton) {
		selectedIndex = 2
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
	}
}
