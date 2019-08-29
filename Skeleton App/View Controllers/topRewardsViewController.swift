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
    
    @IBOutlet weak var TRLabel: UILabel!
    
    var topRewards: ALIncentivizedInterstitialAd!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRewards = ALIncentivizedInterstitialAd(zoneIdentifier: "aa023fd299027c29")
        
        topRewards.adDisplayDelegate = self
        topRewards.adVideoPlaybackDelegate = self
    }
    
    @IBAction func showVideo(_ sender: Any) {
        if topRewards.isReadyForDisplay
        {
            topRewards.showAndNotify(self)
            Leanplum.track("Rewards Video", withParameters: ["Zone":"Top"])
        }
        else
        {
            preloadRewardedVideo()
        }
    }
    
    @IBAction func preloadVideo() {
        topRewards.preloadAndNotify(self)
        Leanplum.track("Preloaded Ad", withParameters: ["Zone":"Top"])
    }
}

