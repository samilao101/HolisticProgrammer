//
//  GameScene.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 3/3/22.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    var now: TimeInterval?
    var doit: Bool = false
    
    override func didMove(to view: SKView) {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

    }
    
    var blueBall: SKSpriteNode {
        
        let ball = SKSpriteNode(imageNamed: "ballBlue")
        
        ball.position = CGPoint(x: CGFloat.random(in: 40...260), y: 400)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 0
        ball.physicsBody?.friction = 0
        return ball
        
    }
    
    var redBall: SKSpriteNode {
       
        let ball = SKSpriteNode(imageNamed: "ballRed")
        
        ball.position = CGPoint(x: CGFloat.random(in: 40...260), y: 400)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 0
        ball.physicsBody?.friction = 0
        return ball
        
    }
    

    func createObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadBlueBall(notification:)), name: blueName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadRedBall(notification:)), name: redName, object: nil)
        
    }
    
    @objc func loadBlueBall(notification: NSNotification) {
        addChild(blueBall)
    }
    
    @objc func loadRedBall(notification: NSNotification) {
        addChild(redBall)

    }
    

    
 
    
    
    
}
