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

class ViewController: UIViewController {
    
    var worldView = World() //Because the compiler wont let me leave it blank

    @IBOutlet var scoreLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "0"
        
        worldView = World()
        view.addSubview(worldView)
        
        self.addRecognizers()       
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateWorld", userInfo: nil, repeats: true)
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
        switch swipe.direction {
        case UISwipeGestureRecognizerDirection.Up:
            worldView.snake.direction = Direction.Up
        case UISwipeGestureRecognizerDirection.Down:
            worldView.snake.direction = Direction.Down
        case UISwipeGestureRecognizerDirection.Left:
            worldView.snake.direction = Direction.Left
        case UISwipeGestureRecognizerDirection.Right:
            worldView.snake.direction = Direction.Right
        default:
            println("Some other mysterious direction")
        }
    }
    
    func updateWorld() {
        worldView.snake.moveHead()
        worldView.updateSquareViews()
    }
}

