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

protocol coinDelegate
{
    func displayCoins(coins: String)
}

class bannerViewController: rootViewController {
    
    @IBOutlet weak var bannerLabel: UILabel!
    @IBOutlet weak var bannerCoins: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var coinCount = 0
    
    var delegate: coinDelegate?
    
    let adView = ALAdView(size: .sizeBanner())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        adView.adEventDelegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        
        statusLabel.addBackground()
        button?.addButtonTheme()
    }
    
    @IBAction func showBanner(_ sender: Any) {
        adView.loadNextAd()
        self.view.addSubview(adView)
        
        delegate?.displayCoins(coins: String(coinAmount))
        
        count += 1;
        Leanplum.track("Show Banner", withParameters: ["Banners":count])
    }
    
}

extension bannerViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        updateStatus("Banner loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        updateStatus("Banner failed to load with error \(code)")
    }
    
}

extension bannerViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView) {
        updateStatus("Banner displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView) {
        updateStatus("Banner dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView) {
        updateStatus("Banner pressed")
    }
}

extension bannerViewController : ALAdViewEventDelegate
{
    func ad(_ ad: ALAd, didPresentFullscreenFor adView: ALAdView)
    {
        updateStatus("Banner did present fullscreen")
    }
    
    func ad(_ ad: ALAd, willDismissFullscreenFor adView: ALAdView)
    {
        updateStatus("Banner will dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, didDismissFullscreenFor adView: ALAdView)
    {
        updateStatus("Banner did dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, willLeaveApplicationFor adView: ALAdView)
    {
        updateStatus("Banner will leave application")
    }
    
    func ad(_ ad: ALAd, didReturnToApplicationFor adView: ALAdView)
    {
        updateStatus("Banner returned to application")
    }
    
    func ad(_ ad: ALAd, didFailToDisplayIn adView: ALAdView, withError code: ALAdViewDisplayErrorCode)
    {
        updateStatus("Banner failed to display with error code: \(code)")
    }
}


