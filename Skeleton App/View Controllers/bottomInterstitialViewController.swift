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
    @IBOutlet weak var BICoins: UILabel!
    
    @IBOutlet weak var biButton: UIButton!
    @IBOutlet weak var bsButton: UIButton!
    
    @IBAction func loadInterstitial(_ sender: Any) {
        sdk?.adService.loadNextAd(forZoneIdentifier: "d15c83757f7581ef", andNotify: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        ALInterstitialAd.shared().adLoadDelegate = self
        ALInterstitialAd.shared().adDisplayDelegate = self
        
        biButton?.addButtonTheme()
        bsButton?.addButtonTheme()
    }
    
    @IBAction func showInterstitial(_ sender: Any) {
        ALInterstitialAd.shared().show()
        
        count += 1;
        Leanplum.track("Bottom Interstitial Shown", withParameters: ["BI Shown":count])
    }

}

