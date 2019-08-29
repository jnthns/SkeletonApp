//
//  interstitialViewController.swift
//  Skeleton App
//
//  Created by Jonathan Shek on 8/27/19.
//  Copyright © 2019 Jonathan Shek. All rights reserved.
//

import UIKit
import AppLovinSDK
import Leanplum

class interstitialViewController: rootViewController {

    @IBOutlet weak var interstitialLabel: UILabel!
    
    let interstitial = ALInterstitialAd.shared()
    
    @IBAction func loadInterstitialAd(_ sender: Any) {
        ALSdk.shared()?.adService.loadNextAd(forZoneIdentifier: "cc89ec865881d46d", andNotify: self)
        
        Leanplum.track("Interstitial Loaded", withParameters: ["Zone":"Middle"])
    }
    
    @IBAction func showInterstitialAd(_ sender: Any) {
        interstitial.show()
        
        Leanplum.track("Interstitial Shown", withParameters: ["Zone":"Middle"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial.adLoadDelegate = self
        interstitial.adDisplayDelegate = self
    }
    
}

extension interstitialViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        log("Interstitial loaded")
        self.ad = ad
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        log("Interstitial failed to load")
    }
}

extension interstitialViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        log("Interstital was displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        log("Interstitial was dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        log("Interstitial was pressed")
    }
    
    
}
