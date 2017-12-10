//
//  Extension.swift
//  Parallax
//
//  Created by Yogendra Shelke on 09/12/17.
//  Copyright © 2017 Yogendra Shelke. All rights reserved.
//

import UIKit

extension UITabBar {
	open override func sizeThatFits(_ size: CGSize) -> CGSize {
		return CGSize(width: size.width, height: 100)
	}
}

extension UIView {
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		layer.mask = mask
	}
}

extension UIImageView {
	func darkEdges() {
		let maskLayer = CAGradientLayer()
		maskLayer.frame = bounds
		maskLayer.shadowRadius = 50
		maskLayer.shadowPath = CGPath(roundedRect: bounds.insetBy(dx: 2, dy: 2), cornerWidth: 10, cornerHeight: 10, transform: nil)
		maskLayer.shadowOpacity = 0.75
		maskLayer.shadowOffset = .zero
		maskLayer.shadowColor = UIColor.black.cgColor
		layer.mask = maskLayer
	}
}
