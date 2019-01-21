//
//  DetailCharacterHeaderView.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit
import Kingfisher

class DetailCharacterHeaderView: UIView {

    @IBOutlet private weak var imageView: UIImageView!

    var imageUrl: URL? {
        didSet {
            if let imageUrl = imageUrl {
                imageView.kf.setImage(with: imageUrl)
            }
        }
    }
}
