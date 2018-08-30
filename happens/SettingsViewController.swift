//
//  SettingsViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 5/28/15.
//  Copyright (c) 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SettingsViewController: UIViewController, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Default Discovery Mile
        searchLimit.value = Float(NSUserDefaults.standardUserDefaults().integerForKey("discoveryDistance"))
        searchLimitLabel.text = String(NSUserDefaults.standardUserDefaults().integerForKey("discoveryDistance"))
        
        //Default Discovery Sort
        if NSUserDefaults.standardUserDefaults().objectForKey("sortBy") as! String == "latest" {
            latestSwitch.on = true
        } else {
            latestSwitch.on = false
        }
        
        //Location
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSUserDefaults.standardUserDefaults().setInteger(Int(searchLimitLabel.text!)!, forKey: "discoveryDistance")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*****************************************************************
    * DISCOVERY MILE
    *****************************************************************/
    @IBOutlet weak var searchLimit: UISlider!
    @IBOutlet weak var searchLimitLabel: UILabel!
    
    //Discovery Mile Slider
    @IBAction func searchLimit(sender: UISlider) {
        self.searchLimitLabel.text = "\(Int(sender.value))"
    }
    
    /*****************************************************************
    * FEED SORT BY
    *****************************************************************/
    @IBOutlet var latestSwitch: UISwitch!
    @IBAction func latest(sender: AnyObject) {
        if latestSwitch.on {
            NSUserDefaults.standardUserDefaults().setObject("latest", forKey: "sortBy")
            
        } else {
             NSUserDefaults.standardUserDefaults().setObject("distance", forKey: "sortBy")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /*****************************************************************
    * LOCATION
    *****************************************************************/
    @IBOutlet weak var MapView: MKMapView!
    var manager: CLLocationManager?
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let location = locations[0] as CLLocation
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {
            (data, error) -> Void in
            self.MapView.centerCoordinate = location.coordinate
            let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 4500, 4500)
            self.MapView.setRegion(reg, animated: false)
            self.MapView.showsUserLocation = true
        })
    }
    
}