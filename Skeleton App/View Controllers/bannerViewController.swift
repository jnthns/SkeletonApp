//
//  bannerViewController.swift
//  Skeleton App
//
//  Created by Jonathan Shek on 8/26/19.
//  Copyright © 2019 Jonathan Shek. All rights reserved.
//

import UIKit
import Leanplum
import AppLovinSDK

class bannerViewController: rootViewController {
    
    @IBOutlet weak var bannerLabel: UILabel!
    
    let adView = ALAdView(size: .sizeBanner())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        adView.adEventDelegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func showBanner(_ sender: Any) {
        adView.loadNextAd()
        self.view.addSubview(adView)
        
        Leanplum.track("Show Banner", withValue:1)
    }
    
}

extension bannerViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        log("Banner loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        log("Banner failed to load with error \(code)")
    }
    
}

extension bannerViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        log("Banner displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        log("Banner dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        log("Banner pressed")
    }
}

extension bannerViewController : ALAdViewEventDelegate
{
    func ad(_ ad: ALAd, didPresentFullscreenFor adView: ALAdView)
    {
        log("Banner did present fullscreen")
    }
    
    func ad(_ ad: ALAd, willDismissFullscreenFor adView: ALAdView)
    {
        log("Banner will dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, didDismissFullscreenFor adView: ALAdView)
    {
        log("Banner did dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, willLeaveApplicationFor adView: ALAdView)
    {
        log("Banner will leave application")
    }
    
    func ad(_ ad: ALAd, didReturnToApplicationFor adView: ALAdView)
    {
        log("Banner returned to application")
    }
    
    func ad(_ ad: ALAd, didFailToDisplayIn adView: ALAdView, withError code: ALAdViewDisplayErrorCode)
    {
        log("Banner failed to display with error code: \(code)")
    }
}
