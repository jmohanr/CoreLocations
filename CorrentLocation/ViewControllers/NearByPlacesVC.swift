//
//  NearByPlacesVC.swift
//  CorrentLocation
//
//  Created by Admin on 03/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import MapKit

class NearByPlacesVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
    @IBOutlet weak var detailedMapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restaurantsBtn: UIButton!
    @IBOutlet weak var loungeBarBtn: UIButton!
    @IBOutlet weak var coffeeBtn: UIButton!
    @IBOutlet weak var scrollingView:UIView!
    var latLongArray = [Any]()

    @IBAction func restaurantsBtnPrsd(_ sender: Any) {
         restaurantsBtn.setTitleColor(UIColor.orange, for: .normal)
        loungeBarBtn.setTitleColor(UIColor.black, for: .normal)
        coffeeBtn.setTitleColor(UIColor.black, for: .normal)
        restaurantsBtn.tag = 1
        coffeeBtn.tag = 0
        loungeBarBtn.tag = 0
        detailedMapView.removeAnnotations(self.detailedMapView.annotations)
        fetchLocalData(category: "Restaurants")
    
    }
   
    @IBAction func loungeBarBtnPrsd(_ sender: Any) {
         loungeBarBtn.setTitleColor(UIColor.orange, for: .normal)
        coffeeBtn.setTitleColor(UIColor.black, for: .normal)
        restaurantsBtn.setTitleColor(UIColor.black, for: .normal)
        restaurantsBtn.tag = 0
        coffeeBtn.tag = 0
        loungeBarBtn.tag = 1
        detailedMapView.removeAnnotations(self.detailedMapView.annotations)
        fetchLocalData(category: "Park")
        
    }

    @IBAction func coffeeBtnPrsd(_ sender: Any) {
         coffeeBtn.setTitleColor(UIColor.orange, for: .normal)
        restaurantsBtn.setTitleColor(UIColor.black, for: .normal)
        loungeBarBtn.setTitleColor(UIColor.black, for: .normal)
        restaurantsBtn.tag = 0
        coffeeBtn.tag = 1
        loungeBarBtn.tag = 0
        detailedMapView.removeAnnotations(self.detailedMapView.annotations)
        fetchLocalData(category: "Coffee")
        
    }
    
    var mapData: MKMapItem!
    var selectedPin:MKPlacemark? = nil
    var responseResult : [MKMapItem]! = nil
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        scrollingView.isUserInteractionEnabled = true
        gesture.delegate = self
       scrollingView.addGestureRecognizer(gesture)
        
        restaurantsBtn.setTitleColor(UIColor.orange, for: .normal)
        detailedMapView.delegate = self
        detailedMapView.userTrackingMode = MKUserTrackingMode.follow
        detailedMapView.showsUserLocation = true
        let customPlacemark = mapData.placemark
        dropPinZoomIn(placemark: customPlacemark)
        fetchLocalData(category: "Restaurants")
        restaurantsBtn.tag = 1
        coffeeBtn.tag = 0
        loungeBarBtn.tag = 0
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(NearbyCell.self, forCellReuseIdentifier: "NearbyCell")
   
    }
    
    //creates a custom MKLocalSearchRequest and gets MKLocalSearchResponse
    func fetchLocalData(category: String) {
        if self.latLongArray.count > 0 {
             self.latLongArray.removeAll()
        }
        let request = MKLocalSearchRequest()
        //let span = MKCoordinateSpanMake(50000.0, 50000.0)
          request.naturalLanguageQuery = category
        request.region = MKCoordinateRegionMakeWithDistance((selectedPin?.coordinate)!,
                                                            120701, 120701);
      
        //request.region = MKCoordinateRegionMake((selectedPin?.coordinate)!, span)
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("There was an error searching for: \(String(describing: request.naturalLanguageQuery)) error: \(String(describing: error))")
                return
            }
            self.responseResult = response.mapItems
            self.latLongArray = self.responseResult
            self.addingMarkersOnMap(dataArray: self.latLongArray)
            self.tableView.reloadData()
        }
        return
    }
    
    //itterate the data inside the tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "NearbyCell")!
        tableCell.textLabel?.numberOfLines = 0
        tableCell.textLabel?.lineBreakMode = .byWordWrapping
        tableCell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        let eachResponse = responseResult[indexPath.row]
        latLongArray.append(eachResponse.placemark.coordinate)
        var customAddress:String? = ""
        if((eachResponse.name) != nil){
            customAddress = customAddress! + eachResponse.name!
        }
        if(eachResponse.phoneNumber != nil){
            customAddress = customAddress! + "\n" + "\(eachResponse.phoneNumber!)"
        }
        if(eachResponse.url != nil){
            customAddress = customAddress! + "\n" + "\(eachResponse.url!)"
        }
        tableCell.textLabel?.text = customAddress
        return tableCell
    }
    
    //returns number of rows for the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(self.responseResult != nil){
            return self.responseResult!.count
        } else {
            return 0
        }
    }
    
    
    func addingMarkersOnMap(dataArray:[Any]) {
        print(dataArray.count)
        for i in 0..<dataArray.count {
            let object = dataArray[i]
            let placeMarker = MKPointAnnotation()
            placeMarker.coordinate = (object as AnyObject).placemark.coordinate
            placeMarker.title = (object as AnyObject).placemark.name!
            detailedMapView.addAnnotation(placeMarker)
        }
    }
   @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
            let translation = gestureRecognizer.translation(in: self.view)
            print(gestureRecognizer.view!.center.y)
            if(gestureRecognizer.view!.center.y < 555) {
        
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            }else {
            
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 500)
            }
            
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "demo")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "demo")
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        if restaurantsBtn.tag == 1 {
             annotationView!.image = UIImage(named: "hotel")
        }
        else if coffeeBtn.tag == 1 {
            annotationView!.image = UIImage(named: "coffee")
        }
        else if loungeBarBtn.tag == 1 {
            annotationView!.image = UIImage(named: "grass")
        }
        return annotationView
       
    }
    
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

//Drops Cutsom Pin Annotation In the mapView
extension NearByPlacesVC: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        selectedPin = placemark
        detailedMapView.removeAnnotations(detailedMapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        detailedMapView.setRegion(region, animated: true)
        
    }
}
