//
//  ViewController.swift
//  note-map
//
//  Created by İbrahim Halil Kalkan on 24.05.2025.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        
        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            let anotation = MKPointAnnotation()
            anotation.coordinate = touchedCoordinates
            
            anotation.title = "Map_Note"
            anotation.subtitle = "Note"
            self.mapView.addAnnotation(anotation)
            
            
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }

}

