

import SpriteKit


class TitleScene: SKScene ,UITextFieldDelegate{
    
    let nameText = SKLabelNode(fontNamed: "arial")
    let label = SKLabelNode(fontNamed: "Verdana-bold")
    let userDefaults:UserDefaults = UserDefaults.standard

    override func didMove(to view: SKView) {
        setupBackgroung()
        setupStartButton()
        setupScoreLabel()
        setupNameLabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let skView = self.view else {
            return
        }
        if let touch = touches.first as UITouch? {
            let userName = nameText.text
            userDefaults.set(userName, forKey: "NAME")
            userDefaults.synchronize()
            print(userName as Any)
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
    
    
    func setupNameLabel(){
        let nameFlag = userDefaults.string(forKey: "NAME")
        
        if nameFlag == ""{
            nameText.text = "No name"
        } else {
            nameText.text = nameFlag
        }
        nameText.fontSize = 30
        nameText.fontColor = SKColor.white
        nameText.position =  CGPoint(x: self.size.width / 4 ,y: self.size.height*9 / 10)
        nameText.zPosition = 10
        nameText.name = "userNameLabel"
        
        addChild(nameText)
        
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
    
    
    func setupScoreLabel(){
        let scoreLabel = SKLabelNode(fontNamed:  "arial")
        let bestScore = userDefaults.integer(forKey: "BEST")
        
        scoreLabel.text = "BEST:\n\(bestScore)m"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position =  CGPoint(x: self.size.width / 4 ,y: self.size.height*8.7 / 10)
        scoreLabel.zPosition = 10
        
        addChild(scoreLabel)
        
    }
    
    
    func setupBackgroung(){
        var background:SKSpriteNode!
        let backgroundTexture = SKTexture(imageNamed: "testbackground")
        
        backgroundTexture.filteringMode = .nearest
        background = SKSpriteNode(texture: backgroundTexture)
        background.size = CGSize(
            width:self.frame.size.height*background.size.width/background.size.height,
            height: self.frame.size.height
        )
        background.position = CGPoint(x:background.size.width/2, y:self.frame.size.height/2)
        background.zPosition = -10
        
        addChild(background)
    }
    
}
