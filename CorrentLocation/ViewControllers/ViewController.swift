//
//  ViewController.swift
//  CorrentLocation
//
//  Created by Admin on 27/09/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch: class {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class ViewController: UIViewController {
    var selectedPin :MKPlacemark? = nil
    var resultSearchController: UISearchController!
     let currentLocationMarker = MKPointAnnotation()
    var latLongs = [Any]()
    @IBOutlet weak var mapView: MKMapView!
     let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsScale = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        mapView.showsPointsOfInterest = true
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "SearchTableView") as! SearchTableView
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self as HandleMapSearch
        navigationItem.titleView?.isHidden = true
    }
    
    @objc func getDirections(){
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    @IBAction func getCurrentLocation(_ sender: Any) {
        mapView.setCenter((locationManager.location?.coordinate)!, animated: true)
    }
    
    @IBAction func locationSeachBtnAction(_ sender: Any) {
        navigationItem.titleView?.isHidden = false
        UserDefaults.standard.set("true", forKey: "location")
        UserDefaults.standard.synchronize()
    }
    @IBAction func placesSeachBtnAction(_ sender: Any) {
        navigationItem.titleView?.isHidden = false
        UserDefaults.standard.removeObject(forKey: "location")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func getDirectionBtnAction(_ sender: Any) {}
}

extension ViewController : CLLocationManagerDelegate {
    
func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
           latLongs.append(location.coordinate)
           let geocoder = CLGeocoder()
            currentLocationMarker.coordinate = location.coordinate
            geocoder.reverseGeocodeLocation(location) { (placemark, error) in
                if error == nil {
                    let firstLocation = placemark?[0]
                    self.currentLocationMarker.title = firstLocation?.subLocality
                }
                else {
                    // An error occurred during geocoding.
                    print(error!)
                }
            }
            //mapView .addAnnotation(currentLocationMarker)
        }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error)")
    }
    
func drawingPathBetweenRoots(sourceLocation:CLLocationCoordinate2D,destinationLocation:CLLocationCoordinate2D){
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destItem = MKMapItem(placemark: destinationPlaceMark)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .any
        let directions = MKDirections(request: directionRequest)
       directions.calculate(completionHandler: {response , error in
        guard let response = response else{
            if let error = error {
                print("we have error getting directions==\(error.localizedDescription)")
            }
          return
        }
        let route = response.routes[0]
        self.mapView.add(route.polyline, level: .aboveRoads)
        let  rekt = route.polyline.boundingMapRect
        self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
    } )
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.blue
       render.lineWidth = 3.0
     return render
        
    }
}
extension ViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        if ((UserDefaults.standard.object(forKey: "location")) != nil) {
            mapView.addAnnotation(annotation)
        }
        else{}
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}
extension ViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard !(annotation is MKUserLocation) else { return nil }
         let reuseId = "pin"
        let pinView  = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView.pinTintColor = UIColor.orange
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: .normal)
        button.addTarget(self, action: #selector(ViewController.getDirections), for: .touchUpInside)
        pinView.leftCalloutAccessoryView = button
        latLongs.append(annotation.coordinate)
        return pinView
    }
    
}


