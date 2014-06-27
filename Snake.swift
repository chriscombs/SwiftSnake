//
//  Snake.swift
//  SwiftSnake
//
//  Created by Chris on 6/25/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

import UIKit

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

class Snake : NSObject {
    var length = 3
    var direction: Direction = Direction.Up
    
    var tailSquares:WorldSquare[] = []
    
    init() {
        super.init()
        initializeSnakeSpot()
    }
    
    func initializeSnakeSpot() {
        let firstSquare = WorldSquare()
        firstSquare.coordinates = (gridSize/2-1, gridSize/2-1) // Start in the middle
        tailSquares += firstSquare
        for index in 1..length {
            let (previousX, previousY) = tailSquares[index-1].coordinates
            let point = (previousX, previousY+1)
            let worldSquare = WorldSquare()
            worldSquare.coordinates = point
            tailSquares += worldSquare
        }
    }
    
    func changeDirection(direct:Direction)  {
        direction = direct
    }
    
    func addLength() {
        length++
        var newSquare = WorldSquare()
        newSquare.coordinates = tailSquares[length-2].coordinates
        tailSquares += newSquare
    }
    
    func moveHead() {
        let (previousX, previousY) = tailSquares[0].coordinates
        switch direction {
        case Direction.Up:
            var (x, y) = tailSquares[0].coordinates
            y--
            tailSquares[0].coordinates = (x,y)
        case Direction.Down:
            var (x, y) = tailSquares[0].coordinates
            y++
            tailSquares[0].coordinates = (x,y)
        case Direction.Left:
            var (x, y) = tailSquares[0].coordinates
            x--
            tailSquares[0].coordinates = (x,y)
        case Direction.Right:
            var (x, y) = tailSquares[0].coordinates
            x++
            tailSquares[0].coordinates = (x,y)
        }
        calculateTail(previousX, oldY: previousY)
    }
    
    func calculateTail(oldX: Int, oldY: Int) {
        var oldPlaceholder = tailSquares[1].coordinates
        tailSquares[1].coordinates = (oldX, oldY)
        for index in 2..length {
            var currentSpot = tailSquares[index].coordinates
            tailSquares[index].coordinates = oldPlaceholder
            oldPlaceholder = currentSpot
        }
    }
    
}
