//
//  ViewController.swift
//  LaunchDarkly_Demo
//
//  Created by Tony Sandoval on 3/17/21.
//

import UIKit
import LaunchDarkly

fileprivate let featureFlagKey = "purchase-button"
var strAlertMessage: String = "Sorry but unfortunately, our online store is temporarily offline.  If you would, please try again at a later time or call for support."


class ViewController: UIViewController {
    
    @IBOutlet weak var purchase_button: UIButton!
    
    @IBAction func btnBuy(_ sender: Any) {
        let alert = UIAlertController(title: "DING DING!", message: strAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    fileprivate func checkFeatureValue() {
        if((LDClient.get()?.isOnline) != nil){
            let featureFlagValue = LDClient.get()!.variation(forKey: featureFlagKey, defaultValue: false)
            updateBuyButton(value: featureFlagValue)
        }else{
            print("LDC Not Online")
            strAlertMessage = "Sorry but unfortunately, our online store is temporarily offline.  If you would, please try again at a later time or call for support."
        }
    }
    
    fileprivate func updateBuyButton(value: Bool) {
        print(value)
        if(value==true){
            strAlertMessage = "Congratulations!  You've added this to your cart."
            purchase_button.setTitle("ADD TO CART", for: UIControl.State.normal)
        }else{
            strAlertMessage = "Sorry but unfortunately, our online store is temporarily offline.  If you would, please try again at a later time or call for support."
            purchase_button.setTitle("STORE OFFLINE", for: UIControl.State.normal)
        }
    }
    
    func featureFlagDidUpdate(_ key: LDFlagKey) {
        if key == featureFlagKey {
            print("Feature Flag Updated")
            checkFeatureValue()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        LDClient.get()?.observe(key: featureFlagKey, owner: self) { [weak self] changedFlag in
            self?.featureFlagDidUpdate(changedFlag.key)
        }
        checkFeatureValue()
    }
    

}

