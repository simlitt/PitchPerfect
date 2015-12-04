//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Parabsimran Litt on 12/2/15.
//  Copyright © 2015 Parabsimran Litt. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var title: String!
    var filePathUrl: NSURL!
    
    init(title: String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
}
