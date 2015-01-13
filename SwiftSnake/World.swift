//
//  World.swift
//  SwiftSnake
//
//  Created by Chris on 6/25/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

import UIKit
import QuartzCore

let gridColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3)


protocol WorldDelegate {
    func snakeDidEatApple()
    func snakeDidHitEdge()
}

class World : UIView  {
    var linesArray:[UIView] = []
    var shownSquares: [WorldSquare] = []
    var snake = Snake()
    var currentApple = Apple()
    var delegate:WorldDelegate?
    
    override init() {
        super.init(frame: CGRectZero)
        layer.borderColor = UIColor.greenColor().CGColor
        layer.borderWidth = 2.0
        createLines()
        updateSquareViews()
        placeNewApple()
        shownSquares.append(currentApple)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLines() {
        // Vertical lines
        for index in 0..<gridSize {
            var lineView:UIView = UIView(frame: CGRectZero)
            lineView.frame = CGRectMake(0, 0, 1, 0)
            lineView.backgroundColor = gridColor
            linesArray.append(lineView)
            self.addSubview(lineView)
        }
        // Horizontal lines
        for index in 0..<gridSize {
            var lineView:UIView = UIView(frame: CGRectZero)
            lineView.frame = CGRectMake(0, 0, 0, 1)
            lineView.backgroundColor = gridColor
            linesArray.append(lineView)
            self.addSubview(lineView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let fraction = self.frame.size.width/CGFloat(gridSize)
        // Vertical
        for index in 1..<gridSize {
            var view = linesArray[index-1]
            view.frame.size.height = self.frame.size.height
            view.frame.origin.x = fraction * CGFloat(index)
        }
        // Horizontal
        for index in gridSize..<gridSize*2 {
            var view = linesArray[index-1]
            view.frame.size.width = self.frame.size.width
            view.frame.origin.y = fraction * CGFloat(index-gridSize)
        }
        
        for square in shownSquares {
            let (coordX, coordY) = square.coordinates
            square.view.frame = CGRectMake(CGFloat(coordX)*fraction, CGFloat(coordY)*fraction, fraction, fraction)
        }
    }
    
    func updateSquareViews() {
        // Remove all existing squares
        for square in shownSquares {
            square.view.removeFromSuperview()
        }
        shownSquares = []
        // Re-add the apple
        shownSquares.append(currentApple)
        var view = Apple.genericView()
        addSubview(view)
        currentApple.view = view
        
        let (x, y) = snake.tailSquares[0].coordinates
        for index in 1..<snake.tailSquares.count-1 { // Check to see if snake is colliding with itself
            println(snake.tailSquares.count-1)
            let (tailX, tailY) = snake.tailSquares[index].coordinates
            if (x == tailX && y == tailY) {
                gameOver()
                return
            }
        }
        let (appleX, appleY) = currentApple.coordinates
        if x < 0 || y < 0 || x >= gridSize || y >= gridSize { // Check to see if snake is off the grid
            gameOver()
            return
        }
        else if x == appleX && y == appleY { // Check to see if snake is at apple
            snake.addLength()
            delegate?.snakeDidEatApple()
            placeNewApple()
        }        
        // Draw the snake
        for square in snake.tailSquares {
            var view = WorldSquare.genericView()
            addSubview(view)
            square.view = view
            shownSquares.append(square)
        }
    }
    
    func placeNewApple() {
        let (randomX, randomY) = (Int(arc4random_uniform(UInt32(gridSize))), Int(arc4random_uniform(UInt32(gridSize))))
        // Check to make sure you arent placing the apple on a part of the snake
        for square in snake.tailSquares {
            let (x, y) = square.coordinates
            if randomX == x && randomY == y {
                println("BREAK") // TODO
            }
        }
        currentApple.coordinates = (randomX, randomY)
    }
    
    func gameOver() {
        delegate?.snakeDidHitEdge()
        snake = Snake()
    }
    
}