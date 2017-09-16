//
// Created by Timofey on 6/28/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    func with(title: String?, for state: UIControlState = .normal) -> Self {
        self.setTitle(title, for: state)
        return self
    }
    
    func with(image: UIImage, for state: UIControlState = .normal) -> Self {
        self.setImage(image, for: state)
        return self
    }
    
    func with(titleColor: UIColor, for state: UIControlState = .normal) -> Self {
        self.setTitleColor(titleColor, for: state)
        return self
    }

    func with(font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }

    func with(titleEdgeInsets: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = titleEdgeInsets
        return self
    }

    func with(contentEdgeInsets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = contentEdgeInsets
        return self
    }
    
}
