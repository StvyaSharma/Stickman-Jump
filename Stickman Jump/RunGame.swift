//
//  RunGame.swift
//  Stickman Jump
//
//  Created by Stvya Sharma on 11/05/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

public class RunGame: SKScene, SKPhysicsContactDelegate {
//: ### Physics
    struct PhysicsCategory{
        static let Player: UInt32 = 1
        static let Obstacles: UInt32 = 2
    }
    private var bear = SKSpriteNode()
     private var bearWalkingFrames: [SKTexture] = []
    var pauseButton:SKSpriteNode!
    var backbuttonlogo:SKSpriteNode!
    let player = SKShapeNode(circleOfRadius: 50)
    let obstacleSpacing: CGFloat = 800
    let cameraNode = SKCameraNode()
    let HighScoreLabel = SKLabelNode()
    var highscore  = 0
    
    
    func addingbottom(xaxis: Int) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 0, height: 0), cornerRadius: 20)
        let obstacle = SKNode()
        
            let colours = UIColor.black
            let section = SKShapeNode(path: path.cgPath)
            section.position = CGPoint(x: 0, y: 0)
            section.fillColor = colours
            section.strokeColor = colours
            //Physics Properties
            let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
            sectionBody.categoryBitMask = PhysicsCategory.Obstacles
            sectionBody.collisionBitMask = 0
            sectionBody.contactTestBitMask = PhysicsCategory.Player
            sectionBody.affectedByGravity = false
            section.physicsBody = sectionBody
        let bottom = SKSpriteNode(imageNamed: "background")
        bottom.size = CGSize(width: 1200, height: 290)
        obstacle.addChild(bottom)
            obstacle.addChild(section)

        obstacle.position = CGPoint(x: xaxis, y: -800)
        addChild(obstacle)

        

    }
//: ### Starting Function
    public func didBegin(_ contact: SKPhysicsContact) {
        if let nodeA = contact.bodyA.node as? SKShapeNode, let nodeB = contact.bodyB.node as? SKShapeNode{
            if nodeA.fillColor != nodeB.fillColor{
                player.physicsBody?.velocity.dx = 0
                player.removeFromParent()
                bear.removeFromParent()
                score = 0
                player.physicsBody?.velocity.dy = 0.0
                HighScoreLabel.text = String("High Score : \(highscore)")
                scoreLabel.text = String(score)
                addPlayer(colour: UIColor.white)
            }else if nodeA.fillColor == nodeB.fillColor  {
                score += 1
                
                if highscore < score {
                    highscore = score
                }
                
                HighScoreLabel.text = String("High Score : \(highscore)")
                scoreLabel.text = String(score)
                
            }
            
        }
    }
