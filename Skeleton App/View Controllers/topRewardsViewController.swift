//
//  topRewardsViewController.swift
//  Skeleton App
//
//  Created by Jonathan Shek on 8/27/19.
//  Copyright © 2019 Jonathan Shek. All rights reserved.
//

import UIKit
import AppLovinSDK
import Leanplum

class topRewardsViewController: rewardsViewController {
    
    var topRewards: ALIncentivizedInterstitialAd!
        
    @IBOutlet weak var TRLabel: UILabel!
    @IBOutlet weak var TRCoins: UILabel!
    @IBOutlet weak var TRButton: UIButton!
    
    @IBAction func showVideo(_ sender: Any) {
        if topRewards.isReadyForDisplay
        {
            topRewards.showAndNotify(self)
            
            updateCoins(5)
            delegate?.displayCoins(coins: String(coinAmount))
            
            count += 1;
            Leanplum.track("Top Rewards Video", withParameters: ["TR Shown":count])
        }
        else
        {
            preloadVideo()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRewards = ALIncentivizedInterstitialAd(zoneIdentifier: "aa023fd299027c29")
        
        topRewards.adDisplayDelegate = self
        topRewards.adVideoPlaybackDelegate = self
    
        statusLabel.addBackground()
        coinsLabel.text = String(coinAmount)
        TRButton?.addButtonTheme()
    }
    
    func preloadVideo() {
        topRewards.preloadAndNotify(self)
    }
}

