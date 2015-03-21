//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Chuck McMullen on 3/18/15.
//  Copyright (c) 2015 Chuck McMullen. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var title:String!
    var filePathUrl:NSURL!
    init(title:String, filePathUrl: NSURL){
        self.title = title
        self.filePathUrl = filePathUrl
     }
}
