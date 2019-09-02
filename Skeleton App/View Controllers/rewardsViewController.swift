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
    
    @IBOutlet weak var ERLabel: UILabel!
    @IBOutlet weak var ERCoins: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var coinCount = 0
    var delegate: coinDelegate?
    
    var interstitial: ALIncentivizedInterstitialAd!
    
    @IBAction func showRewardedVideo(_ sender: Any) {
        if interstitial.isReadyForDisplay
        {
            interstitial.showAndNotify(self)
            
            updateCoins(10)
            delegate?.displayCoins(coins: String(coinAmount))
            
            count += 1;
            Leanplum.track("Elite Rewards Video", withParameters: ["ER Shown":count])
        }
        else
        {
            preloadRewardedVideo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstitial = ALIncentivizedInterstitialAd(zoneIdentifier: "c2437ae94b7a0171")
        
        interstitial.adDisplayDelegate = self
        interstitial.adVideoPlaybackDelegate = self
        
        statusLabel.addBackground()
        button?.addButtonTheme()
    }
    
    func preloadRewardedVideo() {
        updateStatus("Loading Ad")
        interstitial.preloadAndNotify(self)
    }
    
}

// MARK: Extensions

extension rewardsViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        updateStatus("Press again if you want to earn coins!")
        self.ad = ad
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        updateStatus("Ad failed to load with error \(code)")
    }
}

extension rewardsViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        updateStatus("Rewards Ad displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        Leanplum.track("Rewards Dismissed")
        updateStatus("Rewards Ad dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        updateStatus("Rewards Ad was pressed")
    }
}

extension rewardsViewController : ALAdRewardDelegate
{
    func rewardValidationRequest(for ad: ALAd, didSucceedWithResponse response: [AnyHashable : Any]) {
        updateStatus("Response was succesful with code \(response)")
        
        if let amount = response["amount"] as? NSString, let coins = response["currency"] as? NSString
        {
            updateStatus("Rewarded \(amount.floatValue) \(coins)")
        }
    }
    
    func rewardValidationRequest(for ad: ALAd, didExceedQuotaWithResponse response: [AnyHashable : Any]) {
        updateStatus("Request exceeded daily quota with response \(response)")
    }
    
    func rewardValidationRequest(for ad: ALAd, wasRejectedWithResponse response: [AnyHashable : Any]) {
        updateStatus("Request was rejected with response \(response)")
    }
    
    func rewardValidationRequest(for ad: ALAd, didFailWithError responseCode: Int) {
        if responseCode == kALErrorCodeIncentivizedUserClosedVideo {
            updateStatus("User closed video prematurely - no reward was given")
        } else if responseCode == kALErrorCodeIncentivizedValidationNetworkTimeout || responseCode == kALErrorCodeIncentivizedUnknownServerError {
            updateStatus("Request not fulfilled - try again")
        } else if responseCode == kALErrorCodeIncentiviziedAdNotPreloaded {
            updateStatus("Rewards Ad was not preloaded - try again")
        }
        
        updateStatus("Request failed with error code \(responseCode)")
    }
}

extension rewardsViewController : ALAdVideoPlaybackDelegate
{
    func videoPlaybackBegan(in ad: ALAd) {
        updateStatus("Video started")
    }
    
    func videoPlaybackEnded(in ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool) {
        updateStatus("Video ended")
    }
    

}
