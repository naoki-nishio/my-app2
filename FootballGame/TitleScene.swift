

import SpriteKit
import Foundation
import GoogleMobileAds

class TitleScene: SKScene ,UITextFieldDelegate, GADBannerViewDelegate{
    let label = SKLabelNode(fontNamed: "Verdana-bold")
    let userDefaults:UserDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        userDefaults.register(defaults: ["BEST":1000])
        setupBestLabel()
        setupBackgroung()
        setupStartButton()
        setupScoreLabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let skView = self.view else {
            return
        }
        if let touch = touches.first as UITouch? {
            let location = touch.location(in: self)
            if self.atPoint(location).name == "startButton" {
                let nextScene = GameScene(size: self.size)
                nextScene.scaleMode = self.scaleMode
                nextScene.name = "GameScene"
                skView.presentScene(nextScene)
            }else{
                print("×circle2")
            }
        }
    }
    
    
    
    
    func setupStartButton(){
        let startButton = SKLabelNode(fontNamed: "Verdana-bold")
        
        startButton.text = "START"
        startButton.horizontalAlignmentMode = .center
        startButton.fontSize = 50
        startButton.fontColor = SKColor.white
        startButton.position =  CGPoint(x: self.size.width / 2 ,y: self.size.height / 6)
        startButton.zPosition = 10
        startButton.name = "startButton"
        
        addChild(startButton)
        
    }
    
    
    
    
    
    func setupBackgroung(){
        var background:SKSpriteNode!
        let backgroundTexture = SKTexture(imageNamed: "soccor_ground")
        
        backgroundTexture.filteringMode = .nearest
        background = SKSpriteNode(texture: backgroundTexture)
        //        print(background.size)
        
        
        print(self.frame.size)
        background.size = CGSize(
            width:self.frame.size.width,
            height: self.frame.size.height
        )
        
        background.position = CGPoint(x:self.frame.size.width/2,
                                      y: self.frame.size.height/2)
        background.zPosition = -10
        
        addChild(background)
        
    }
    
    func setupBall(){
        var ball:SKSpriteNode!
        let ballTexture = SKTexture(imageNamed: "ball")
        ballTexture.filteringMode = .linear
        ball = SKSpriteNode(texture: ballTexture)
        ball.position = CGPoint(x: 388, y:self.frame.size.height/2)
        ball.size = CGSize(width:100,height:100)
        
        addChild(ball)
    }
    
    func setupScoreLabel(){
        let scoreLabel = SKLabelNode(fontNamed:  "Verdana-bold")
        let bestScore = userDefaults.double(forKey: "BEST")
        
        print(bestScore)
        if bestScore == 1000.0 {
            scoreLabel.text = "-----mm"
        }else{
            scoreLabel.text = "\(String(format:"%.3f",bestScore))cm"
        }
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position =  CGPoint(x: self.size.width / 20 ,y: self.size.height*8.5 / 10)
        scoreLabel.zPosition = 10
        
        addChild(scoreLabel)
        
    }
    
    func setupBestLabel(){
        let bestLabel = SKLabelNode(fontNamed:  "Verdana-bold")
        bestLabel.horizontalAlignmentMode = .left
        bestLabel.text = "BEST"
        bestLabel.fontSize = 40
        bestLabel.fontColor = SKColor.white
        bestLabel.position =  CGPoint(x: self.size.width / 20 ,y: self.size.height*9.0 / 10)
        bestLabel.zPosition = 10
        addChild(bestLabel)
        
    }
    
   
    
    
}

