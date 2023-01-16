//
//  GameScene.swift
//  Milestone16-18
//
//  Created by Edgaras Blauzdys on 2023-01-12.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var bulletsLabel: SKLabelNode!
    var reloadLabel: SKLabelNode!
    
    var player: SKSpriteNode!
    
    var time = 60 {
        didSet {
            timerLabel.text = "Time: \(time)"
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var bullets = 6 {
        didSet {
            bulletsLabel.text = "Bullets: \(bullets)"
        }
    }
    
    let possibleTargets = ["karateman", "penguinEvil", "penguinStrongEvil"]
    var isGameOver = false
    
    var gameTimer: Timer?
    var timeToLeft: Timer?
    var targetsGenerated = 0
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        timerLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        timerLabel.position = CGPoint(x: 16, y: 740)
        timerLabel.horizontalAlignmentMode = .left
        addChild(timerLabel)
        
        bulletsLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        bulletsLabel.position = CGPoint(x: 520, y: 740)
        bulletsLabel.text = "Bullets: \(bullets)"
        bulletsLabel.horizontalAlignmentMode = .center
        addChild(bulletsLabel)
        
        reloadLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        reloadLabel.text = "Reload"

        reloadLabel.isHidden = true
        reloadLabel.position = CGPoint(x: 520, y: 740)
        reloadLabel.horizontalAlignmentMode = .center
        addChild(reloadLabel)
        
        score = 0
        time = 60
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        startGame()
        
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 || node.position.y > 800 || node.position.x > 1100 {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        var locationBall = touch.location(in: self)
        locationBall.y = 10
        let tappedNodes = nodes(at: location)
        
        if bullets <= 1 {
            reloadLabel.isHidden = false
            bulletsLabel.isHidden = true
            run(SKAction.playSoundFileNamed("empty.wav", waitForCompletion:false))
            if tappedNodes.contains(reloadLabel) {
                bullets = 6
                run(SKAction.playSoundFileNamed("reload.wav", waitForCompletion:false))
                reloadLabel.isHidden = true
                bulletsLabel.isHidden = false
            }
        } else {
            bullets -= 1
            createBall(in: locationBall)
            run(SKAction.playSoundFileNamed("shot.wav", waitForCompletion:false))
        }
    }
    
    func createBall(in location: CGPoint) {
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.physicsBody = SKPhysicsBody(texture: ball.texture!, size: ball.size)
        ball.position = location
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        ball.name = "ball"
        addChild(ball)
        let spin = SKAction.rotate(byAngle: .pi, duration: 2)
        let spinForever = SKAction.repeatForever(spin)
        ball.run(spinForever)
    }
    
    @objc func createTargets() {
        guard let target = possibleTargets.randomElement() else { return }
        
        let lineOne = CGPoint(x: 10, y: 650)
        let lineTwo = CGPoint(x: 1200, y: 450)
        let lineThree = CGPoint(x: 10, y: 250)
        let lines = [lineOne, lineTwo, lineThree]
        let randomSpeed = CGFloat.random(in: 100...500)
        
        let sprite = SKSpriteNode(imageNamed: target)
        sprite.name = target
        
        switch target {
        case "penguinEvil":
            sprite.name = "enemy"
        case "penguinStrongEvil":
            sprite.name = "strongEnemy"
        case "karateman":
            sprite.name = "karateman"
        default:
            break
        }
        
        sprite.position = lines.randomElement()!
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        if sprite.position == lineTwo {
            sprite.physicsBody?.velocity = CGVector(dx: -(randomSpeed), dy: 0)
        } else {
            sprite.physicsBody?.velocity = CGVector(dx: (randomSpeed), dy: 0)
        }
        sprite.physicsBody!.contactTestBitMask = sprite.physicsBody!.collisionBitMask
    
        addChild(sprite)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "enemy" {
            destroy(box: ball, object: object)
            print("enemy")
            score += 1
            time += 2
            
        } else if object.name == "strongEnemy" {
            destroy(box: ball, object: object)
            print("strongEnemy")
            score += 3
            time += 4
        } else if object.name == "karateman" {
            destroy(box: ball, object: object)
            print("karateman")
            score -= 5
        }
    }
    func destroy(box: SKNode, object: SKNode) {
        box.removeFromParent()
        object.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        } else if nodeA.name == "enemy" {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            touchInField()
        } else if nodeA.name == "superEnemy" {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            touchInField()
        } else if nodeA.name == "spider" {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            touchInField()
        }
    }
    
    func touchInField() {
        scoreLabel.xScale = 2.85
        scoreLabel.yScale = 2.50
        score -= 5
        time -= 5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.scoreLabel.xScale = 1
            self.scoreLabel.yScale = 1
        }
    }
    
    @objc func gameTimeManager() {
        time -= 1
        if time < 1 {
            gameOver()
            return
        } else if time <= 5 {
            timerLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.timerLabel.isHidden = false
            }
        }
    }
    
    func startGame() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTargets), userInfo: nil, repeats: true)
        timeToLeft?.invalidate()
        timeToLeft = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimeManager), userInfo: nil, repeats: true)
    }
    
    func gameOver() {
        gameTimer?.invalidate()
        timeToLeft?.invalidate()
        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.position = CGPoint(x: 512, y: 384)
        gameOver.zPosition = 1
        addChild(gameOver)
        run(SKAction.playSoundFileNamed("gameOverSound.wav", waitForCompletion:false))
    }
}
