//
//  MapsTestingViewController.swift
//  infoquesttrial
//
//  Created by rohit on 01/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Alamofire
import SwiftyJSON

class MapsTestingViewController: UIViewController,GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var back: UIBarButtonItem!
    var lat = CLLocationDegrees()
    var longi = CLLocationDegrees()
    
    let locationManager = CLLocationManager()
    
    let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=(srcLocation.coordinate.latitude),(srcLocation.coordinate.longitude)&destination=(destLocation.coordinate.latitude),(destLocation.coordinate.longitude)"
    override func viewDidLoad() {
        title = "MAPS"
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        back.target = self.revealViewController()
        back.action = Selector("revealToggle:")

        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 17.331382, longitude: 78.297474, zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.mapType = kGMSTypeHybrid
        mapView.delegate = self
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 17.331382, longitude: 78.297474)
        marker.title = "JBIET"
        marker.snippet = "Moinabad"
        marker.map = mapView
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 17.330222, longitude: 78.297701)
        marker1.title = "JBIET Main Block"
        marker1.snippet = "Moinabad"
        marker1.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 17.330406, longitude: 78.297228)
        marker2.title = "JBIET First Yr Block"
        marker2.snippet = "Moinabad"
        marker2.map = mapView
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 17.331039, longitude: 78.297505)
        marker3.title = "BasketBall Court"
        marker3.snippet = "Moinabad"
        marker3.map = mapView
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2D(latitude: 17.331188, longitude: 78.297355)
        marker4.title = "SAE-JBIET"
        marker4.snippet = "Moinabad"
        marker4.map = mapView
        
        let marker5 = GMSMarker()
        marker5.position = CLLocationCoordinate2D(latitude: 17.330632, longitude: 78.297685)
        marker5.title = "Coke Hub"
        marker5.snippet = "Moinabad"
        marker5.map = mapView
        
        let marker6 = GMSMarker()
        marker6.position = CLLocationCoordinate2D(latitude: 17.329808, longitude: 78.300068)
        marker6.title = "Cricket Ground"
        marker6.snippet = "Moinabad"
        marker6.map = mapView
        
        let marker7 = GMSMarker()
        marker7.position = CLLocationCoordinate2D(latitude: 17.331444, longitude: 78.297610)
        marker7.title = "Syndicate Bank"
        marker7.snippet = "Moinabad"
        marker7.map = mapView
        
        let marker8 = GMSMarker()
        marker8.position = CLLocationCoordinate2D(latitude: 17.330048, longitude: 78.297193)
        marker8.title = "Cafeteria"
        marker8.snippet = "Moinabad"
        marker8.map = mapView
        
        let marker9 = GMSMarker()
        marker9.position = CLLocationCoordinate2D(latitude: 17.331339, longitude: 78.297978)
        marker9.title = "Central Canteen"
        marker9.snippet = "Moinabad"
        marker9.map = mapView
        
        let marker10 = GMSMarker()
        marker10.position = CLLocationCoordinate2D(latitude: 17.330186, longitude: 78.297791)
        marker10.title = "MNR Auditorium 2nd Floor"
        marker10.snippet = "Moinabad"
        marker10.map = mapView
      //  mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 10.0
            locationManager.startUpdatingLocation()
        }
        
        
    }
   /* func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        lat = (mapView.myLocation?.coordinate.latitude)!
        longi = (mapView.myLocation?.coordinate.longitude)!
        
        return true
    } */
    

  /*  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    } */
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        lat = (manager.location?.coordinate.latitude)!
        longi = (manager.location?.coordinate.longitude)!
        
    }
   
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let alertController = UIAlertController(title: "", message: "Get directions from your location?", preferredStyle: .alert)
        let no2Action = UIAlertAction(title: "YES", style: .default) { (action) -> Void in
            
         /*   let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: self.lat, longitude: self.longi))
            marker.map = mapView */
            let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(self.lat),\(self.longi)&destination=\(marker.position.latitude),\(marker.position.longitude)"
            Alamofire.request(directionURL).responseJSON {
                
                response in
                switch response.result {
                    
                case .success(let data):
                    
                    let json = JSON(data)
                    
                    
                    let errornum = json["error"]
                    
                    
                    if (errornum == true){
                        
                        
                        
                    }else{
                        let routes = json["routes"].array
                        
                        if routes != nil{
                            
                            let overViewPolyLine = routes![0]["overview_polyline"]["points"].string!
                            // print(overViewPolyLine)
                            if overViewPolyLine != nil{
                                
                                
                                let path = GMSMutablePath(fromEncodedPath: overViewPolyLine)
                                let polyLine = GMSPolyline(path: path)
                                polyLine.strokeWidth = 5
                                polyLine.strokeColor = UIColor.yellow
                                polyLine.map = mapView
                                
                                var bounds = GMSCoordinateBounds()
                                
                                for index in 1...Int((path?.count())!) {
                                    bounds = bounds.includingCoordinate(path!.coordinate(at: UInt(index)))
                                }
                                
                                
                                mapView.animate(with: GMSCameraUpdate.fit(bounds))
                                
                            }
                            
                        }
                        
                        
                    }
                    
                case .failure(let error):
                    
                    print("Request failed with error: \(error)")
                    
                }
            }
            
        }
        let yes2Action = UIAlertAction(title: "NO", style: .default) { (action) -> Void in
            
        }
        alertController.addAction(no2Action)
        alertController.addAction(yes2Action)
        self.present(alertController, animated: true, completion: nil)
        
        
        return false
    }
    
    

}
