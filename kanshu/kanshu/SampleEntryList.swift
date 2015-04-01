//
//  SampleEntryList.swift
//  kanshu
//
//  Created by Christopher Wood on 3/28/15.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

struct Entry {
    var title: String!
    var body: String!
    var likes: Int!
    var source: String!
    var comments: Int!
    var image: UIImage!
    
    init(title: String, body: String, likes: Int, source: String, comments: Int, image: UIImage) {
        self.title = title
        self.body = body
        self.likes = likes
        self.source = source
        self.comments = comments
        self.image = image
    }
}



let sampleEntry = Entry(title: "Sample Story", body: "This is a sample. This is a sample. This is a sample. This is a sample. This is a sample. This is a sample. This is a sample.", likes: 12, source: "Sample News LLC", comments: 14, image: UIImage(named: "sample")!)

let sampleEntryList = [[sampleEntry]]