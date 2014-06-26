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

class World : UIView  {
    var linesArray:UIView[] = []
    var applesArray:Apple[] = []
    var shownSquares: WorldSquare[] = []
    var snake = Snake()
    
    init() {
        super.init(frame: CGRectZero)
        layer.borderColor = UIColor.greenColor().CGColor
        layer.borderWidth = 2.0
        createLines()
        updateSquareViews()
    }
    
    func createLines() {
        // Vertical lines
        for index in 0..gridSize {
            var lineView:UIView = UIView(frame: CGRectZero)
            lineView.frame = CGRectMake(0, 0, 1, 0)
            lineView.backgroundColor = gridColor
            linesArray += lineView
            self.addSubview(lineView)
        }
        // Horizontal lines
        for index in 0..gridSize {
            var lineView:UIView = UIView(frame: CGRectZero)
            lineView.frame = CGRectMake(0, 0, 0, 1)
            lineView.backgroundColor = gridColor
            linesArray += lineView
            self.addSubview(lineView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let fraction = self.frame.size.width/Double(gridSize)
        // Vertical
        for index in 1..gridSize {
            var view = linesArray[index-1]
            view.frame.size.height = self.frame.size.height
            view.frame.origin.x = fraction * Double(index)
        }
        // Horizontal
        for index in gridSize..gridSize*2 {
            var view = linesArray[index-1]
            view.frame.size.width = self.frame.size.width
            view.frame.origin.y = fraction * Double(index-gridSize)
        }
        
        for square in shownSquares {
            let (coordX, coordY) = square.coordinates
            square.view.frame = CGRectMake(Double(coordX)*fraction, Double(coordY)*fraction, fraction, fraction)
        }
    }
    
    func updateSquareViews() {
        for square in shownSquares {
            square.view.removeFromSuperview()
        }
        
        let (x, y) = snake.tailSquares[0].coordinates
        if (x < 1 || y < 1 || x >= gridSize || y >= gridSize) {
            // TODO - game over
            snake = Snake()
        }
        
        for square in snake.tailSquares {
            var view = WorldSquare.genericView()
            addSubview(view)
            square.view = view
            shownSquares += square
        }
    }
    
}