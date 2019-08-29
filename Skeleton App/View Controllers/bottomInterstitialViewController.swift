//
//  bottomInterstitialViewController.swift
//  Skeleton App
//
//  Created by Jonathan Shek on 8/27/19.
//  Copyright © 2019 Jonathan Shek. All rights reserved.
//

import UIKit
import AppLovinSDK
import Leanplum

class bottomInterstitialViewController: interstitialViewController {
    
    @IBOutlet weak var BILabel: UILabel!
    
    @IBAction func loadInterstitial(_ sender: Any) {
        sdk?.adService.loadNextAd(forZoneIdentifier: "d15c83757f7581ef", andNotify: self)
        
        Leanplum.track("Interstitial Loaded", withParameters: ["Zone":"Bottom"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        ALInterstitialAd.shared().adLoadDelegate = self
        ALInterstitialAd.shared().adDisplayDelegate = self
    }
    
    @IBAction func showInterstitial(_ sender: Any) {
        ALInterstitialAd.shared().show()
        
        Leanplum.track("Interstitial Shown", withParameters: ["Zone":"Bottom"])
    }

}

