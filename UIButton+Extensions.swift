//
//  UIButton+Extensions.swift
//  EnvChanger
//
//  Created by Nikola B Nikolov on 15.12.21.
//

import UIKit

extension UIButton {
    /// Formats an `EnvButton` with a title.
    /// - Parameter title: Title for the `EnvButton`.
    func format(with title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: Constants.envButtonTitleFontSize)
        layer.cornerRadius = Constants.envButtonCornerRadius
        layer.borderWidth = Constants.envButtonBorderWidth
        setTitleColor(.white, for: .normal)
        backgroundColor = .gray
    }
    
    /// Formats an `EnvButton` with an image.
    /// - Parameter image: Image for the `EnvButton`.
    func format(with image: UIImage) {
        setImage(image, for: .normal)
        imageEdgeInsets = Constants.envButtonImageInsets
        imageView?.contentMode = .scaleAspectFit
    }
}
