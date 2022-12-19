//
//  GameScene.swift
//  Project11
//
//  Created by Edgaras Blauzdys on 2022-12-11.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    var ballsLimitLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var ballsLimit = 5 {
        didSet{
            ballsLimitLabel.text = "Balls limit: \(ballsLimit)"
        }
    }
    
    var ballColours = ["ballBlue", "ballRed", "ballCyan", "ballGreen", "ballYellow", "ballGrey", "ballPurple"]
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = true {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballsLimitLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsLimitLabel.text = "Balls limit: 5"
        ballsLimitLabel.horizontalAlignmentMode = .right
        ballsLimitLabel.position = CGPoint(x: 980, y: 660)
        addChild(ballsLimitLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Done"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            var locationBall = touch.location(in: self)
            locationBall.y = 700
            let objects = nodes(at: location)
            
            if objects.contains(editLabel) {
                //editingMode = !editingMode
                //another way of doing so (flips boolean values)
                editingMode.toggle()
            } else {
                if editingMode {
                    //create a box
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location
                    
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    box.name = "box"
                    addChild(box)
                } else {
                    ballColours.shuffle()
                    
                    let ball = SKSpriteNode(imageNamed: ballColours[0])
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    //bitmask means "which collisions do you want to know about?" and by default it's set to nothing. So by setting contactTestBitMask to the value of collisionBitMask we're saying, "tell me about every collision."
                    ball.physicsBody?.restitution = 0.4
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.position = locationBall
                    ball.name = "ball"
                    addChild(ball)
                }
            }
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            ballsLimit += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            ballsLimit -= 1
            gameOver()
        } else if object.name == "box" {
            destroy (box: object)
        }
    }
    
    func destroy(box: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = box.position
            addChild(fireParticles)
        }
        box.removeFromParent()
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    func gameOver() {
        if ballsLimit < 1 {
            print("Lose")
            let ac = UIAlertController(title: "Game over!", message: "Press button to restart", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Restart", style: .default) { _ in
                self.newGame()
            }
            ac.addAction(restart)
            DispatchQueue.main.async {
                self.view?.window?.rootViewController?.present(ac, animated: true, completion: nil)
            }
            
        }
    }
    
    func newGame() {
        score = 0
        ballsLimit = 5
        editingMode = true
    }
}
