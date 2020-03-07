//
//  CreateSessionViewController.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/5/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import Parse
import MapKit

class CreateSessionViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        // set intitial location
        mapView.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.setInitialLocation()
            self.showCircle(coordinate: self.locationManager.location!.coordinate, radius: 1000);
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor =  UIColor.init(red: 0.0, green: 0, blue: 1, alpha: 0.5)
            return circleRenderer
        }
        else {
           return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: coordinate, radius: radius)
        mapView.addOverlay(circle)
    }
    
    func setInitialLocation() {
        // UCI latitude and longitude
        let mapCenter = locationManager.location!.coordinate
        
        // create the span of the map - radius
        // Note: One degree of latitude is approx 111km (69 miles)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta:  0.1)
        
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func startSession(_ sender: Any) {
        VotingSession.createSession { (success, error) in
            if success {
                self.performSegue(withIdentifier: "sessionHostSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription ?? "bad news")")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
