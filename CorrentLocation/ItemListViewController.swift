//
//  ItemListViewController.swift
//  CorrentLocation
//
//  Created by Admin on 06/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ItemListViewController: UIViewController {
let locationManager = CLLocationManager()
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
       locationManager.startUpdatingLocation()
        locationManager.delegate = self
       
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.6, animations: {
            
            cell.alpha = 1
            
        })
    }
}
extension ItemListViewController :CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.first {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemark, error) in
                if error == nil {
                    let firstLocation = placemark?[0]
                    let totalAddress = "\(firstLocation?.name ?? "")," + "\(firstLocation?.locality ?? "")," + "\(firstLocation?.administrativeArea ?? "")"
                    self.addressLabel.text = totalAddress
                  
                }
                else {
                    print(error!)
                }
            }
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}
