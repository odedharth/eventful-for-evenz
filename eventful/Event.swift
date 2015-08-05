//
//  Event.swift
//  eventful
//
//  Created by Admin on 8/5/15.
//  Copyright (c) 2015 Oded Harth. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var title : NSString
    var venue : NSString
    var date : NSString
    var performers : [String]?
    var imageURL : NSString?
    var image : UIImage?
    var type : Category?
    var latitude : NSString?
    var longitude : NSString?
    
    init(title : NSString, venue : NSString, date: NSString) {
        self.title = title
        self.venue = venue
        self.date = date
    }
}