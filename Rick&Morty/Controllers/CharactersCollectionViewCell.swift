//
//  CharactersCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit
import Kingfisher

class CharactersCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var characterLabel: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!

    func configure(with character: Character) {
        characterLabel.text = character.name
        if let imageUrl = character.imageUrl {
            characterImageView.kf.setImage(with: imageUrl)
        }
    }
}
