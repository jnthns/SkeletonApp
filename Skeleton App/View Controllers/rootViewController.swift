//
//  rootViewController.swift
//  Skeleton App
//
//  Created by Jonathan Shek on 8/26/19.
//  Copyright © 2019 Jonathan Shek. All rights reserved.
//

import UIKit
import AppLovinSDK
import Leanplum

var count = 0
var coinAmount = 0;

let sdk = ALSdk.shared()

class rootViewController: UIViewController, coinDelegate {
    
    var ad: ALAd?

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    
    @IBOutlet weak var bannerButton: UIButton!
    @IBOutlet weak var eliteButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    @IBAction func banner(_ sender: Any) {
        Leanplum.advance(to: "Banner Screen")
    }
    
    @IBAction func eliteRewards(_ sender: Any) {
        Leanplum.advance(to: "Elite Rewards Screen")
    }
    
    @IBAction func topRewards(_ sender: Any) {
        Leanplum.advance(to: "Top Rewards Screen")
    }
    
    @IBAction func middleInterstitial(_ sender: Any) {
        Leanplum.advance(to: "Middle Interstitial Screen")
    }
    
    @IBAction func bottomInterstitial(_ sender: Any) {
        Leanplum.advance(to: "Bottom Interstitial Screen")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerButton?.addButtonTheme()
        eliteButton?.addButtonTheme()
        topButton?.addButtonTheme()
        middleButton?.addButtonTheme()
        bottomButton?.addButtonTheme()
        
        self.setBackgroundImage("lightbulb.png", contentMode: .scaleAspectFit)
        
        displayCoins(coins: String(coinAmount))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bannerScreen" {
            let bannerVC = segue.destination as! bannerViewController
            
            bannerVC.coinCount = coinAmount
            
            bannerVC.delegate = self
            
        } else if segue.identifier == "eliteRewardsScreen" {
            let erVC = segue.destination as! rewardsViewController
            
            erVC.coinCount = coinAmount
            
            erVC.delegate = self
            
        } else if segue.identifier == "topRewardsScreen" {
            let trVC = segue.destination as! topRewardsViewController
            
            trVC.coinCount = coinAmount
            
            trVC.delegate = self
        }
    }
    
    
    func updateStatus(_ status: String)
    {
        DispatchQueue.main.async {
            self.statusLabel.text = status
        }
    }
    
    func updateCoins(_ coins: Int)
    {
        coinAmount += coins;
        self.coinsLabel.text = String(coinAmount)
    }
    
    func displayCoins(coins: String) {
        self.coinsLabel.text = String(coinAmount)
    }
    
    @IBAction func unwindTorootViewController(_ unwindSegue: UIStoryboardSegue) {
    }
    
}

extension UIButton {
    func addButtonTheme() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
    }
}

extension UILabel {
    func addBackground() {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 15
    }
}

extension UIViewController {
    func setBackgroundImage(_ imageName: String, contentMode: UIView.ContentMode) {
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "lightbulb.png")
        backgroundImage.contentMode = .scaleAspectFit
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}



