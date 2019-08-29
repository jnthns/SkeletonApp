//
//  rewardsViewController.swift
//  Skeleton App
//
//  Created by Jonathan Shek on 8/27/19.
//  Copyright © 2019 Jonathan Shek. All rights reserved.
//

import UIKit
import AppLovinSDK
import Leanplum

class rewardsViewController: rootViewController {
    
    @IBOutlet weak var rewardsLabel: UILabel!
    
    var interstitial: ALIncentivizedInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstitial = ALIncentivizedInterstitialAd(zoneIdentifier: "c2437ae94b7a0171")
    }
    
    @IBAction func showRewardedVideo(_ sender: Any) {
        if interstitial.isReadyForDisplay
        {
            interstitial.adDisplayDelegate = self
            interstitial.adVideoPlaybackDelegate = self
            
            interstitial.showAndNotify(self)
            
            Leanplum.track("Rewards Video", withParameters: ["Zone":"Elite"])
        }
        else
        {
            preloadRewardedVideo()
        }
    }
    
    
    @IBAction func preloadRewardedVideo() {
        log("Loading Ad")
        interstitial.preloadAndNotify(self)
        
        Leanplum.track("Preloaded Ad", withParameters: ["Zone":"Elite"])
    }
    
}

extension rewardsViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        log("Rewarded Ad Loaded")
        self.ad = ad
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        log("Ad failed to load with error \(code)")
    }
}

extension rewardsViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        log("Rewarded Ad displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        log("Rewards Ad dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        log("Rewards Ad was pressed")
    }
}

extension rewardsViewController : ALAdRewardDelegate
{
    func rewardValidationRequest(for ad: ALAd, didSucceedWithResponse response: [AnyHashable : Any]) {
        log("Response was succesful with code \(response)")
        
        if let amount = response["amount"] as? NSString, let coins = response["currency"] as? NSString
        {
            log("Rewarded \(amount.floatValue) \(coins)")
        }
    }
    
    func rewardValidationRequest(for ad: ALAd, didExceedQuotaWithResponse response: [AnyHashable : Any]) {
        log("Request exceeded daily quota with response \(response)")
    }
    
    func rewardValidationRequest(for ad: ALAd, wasRejectedWithResponse response: [AnyHashable : Any]) {
        log("Request was rejected with response \(response)")
    }
    
    func rewardValidationRequest(for ad: ALAd, didFailWithError responseCode: Int) {
        if responseCode == kALErrorCodeIncentivizedUserClosedVideo {
            log("User closed video prematurely - no reward was given")
        } else if responseCode == kALErrorCodeIncentivizedValidationNetworkTimeout || responseCode == kALErrorCodeIncentivizedUnknownServerError {
            log("Request not fulfilled - try again")
        } else if responseCode == kALErrorCodeIncentiviziedAdNotPreloaded {
            log("Rewards Ad was not preloaded - try again")
        }
        
        log("Request failed with error code \(responseCode)")
    }
}

extension rewardsViewController : ALAdVideoPlaybackDelegate
{
    func videoPlaybackBegan(in ad: ALAd) {
        log("Video started")
    }
    
    func videoPlaybackEnded(in ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool) {
        log("Video ended")
    }
    

}
