//
//  WorldSquare.swift
//  SwiftSnake
//
//  Created by Chris on 6/25/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

import UIKit

class WorldSquare : NSObject {
    var coordinates = (0,0)
    var view = UIView()
    //class let color = UIColor.greenColor() Not Yet Supported

    class func genericView() -> UIView {
        var view = UIView()
        view.backgroundColor = UIColor.greenColor()
        view.layer.cornerRadius = 3.0
        
        return view
    }
    
}