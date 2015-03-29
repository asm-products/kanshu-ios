//
//  ArticleListSorterButton.swift
//  kanshu
//
//  Created by Christopher Wood on 3/27/15.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class ArticleListSorterButton: UIButton {
   
    var activeState: Bool!
    
    required init(coder aDecoder: NSCoder) {
        self.activeState = false
        super.init(coder: aDecoder)
        self.setTitleColor(redColor, forState: .Selected)
        self.addTarget(self, action: "buttonSelected:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func buttonSelected(sender: UIButton) {
        for item in self.superview!.subviews {
            if let button = item as? UIButton {
                button.backgroundColor = redColor
                button.selected = false
            }
        }
        self.selected = true
        self.backgroundColor = UIColor.lightTextColor()
    }
}
