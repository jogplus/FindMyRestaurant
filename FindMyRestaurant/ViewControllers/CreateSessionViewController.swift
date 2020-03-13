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

class CreateSessionViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var createSessionButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var priceSegment: UISegmentedControl!
    
    var radiusCircle: MKOverlay!
//    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    var locationManager = CLLocationManager()
    
    var locationStatus: CLAuthorizationStatus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSessionButton.isHidden = true
        priceSegment.isHidden = true
        overlayView.layer.cornerRadius = 20
        overlayView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively

        
        // set intitial location
        mapView.delegate = self
        locationManager.delegate = self
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isHidden = false
        
        self.mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.setInitialLocation()
            }
        case .denied:
            print("I'm sorry - I can't show location. User has not authorized it")
        case .restricted:
            print("Access denied - likely parental controls are restricting use in this app.")
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways {
            showCircle()
            instructionLabel.text = "Setup the search radius and price range:"
            loadingView.isHidden = true
            createSessionButton.isHidden = false
            priceSegment.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.20)
            return circleRenderer
        }
        else {
           return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    func topCenterCoordinate() -> CLLocationCoordinate2D {
        return self.mapView.convert(CGPoint(x: self.mapView.frame.size.width / 2.0, y: 0), toCoordinateFrom: self.mapView)
    }

    func currentRadius() -> Double {
        let centerLocation = CLLocation(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude)
        
        let topCenterCoordinate = self.topCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        
        VotingSession.location = centerLocation
        let radius = centerLocation.distance(from: topCenterLocation)
        
        VotingSession.radius = radius / 2.75
        return radius
    }
    
    func showCircle() {
        if radiusCircle != nil {
            mapView.removeOverlay(radiusCircle)
        }
        radiusCircle = MKCircle(center: self.locationManager.location!.coordinate, radius: currentRadius() / 2.75)
        mapView.addOverlay(radiusCircle)
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
        VotingSession.loadedCategories = false
        VotingSession.price = priceSegment.selectedSegmentIndex
        self.performSegue(withIdentifier: "sessionHostSegue", sender: nil)
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
