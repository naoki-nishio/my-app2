import SpriteKit
import GameKit
import UIKit



class ResultScene: SKScene{
    var viewScore:Double?
    let label = SKLabelNode(fontNamed: "Verdana-bold")
    let userDefaults:UserDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        setupScoreLabel()
        setupHomeButton()
        setupResultScore()
        setupBackgroung()
        setupBestLabel()
        if bestflag == true {
            setupRetryButton()
            bestflag = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let skView = self.view else {
            return
        }
        if let touch = touches.first as UITouch? {
            let location = touch.location(in: self)
            if self.atPoint(location).name == "homeButton" {
                let nextScene = TitleScene(size: self.size)
                nextScene.scaleMode = self.scaleMode
                skView.presentScene(nextScene)
            }else if self.atPoint(location).name == "retryButton" {
                //                                let nextScene = GameScene(size: self.size)
                //                                nextScene.scaleMode = self.scaleMode
                //                                skView.presentScene(nextScene)
                //
                //                                showShareSheet()
                //
            }else{
                print("×circle2")
            }
            
        }
        
        
        
        
    }
    func setupHomeButton(){
        let homeButton = SKLabelNode(fontNamed: "Verdana-bold")
        homeButton.text = "HOME"
        homeButton.horizontalAlignmentMode = .center
        homeButton.fontSize = 50
        homeButton.fontColor = SKColor.white
        homeButton.position =  CGPoint(x: self.size.width / 2 ,y: self.size.height*1 / 6)
        homeButton.zPosition = 10
        homeButton.name = "homeButton"
        
        addChild(homeButton)
        
    }
    
    func setupResultScore(){
        let scoreLabel = SKLabelNode(fontNamed: "Verdana-bold")
        if viewScore != 0{
            scoreLabel.text = "\(String(format:"%.3f",viewScore!))cm"
        }else{
            scoreLabel.text = "OUT"
        }
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position =  CGPoint(x: self.size.width / 2 ,y: self.size.height*1 / 2)
        scoreLabel.zPosition = 10
        
        addChild(scoreLabel)
        
    }
    
    
    
    func setupRetryButton(){
        let retryButton = SKLabelNode(fontNamed: "Verdana-bold")
        retryButton.text = "BESTSCORE!!"
        retryButton.horizontalAlignmentMode = .center
        retryButton.fontSize = 25
        retryButton.fontColor = SKColor.white
        retryButton.position =  CGPoint(x: self.size.width / 2 ,y: self.size.height * 3.4 / 8)
        
        retryButton.zPosition = 10
        retryButton.name = "retryButton"
        addChild(retryButton)
        
    }
    
    func setupBackgroung(){
        var background:SKSpriteNode!
        let backgroundTexture = SKTexture(imageNamed: "soccor_ground")
        backgroundTexture.filteringMode = .nearest
        background = SKSpriteNode(texture: backgroundTexture)
        background.size = CGSize(
            width:self.frame.size.height,
            height: self.frame.size.height
        )
        background.position = CGPoint(x:background.size.width/2, y:self.frame.size.height/2)
        background.zPosition = -10
        
        addChild(background)
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
    
    
    
    private func showShareSheet() {
        var shareText = ""
        if viewScore != 0{
            shareText =  "\(String(format:"%.3f",viewScore!))cm"
        }else{
            shareText = "OUT"
        }
        let shareURL = URL(string: "https://itunes.apple.com/jp/app/id1661255726?mt=8")!
        let activityVC = UIActivityViewController(activityItems: [shareText, shareURL], applicationActivities: nil)
        let currentViewContoroller: UIViewController = (self.view?.window!.rootViewController)!
        currentViewContoroller.present(activityVC, animated: true, completion: nil)
    }
    
    //    private func showShareSheet() {
    //        let shareText = "______________"
    //        let shareURL = URL(string: "__________")!
    //        let activityVC = UIActivityViewController(activityItems: [shareText, shareURL], applicationActivities: nil)
    //        let currentViewContoroller: UIViewController = (self.view?.window!.rootViewController)!
    //        currentViewContoroller.present(activityVC, animated: true, completion: nil)
    //    }
    
    
    
    
    
}



