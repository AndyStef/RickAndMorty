//
//  Utils.swift
//  Rick&Morty
//
//  Created by Andriy Stefanchuk on 28.06.18.
//  Copyright © 2018 Andriy Stefanchuk. All rights reserved.
//

import UIKit
import Dodo

class Utils {
    enum DodoType {
        case success, warning, error
    }

    static func showMessage(_ message: String, view: UIView, anchor: NSLayoutYAxisAnchor?, dodoType: DodoType, hideAfter delay: TimeInterval = 1.5) {
        view.dodo.topAnchor = anchor
        view.dodo.style.bar.hideOnTap = true
        view.dodo.style.bar.hideAfterDelaySeconds = delay
        switch dodoType {
        case .success:
            view.dodo.success(message)
        case .warning:
            view.dodo.warning(message)
        case .error:
            view.dodo.error(message)
        }
    }

    static func addRightButtonAction(image: UIImage, tintColor: UIColor, view: UIView, onTap: @escaping ()->()) {
        view.dodo.style.rightButton.image = image
        view.dodo.style.rightButton.tintColor = tintColor
        view.dodo.style.rightButton.hideOnTap = true
        view.dodo.style.rightButton.onTap = onTap
    }
}
