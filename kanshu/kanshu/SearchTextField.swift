//
//  SearchTextField.swift
//  kanshu
//
//  Created by Christopher Wood on 3/28/15.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    let image = UIImage(named: "search")
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.rightView = UIImageView(image: image)
        self.rightViewMode = UITextFieldViewMode.Always
        self.tintColor = UIColor.clearColor()
    }
}
