//
//  GameViewController.swift
//  FootballGame
//
//  Created by Nishio Naoki on 2022/12/22.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds



class GameViewController: UIViewController, GADBannerViewDelegate {

    var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        let scene = TitleScene(size:skView.frame.size)
        skView.presentScene(scene)
//        showAd()
        let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))

        bannerView = GADBannerView(adSize: adSize)

        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-8979621487536159/7168035853"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(interruption), name: Notification.Name(rawValue:"MyNotification"), object: nil)

        
    }
    
    @objc func interruption(){
          print("interruption")
          let skView = self.view as! SKView
          print(skView.scene!.name ?? "")
          if skView.scene!.name == "GameScene"{
              let scene = TitleScene(size:skView.frame.size)
              skView.presentScene(scene)
          }
      }
    
    
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func showAd() {
        let banner:GADBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.delegate = self
        banner.rootViewController = self
        banner.frame = CGRect(x:((self.view.bounds.width-320)/2),y:(self.view.bounds.height-70),width:320,height:70)

        let gadRequest:GADRequest = GADRequest()
        banner.load(gadRequest)
        self.view.addSubview(banner)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
      view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: bottomLayoutGuide,
                            attribute: .top,
                            multiplier: 1,
                            constant: 0),
         NSLayoutConstraint(item: bannerView,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0)
        ])
     }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
      print("----------------------")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        print("----------------------")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
        print("----------------------")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
        print("----------------------")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
        print("----------------------")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
        print("----------------------")
    }
    
  
}
