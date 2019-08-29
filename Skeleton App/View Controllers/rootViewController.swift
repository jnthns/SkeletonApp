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
let sdk = ALSdk.shared()

class rootViewController: UIViewController {

    var ad: ALAd?
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func banner(_ sender: Any) {
        Leanplum.advance(to: "Banner Screen")
    }
    
    @IBAction func eliteRewards(_ sender: Any) {
        Leanplum.advance(to: "Elite Rewards Screen")
    }
    
    @IBAction func middleInterstitial(_ sender: Any) {
        Leanplum.advance(to: "Middle Interstitial Screen")
    }
    
    @IBAction func bottomInterstitial(_ sender: Any) {
        Leanplum.advance(to: "Bottom Interstitial Screen")
    }
    
    @IBAction func topRewards(_ sender: Any) {
        Leanplum.advance(to: "Top Rewards Screen")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func log(_ message: String)
    {
        DispatchQueue.main.async {
            if let label = self.statusLabel {
                label.text = message
            }
        }
    }
    
    @IBAction func unwindTorootViewController(_ unwindSegue: UIStoryboardSegue) {
    }

}
