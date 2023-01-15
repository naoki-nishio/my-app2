//
//  GameScene.swift
//  FootballGame
//
//  Created by Nishio Naoki on 2022/12/22.
//

import SpriteKit
import GameplayKit
import GameKit


var bestflag = false

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let messageLabel = SKLabelNode(fontNamed: "Verdana-bold")
    var background:SKSpriteNode!
    
    var ball:SKSpriteNode!
    let backgroundTexture = SKTexture(imageNamed: "soccor_ground")
    let ballTexture = SKTexture(imageNamed: "ball")
    var stop = false
    var score: Double?
    let userDefaults:UserDefaults = UserDefaults.standard
    override func didMove(to view: SKView) {
        setupBall()
        setupBackgroung()
        setupLabel()
        self.messageLabel.isHidden = true
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if stop == false{
            ball.removeAllActions()
            print("ボールの位置")
            print(ball.position.x)
            let lineposition = Double(self.frame.size.width*(418/500 + 1/8))
            print("ラインの位置")
            print(lineposition)
            
            score = (lineposition - Double(ball.position.x))*3/10
            
            
            if score! > 0 {
                
                messageLabel.text = "\(String(format:"%.3f",score!))cm"
                var bestScore = userDefaults.double(forKey: "BEST")
                
                print(bestScore)
                if  score! < bestScore {
                    bestScore = score!
                    bestflag = true
                    let scoreReport = GKScore.init(leaderboardIdentifier: ("bestscore"))
                    print(bestScore)
                    scoreReport.value = Int64(round(Double(bestScore)*1000))
                    
                    GKScore.report([scoreReport]) {
                        error in
                        if (error == nil) {
                            print("ok")
                        } else {
                            print("")
                        }
                    }
                    userDefaults.set(bestScore, forKey: "BEST")
                    userDefaults.synchronize()
                }
            }else{
                messageLabel.text = "OUT"
                score = 0
            }
            messageLabel.fontColor = SKColor.white
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                guard let skView = self.view else {
                    return
                }
                let nextScene = ResultScene(size: self.size)
                nextScene.scaleMode = self.scaleMode
                nextScene.viewScore = self.score
                nextScene.scaleMode = self.scaleMode
                skView.presentScene(nextScene)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.messageLabel.isHidden = false
            }
            
        }else if stop == true{
            stop = false
            guard let skView = self.view else {
                return
            }
            let nextScene = ResultScene(size: self.size)
            nextScene.scaleMode = self.scaleMode
            nextScene.viewScore = self.score
            nextScene.scaleMode = self.scaleMode
            skView.presentScene(nextScene)
        }
        
        
        
    }
    
    
    
    
    func setupBall(){
        ballTexture.filteringMode = .linear
        ball = SKSpriteNode(texture: ballTexture)
        ball.position = CGPoint(x: -200, y:self.frame.size.height/2)
        let ballSize = self.frame.size.width/4
        ball.size = CGSize(width:ballSize,height:ballSize)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.height/2)
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.restitution = 0.0
        ball.physicsBody?.affectedByGravity = false
        ball.zPosition = 10
        
        let action3 = SKAction.moveBy(x: self.frame.width+200+Double(ball.size.width), y: 0, duration: 0.80)
        
        // アクションを無限ループさせる.
        ball.run(action3){
            self.messageLabel.isHidden = false
            self.messageLabel.text = "OUT"
            self.score = 0
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                guard let skView = self.view else {
                    return
                }
                let nextScene = ResultScene(size: self.size)
                nextScene.scaleMode = self.scaleMode
                nextScene.viewScore = self.score
                nextScene.scaleMode = self.scaleMode
                skView.presentScene(nextScene)
            }
        }
        
        
        
        
        addChild(ball)
    }
    
    
    func setupBackgroung(){
        backgroundTexture.filteringMode = .nearest
        background = SKSpriteNode(texture: backgroundTexture)
        
        background.size = CGSize(
            width:self.frame.size.width,
            height: self.frame.size.height
        )
        
        background.position = CGPoint(x:self.frame.size.width/2,
                                      y: self.frame.size.height/2)
        background.zPosition = -10
        
        addChild(background)
    }
    
    
    
    
    func setupLabel(){
        var message:String = ""
        
        messageLabel.text = message
        messageLabel.horizontalAlignmentMode = .center
        messageLabel.fontSize = 50
        messageLabel.fontColor = SKColor.white
        messageLabel.position =  CGPoint(x: self.size.width / 2 ,y: self.size.height*3 / 4)
        messageLabel.zPosition = 10
        
        addChild(messageLabel)
    }
    
    
}