//: ### Adding Player
    func addPlayer(colour: UIColor){
        player.fillColor = colour
        player.strokeColor = player.fillColor
        player.position = CGPoint(x: 0, y: -300)
        //Physics Properties
        let playerBody = SKPhysicsBody(circleOfRadius: 50)
        playerBody.mass = 0
        playerBody.categoryBitMask = PhysicsCategory.Player
        playerBody.collisionBitMask = 4
        player.physicsBody = playerBody
        //Add to scene
        
        
        let bearAnimatedAtlas = SKTextureAtlas(named: "stickman")
          var walkFrames: [SKTexture] = []

          let numImages = bearAnimatedAtlas.textureNames.count
          for i in 1...numImages {
            let bearTextureName = "stickman\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
          }
          bearWalkingFrames = walkFrames
        let firstFrameTexture = bearWalkingFrames[0]
        bear = SKSpriteNode(texture: firstFrameTexture)
        bear.size = CGSize(width: 100, height: 100)
        player.addChild(bear)
        bear.run(SKAction.repeatForever(
            SKAction.animate(with: bearWalkingFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
            withKey:"walkingInPlaceBear")
        addChild(player)
    }
    
//: ### Square Obstacle
    func addLineObstacle(xaxis : Int, width : Int , yHeight : Int){
        let path = UIBezierPath(roundedRect: CGRect(x: -width/2, y: -width/2, width: 20, height: 500), cornerRadius: 20)
        let obstacle = SKNode()
        
            let colours = UIColor.black
            let section = SKShapeNode(path: path.cgPath)
            section.position = CGPoint(x: 0, y: 0)
            section.fillColor = colours
            section.strokeColor = colours
            //Physics Properties
            let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
            sectionBody.categoryBitMask = PhysicsCategory.Obstacles
            sectionBody.collisionBitMask = 0
            sectionBody.contactTestBitMask = PhysicsCategory.Player
            sectionBody.affectedByGravity = false
            section.physicsBody = sectionBody
            obstacle.addChild(section)

        obstacle.position = CGPoint(x: xaxis, y: yHeight)
        addChild(obstacle)

    }
    func addRectObstacle(xaxis : Int, width : Int , yHeight : Int){
        let path = UIBezierPath(roundedRect: CGRect(x: -width/2, y: -width/2, width: 300, height: 500), cornerRadius: 20)
        let obstacle = SKNode()
        
            let colours = UIColor.black
            let section = SKShapeNode(path: path.cgPath)
            section.position = CGPoint(x: 0, y: 0)
            section.fillColor = colours
            section.strokeColor = colours
            //Physics Properties
            let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
            sectionBody.categoryBitMask = PhysicsCategory.Obstacles
            sectionBody.collisionBitMask = 0
            sectionBody.contactTestBitMask = PhysicsCategory.Player
            sectionBody.affectedByGravity = false
            section.physicsBody = sectionBody
            obstacle.addChild(section)

        obstacle.position = CGPoint(x: xaxis, y: yHeight)
        addChild(obstacle)

    }
    func addCircleObstacle(xaxis : Int, width : Int , yHeight : Int){
        
        let obstacle = SKNode()
        
            let colours = UIColor.black
        let section = SKShapeNode(circleOfRadius: 101.5)
            section.position = CGPoint(x: 0, y: 0)
            section.fillColor = colours
            section.strokeColor = colours
            //Physics Properties
        let sectionBody = SKPhysicsBody(circleOfRadius: 101.5)
            sectionBody.categoryBitMask = PhysicsCategory.Obstacles
            sectionBody.collisionBitMask = 0
            sectionBody.contactTestBitMask = PhysicsCategory.Player
            sectionBody.affectedByGravity = false
            section.physicsBody = sectionBody
            obstacle.addChild(section)

        obstacle.position = CGPoint(x: xaxis, y: yHeight)
        addChild(obstacle)

    }
    func addRotatingRectObstacle(xaxis : Int, width : Int , yHeight : Int){
        let path = UIBezierPath(roundedRect: CGRect(x: -width/2, y: -width/2, width: 300, height: 300), cornerRadius: 20)
        let obstacle = SKNode()
        
            let colours = UIColor.black
            let section = SKShapeNode(path: path.cgPath)
            section.position = CGPoint(x: 0, y: 0)
            section.fillColor = colours
            section.strokeColor = colours
            //Physics Properties
            let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
            sectionBody.categoryBitMask = PhysicsCategory.Obstacles
            sectionBody.collisionBitMask = 0
            sectionBody.contactTestBitMask = PhysicsCategory.Player
            sectionBody.affectedByGravity = false
            section.physicsBody = sectionBody
            obstacle.addChild(section)
        let rotateAction = SKAction.rotate(byAngle: -2.0 * CGFloat(Double.pi), duration: 8.0)
        obstacle.run(SKAction.repeatForever(rotateAction))

        obstacle.position = CGPoint(x: xaxis, y: yHeight)
        addChild(obstacle)

    }
    func addPassingBlock(yHeight : Int, width : Int , xaxis: Int){
        let path = UIBezierPath(roundedRect: CGRect(x: -width/2, y: -width/2, width: 20, height: 500), cornerRadius: 20)
        let obstacle = SKNode()
        
            let colours = UIColor.white
            let section = SKShapeNode(path: path.cgPath)
            section.position = CGPoint(x: 0, y: 0)
            section.fillColor = colours
            section.strokeColor = colours
            //Physics Properties
            let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
            sectionBody.categoryBitMask = PhysicsCategory.Obstacles
            sectionBody.collisionBitMask = 0
            sectionBody.contactTestBitMask = PhysicsCategory.Player
            sectionBody.affectedByGravity = false
            section.physicsBody = sectionBody
            obstacle.addChild(section)
        
        obstacle.position = CGPoint(x: xaxis, y: yHeight)
        addChild(obstacle)

    }
    func Lineblock(yHeight: Int, width: Int , xHeight: Int) {
        addPassingBlock(yHeight: yHeight + 500, width: 400, xaxis: xHeight)
        addLineObstacle(xaxis: xHeight, width: 400, yHeight: yHeight)
        addPassingBlock(yHeight: yHeight - 500, width: 400, xaxis: xHeight)

    }
    func Rectblock(yHeight: Int, width: Int , xHeight: Int) {
        addPassingBlock(yHeight: yHeight + 500, width: 400, xaxis: xHeight)
        addRectObstacle(xaxis: xHeight, width: 400, yHeight: yHeight)
        addPassingBlock(yHeight: yHeight - 500, width: 400, xaxis: xHeight)

    }
    func RotateRectblock(yHeight: Int, width: Int , xHeight: Int) {
        addPassingBlock(yHeight: yHeight + 400, width: 400, xaxis: xHeight + 50)
        addPassingBlock(yHeight: yHeight - 450, width: 400, xaxis: xHeight + 50)
        addRotatingRectObstacle(xaxis: xHeight, width: 400, yHeight: yHeight)


    }
    func Circleblock(yHeight: Int, width: Int , xHeight: Int) {
        addPassingBlock(yHeight: yHeight + 300, width: 400, xaxis: xHeight + 50)
        addPassingBlock(yHeight: yHeight - 350, width: 400, xaxis: xHeight + 50)
        addCircleObstacle(xaxis: xHeight - 100, width: 400, yHeight: yHeight)
    }
   
    

//: ### Circle Obstacle
    let scoreLabel = SKLabelNode()
    var score = 0
    var i = 1000
//: ### Function to add Obstacles
    func addObstacle() {
        
        
        var lol = 0
        while lol < 100{
            let x = Int.random(in: 0...24)
            switch x {
            case 0:
                Lineblock(yHeight: -800, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 1:
                addingbottom(xaxis: i)
                i += 800
                Lineblock(yHeight: -320, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 2:
                Lineblock(yHeight: -625, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 3:
                Lineblock(yHeight: -700, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 4:
                addingbottom(xaxis: i)
                i += 400
                Lineblock(yHeight: -550, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 5:
                addingbottom(xaxis: i)
                i += 800
                Lineblock(yHeight: -250, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 6:
                Rectblock(yHeight: -800, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800


            case 8:
                Rectblock(yHeight: -625, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 9:
                Rectblock(yHeight: -700, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 10:
                addingbottom(xaxis: i)
                i += 400
                Rectblock(yHeight: -550, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 11:
                addingbottom(xaxis: i)
                i += 800
                RotateRectblock(yHeight: -250, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 12:
                addingbottom(xaxis: i)
                i += 800
                RotateRectblock(yHeight: -250, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 13:
                RotateRectblock(yHeight: -800, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 14:
                addingbottom(xaxis: i)
                i += 800
                RotateRectblock(yHeight: -320, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 15:
                RotateRectblock(yHeight: -625, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 16:
                RotateRectblock(yHeight: -700, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 17:
                addingbottom(xaxis: i)
                i += 400
                RotateRectblock(yHeight: -550, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 18:
                addingbottom(xaxis: i)
                i += 800
                RotateRectblock(yHeight: -250, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 19:
                Circleblock(yHeight: -800, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 20:
                addingbottom(xaxis: i)
                i += 800
                Circleblock(yHeight: -320, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 21:
                Circleblock(yHeight: -625, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 22:
                Circleblock(yHeight: -700, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 23:
                addingbottom(xaxis: i)
                i += 400
                Circleblock(yHeight: -550, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            case 24:
                addingbottom(xaxis: i)
                i += 800
                Circleblock(yHeight: -250, width: 400, xHeight: i)
                addingbottom(xaxis: i)
                i += 800
            default:
                print("NUll")
            }
            lol += 1
        }
            
        
    }
    func nodeInit() {
        pauseButton = self.childNode(withName: "pauseButton") as? SKSpriteNode
        pauseButton.position.x = cameraNode.position.x + 225
        backbuttonlogo = self.childNode(withName: "backbuttonlogo") as? SKSpriteNode
        backbuttonlogo.position.x = cameraNode.position.x + 225
        
        
    }
    let colours = [UIColor.white]
//: ### Movement of Player
    public override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity.dx = 2
        nodeInit()
        addPlayer(colour: .white)
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = player.position
        scoreLabel.position = CGPoint(x: 0, y: 500)
        scoreLabel.fontColor = .black
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 100
        scoreLabel.text = String(score)
     
        HighScoreLabel.position = CGPoint(x:0, y:-600)
        HighScoreLabel.fontName = "AvenirNext-Bold"
        HighScoreLabel.fontSize = 50
        HighScoreLabel.fontColor = .white
        HighScoreLabel.text = String("High Score : \(highscore)")
        cameraNode.addChild(scoreLabel)
        cameraNode.addChild(HighScoreLabel)
        addObstacle()
    }
    public override func update(_ currentTime: TimeInterval) {
        let playerPositionInCamera = cameraNode.convert(player.position, to: self)
        if playerPositionInCamera.x != cameraNode.position.x && !cameraNode.hasActions(){
            cameraNode.position.x = player.position.x + 200
            
        }
        if player.position.y <= -600 {
            player.position.y = -600
            player.physicsBody?.affectedByGravity = false
        }
        if player.position.y != -600 {
            player.physicsBody?.affectedByGravity = true
        }
        if player.position.x >= -150 {
            player.physicsBody?.isDynamic = true
            player.physicsBody?.velocity.dx = 500
            
        }
        pauseButton.position.x = cameraNode.position.x + 200
        backbuttonlogo.position.x = cameraNode.position.x + -200
        pauseButton.position.y = cameraNode.position.y + 500
        backbuttonlogo.position.y = cameraNode.position.y + 500
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if location.y >= 300 && location.x >= CGFloat(player.position.x) + 350{
                player.physicsBody?.isDynamic = false
                player.physicsBody?.affectedByGravity = false
            }else if player.position.y <= 0{
                player.physicsBody?.velocity.dy = 700.0
            }else if player.position.y <= -600 {
                player.physicsBody?.isDynamic = true
                player.physicsBody?.velocity.dy = 600.0
                
            }
        }
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "pauseButton" {
                if self.view?.isPaused == true {
                    self.view?.isPaused = false
                } else if self.view?.isPaused == false {
                    self.view?.isPaused = true
                }
                
                
                
                
            }else if nodesArray.first?.name == "backbuttonlogo"{
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = SKScene(fileNamed: "MenuScene")
                gameScene!.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!,transition: transition)
                self.view?.backgroundColor = UIColor.white
            }
        }
        
    }
    
}
