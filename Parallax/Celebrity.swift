//
//  Celebrity.swift
//  Parallax
//
//  Created by Yogendra Shelke on 10/12/17.
//  Copyright © 2017 Yogendra Shelke. All rights reserved.
//

import UIKit

class Celebrity {
	var name: String = String()
	var address: String = String()
	var details: String = String()
	var photos: [UIImage] = []
	var poster: UIImage = UIImage()
	var followers: String = String()
	var following: String = String()
	var posts: String = String()
	init(name: String, address: String, details: String, poster: UIImage, photos: [UIImage], followers: String, following: String, posts: String) {
		self.name = name
		self.poster = poster
		self.address = address
		self.photos = photos
		self.details = details
		self.followers = followers
		self.following = following
		self.posts = posts
	}
}
