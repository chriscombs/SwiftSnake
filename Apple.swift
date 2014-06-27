//
//  Apple.swift
//  SwiftSnake
//
//  Created by Chris on 6/25/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

import UIKit

class Apple : WorldSquare {
   // class let color = UIColor.redColor() Not Yet Supported

    override class func genericView() -> UIView {
        var view = UIView()
        view.backgroundColor = UIColor.redColor()
        view.layer.cornerRadius = 3.0
        
        return view
    }
}