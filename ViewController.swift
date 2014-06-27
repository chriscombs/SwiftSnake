//
//  ViewController.swift
//  SwiftSnake
//
//  Created by Chris on 6/25/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

import UIKit
import Foundation

let gridSize:Int = 30
let gameUpdateSpeed = 0.25

class ViewController: UIViewController, WorldDelegate {
    
    var worldView = World() //Because the compiler wont let me leave it blank

    @IBOutlet var scoreLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "0"
        
        worldView = World()
        worldView.delegate = self
        view.addSubview(worldView)
        
        self.addRecognizers()       
        let timer = NSTimer.scheduledTimerWithTimeInterval(gameUpdateSpeed, target: self, selector: "updateWorld", userInfo: nil, repeats: true)
    }
    
    override func viewDidLayoutSubviews() {
        let length = view.bounds.size.height-80 > view.bounds.size.width ? view.bounds.size.width : view.bounds.size.height-80
        worldView.frame = CGRectMake(view.bounds.width/2 - length/2 + 10, 80, length-20, length-20)
    }

    func addRecognizers() {
        let upRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:"handleSwipe:")
        upRecognizer.direction = .Up
        let downRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:"handleSwipe:")
        downRecognizer.direction = .Down
        let leftRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:"handleSwipe:")
        leftRecognizer.direction = .Left
        let rightRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:"handleSwipe:")
        rightRecognizer.direction = .Right
        view.addGestureRecognizer(upRecognizer)
        view.addGestureRecognizer(downRecognizer)
        view.addGestureRecognizer(leftRecognizer)
        view.addGestureRecognizer(rightRecognizer)
    }
    
    func handleSwipe(swipe:UISwipeGestureRecognizer) {
        let oldDirection = worldView.snake.direction // In order to make sure the user can't turn 180 degrees
        switch swipe.direction {
        case UISwipeGestureRecognizerDirection.Up:
            if (oldDirection != Direction.Down) {
                worldView.snake.changeDirection(Direction.Up)
            }
        case UISwipeGestureRecognizerDirection.Down:
            if (oldDirection != Direction.Up) {
                worldView.snake.changeDirection(Direction.Down)
            }
        case UISwipeGestureRecognizerDirection.Left:
            if (oldDirection != Direction.Right) {
                worldView.snake.changeDirection(Direction.Left)
            }
        case UISwipeGestureRecognizerDirection.Right:
            if (oldDirection != Direction.Left) {
                worldView.snake.changeDirection(Direction.Right)
            }
        default:
            println("Some other mysterious direction")
        }
    }
    
    func updateWorld() {
        worldView.snake.moveHead()
        worldView.updateSquareViews()
    }
    
    func snakeDidEatApple() {
        var count:Int = scoreLabel.text.toInt()!
        count++
        scoreLabel.text = "\(count)"
    }
    func snakeDidHitEdge()  {
        scoreLabel.text = "0"
    }
}

