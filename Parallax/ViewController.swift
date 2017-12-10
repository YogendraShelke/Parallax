//
//  ViewController.swift
//  Parallax
//
//  Created by Yogendra Shelke on 09/12/17.
//  Copyright © 2017 Yogendra Shelke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var infoView: UIView!
	@IBOutlet weak var infoContainer: UIView!
	@IBOutlet weak var photosScrollView: UIScrollView!
	@IBOutlet weak var followersLabel: UILabel!
	@IBOutlet weak var followersCount: UILabel!
	@IBOutlet weak var followingsLabel: UILabel!
	@IBOutlet weak var followingsCount: UILabel!
	@IBOutlet weak var postsLabel: UILabel!
	@IBOutlet weak var postsCount: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var details: UILabel!
	@IBOutlet weak var followButton: UIButton!
	@IBOutlet weak var infoHeaderBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var infoDetailsTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var followButtonWidthConstraint: NSLayoutConstraint!
	@IBOutlet weak var detailsViewHeightConstraint: NSLayoutConstraint!

	var celebrities: [Celebrity] = []
	
	var celebrity: Celebrity? = nil {
		didSet {
			guard let celebrity = celebrity else { return }
			nameLabel.text = celebrity.name
			cityLabel.text = celebrity.address
			followersCount.text = celebrity.followers
			followingsCount.text = celebrity.following
			postsCount.text = celebrity.posts
			details.text = celebrity.details
			photosScrollView.subviews.forEach({ $0.removeFromSuperview() })
			let width = (thumbnailWidth + thumbnailOffset) * CGFloat(celebrity.photos.count) + thumbnailOffset
			photosScrollView.contentSize = CGSize(width: width, height: thumbnailWidth)
			for(index, photo) in (celebrity.photos.enumerated()) {
				let x = CGFloat(index) * (thumbnailWidth + thumbnailOffset) + thumbnailOffset
				let imageView = UIImageView(frame:CGRect(x: x, y: 0, width: thumbnailWidth, height: thumbnailWidth))
				imageView.image = photo
				imageView.layer.cornerRadius = 10
				imageView.clipsToBounds = true
				photosScrollView.addSubview(imageView)
			}
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		configureInfoView()
		configureFollowButton()
		prepareData()
    }
	
	func configureInfoView() {
		view.setNeedsLayout()
		view.layoutIfNeeded()
		detailsViewHeightConstraint.constant = 0
		infoView.roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
		infoView.clipsToBounds = true
	}
	
	func configureFollowButton() {
		followButton.layer.borderColor = UIColor.red.cgColor
		followButton.layer.cornerRadius = followButton.frame.height/2
		followButton.layer.borderWidth = 2
	}
	
	func prepareData() {
		celebrities.append(Celebrity(name: "Margot Robbie", address: "Australia, Dalby", details: "Australian actress and producer.", poster: #imageLiteral(resourceName: "margot_robbie"), photos: [#imageLiteral(resourceName: "mr1"),#imageLiteral(resourceName: "mr2"),#imageLiteral(resourceName: "mr3"),#imageLiteral(resourceName: "mr4"),#imageLiteral(resourceName: "mr5")], followers: "16M", following: "245", posts: "589"))
		celebrities.append(Celebrity(name: "Beyoncé", address: "United States, Texas", details: "American singer, songwriter, dancer, and actress.", poster: #imageLiteral(resourceName: "beyonce_knowles"), photos: [#imageLiteral(resourceName: "bk1"),#imageLiteral(resourceName: "bk2"),#imageLiteral(resourceName: "bk3"),#imageLiteral(resourceName: "bk4")], followers: "37M", following: "475", posts: "1899"))
		celebrities.append(Celebrity(name: "Angelina Jolie", address: "United States, Los Angeles", details: "American actress, filmmaker, and humanitarian.", poster: #imageLiteral(resourceName: "angelina_jolie"), photos: [#imageLiteral(resourceName: "aj1"),#imageLiteral(resourceName: "aj2"),#imageLiteral(resourceName: "aj3"),#imageLiteral(resourceName: "aj4"),#imageLiteral(resourceName: "aj5"),#imageLiteral(resourceName: "aj6"),#imageLiteral(resourceName: "aj7")], followers: "46M", following: "219", posts: "1300"))
		collectionView.reloadData()
	}
	
	@IBAction func showDetails(_ sender: Any) {
		detailsViewHeightConstraint.constant = detailsViewHeight
		collectionView.isScrollEnabled = false
		UIView.animate(withDuration: 0.5, delay:0, options: [.curveEaseInOut], animations: {
			self.view.layoutIfNeeded()
		})
	}
	
	@IBAction func hideDetails(_ sender: Any) {
		detailsViewHeightConstraint.constant = 0
		collectionView.isScrollEnabled = true
		UIView.animate(withDuration: 0.5, delay:0, options: [.curveEaseInOut], animations: {
			self.view.layoutIfNeeded()
		})
	}
	
	@IBAction func follow(_ sender: Any) {
		
		if (followButtonWidthConstraint.constant == followButtonWithTitleWidth) {
			followButton.backgroundColor = .red
			followButtonWidthConstraint.constant = followButtonWithoutTitleWidth
			followButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
			followButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -8)
			followButton.setTitleColor(.clear, for: .normal)
			UIView.animate(withDuration: 0.5, delay:0, options: [.curveEaseInOut], animations: {
				self.view.layoutIfNeeded()
			}){ completed in
				self.followButton.setImage(#imageLiteral(resourceName: "ic_person_outline_white"), for: .normal)
			}
		} else {
			followButton.backgroundColor = .white
			followButtonWidthConstraint.constant = followButtonWithTitleWidth
			followButton.setImage(nil, for: .normal)
			followButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
			followButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
			UIView.animate(withDuration: 0.5, delay:0, options: [.curveEaseInOut], animations: {
				self.view.layoutIfNeeded()
			}) { completed in
				self.followButton.setTitleColor(.red, for: .normal)
			}
		}
	}
}

extension ViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return celebrities.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterImageCell", for: indexPath) as! PosterImageCell
		celebrity = celebrities[indexPath.item]
		cell.posterImage.image = celebrity?.poster
		cell.posterImage.darkEdges()
		return cell
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: collectionView.frame.height)
	}
}


extension ViewController: UIScrollViewDelegate {
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		infoHeaderBottomConstraint.constant -= fadeDelta
		infoDetailsTopConstraint.constant += fadeDelta
		UIView.animate(withDuration: 0.5, delay: 0, options: [.transitionCrossDissolve], animations: {
			animate(alpha: 0)
		}){ (completed) in
			self.infoHeaderBottomConstraint.constant += fadeDelta
			self.infoDetailsTopConstraint.constant -= fadeDelta
			UIView.animate(withDuration: 0.3) {
				animate(alpha: 1)
			}
		}
		func animate(alpha: CGFloat) {
			self.followersCount.alpha = alpha
			self.followersLabel.alpha = alpha
			self.followingsCount.alpha = alpha
			self.followingsLabel.alpha = alpha
			self.postsCount.alpha = alpha
			self.postsLabel.alpha = alpha
			self.cityLabel.alpha = alpha
			self.nameLabel.alpha = alpha
			self.followButton.alpha = alpha
			self.view.layoutIfNeeded()
		}
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let x = scrollView.contentOffset.x
		let w = scrollView.bounds.size.width
		let index = Int(ceil(x/w))
		celebrity = celebrities[index]
	}
}
