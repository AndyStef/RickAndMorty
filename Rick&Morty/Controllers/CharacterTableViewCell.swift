//
//  CharacterTableViewCell.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet private weak var characterLabel: UILabel!

    func configure(with character: Character) {
        characterLabel.text = character.name
    }
}
