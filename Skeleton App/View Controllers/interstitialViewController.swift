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
    @IBOutlet weak var MICoins: UILabel!
    
    @IBOutlet weak var ibutton: UIButton!
    @IBOutlet weak var sbutton: UIButton!
    
    let interstitial = ALInterstitialAd.shared()
    
    @IBAction func loadInterstitialAd(_ sender: Any) {
        ALSdk.shared()?.adService.loadNextAd(forZoneIdentifier: "cc89ec865881d46d", andNotify: self)
    }
    
    @IBAction func showInterstitialAd(_ sender: Any) {
        interstitial.show()
        
        count += 1;
        Leanplum.track("Middle Interstitial Shown", withParameters: ["MI Shown":count])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial.adLoadDelegate = self
        interstitial.adDisplayDelegate = self
        
        statusLabel.addBackground()
        ibutton?.addButtonTheme()
        sbutton?.addButtonTheme()
    }
    
}

extension interstitialViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        updateStatus("Interstitial loaded")
        self.ad = ad
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        updateStatus("Interstitial failed to load")
    }
}

extension interstitialViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        updateStatus("Interstital was displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        updateStatus("Interstitial was dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        updateStatus("Interstitial was pressed")
    }
    
    
}
