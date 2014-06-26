//
//  Snake.swift
//  SwiftSnake
//
//  Created by Chris on 6/25/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

import Foundation

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

class Snake : WorldSquare {
    var length = 2
    var direction: Direction = Direction.Up
    var tailPoints:(Int, Int)[] = [(gridSize/2, gridSize/2)]
    
    func changeDirection(direct:Direction)  {
        direction = direct
    }
    
    func addLength() {
        length++
    }
    
    
}
