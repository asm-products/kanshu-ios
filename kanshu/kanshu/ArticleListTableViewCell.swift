//
//  ArticleListTableViewCell.swift
//  kanshu
//
//  Created by Christopher Wood on 3/28/15.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {

    var entry: Entry? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    func updateUI() {
        if let e = entry {
            titleLabel.text = e.title
            bodyTextView.text = e.body
            cellImageView.image = e.image
            likesLabel.text =  "\(e.likes)"
            commentsLabel.text = "Comments: \(e.comments)"
            sourceLabel.text = e.source
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func drawRect(rect: CGRect) {
        updateUI()
    }

}
