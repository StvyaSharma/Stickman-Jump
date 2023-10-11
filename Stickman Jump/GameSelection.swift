//
//  GameSelection.swift
//  Stickman Jump
//
//  Created by Stvya Sharma on 11/05/21.
//

import Foundation
import UIKit
import SpriteKit

class GameSelection : SKScene {
    
    var ClimbGameButton:SKSpriteNode!
    var RunGameButton:SKSpriteNode!
    var backMenuButton:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        nodeInit()
    }
    
    func nodeInit() {
        ClimbGameButton = self.childNode(withName: "ClimbGameButton") as? SKSpriteNode
        RunGameButton = self.childNode(withName: "RunGameButton") as? SKSpriteNode
        backMenuButton = self.childNode(withName: "backMenuButton") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "ClimbGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = SKScene(fileNamed: "ClimbGame")
                gameScene!.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!,transition: transition)
                self.view?.backgroundColor = UIColor.white
                
            } else if nodesArray.first?.name == "RunGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = SKScene(fileNamed: "RunGame")
                gameScene!.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!,transition: transition)
                self.view?.backgroundColor = UIColor.white
            } else if nodesArray.first?.name == "backMenuButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = SKScene(fileNamed: "MenuScene")
                gameScene!.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!,transition: transition)
            }
        }
    }
    
  

}
