//
//  ShowResultViewController.swift
//  TheBestApp
//
//  Created by Sanskar Gyawali on 3/9/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import MapKit

class ShowResultViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
   // @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var linkLabel: UIButton!
    @IBOutlet weak var textViewLabel: UITextView!
    @IBOutlet weak var star1Image: UIImageView!
    @IBOutlet weak var star2Image: UIImageView!
    @IBOutlet weak var star3Image: UIImageView!
    @IBOutlet weak var star4Image: UIImageView!
    @IBOutlet weak var star5Image: UIImageView!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var phoneClicked: UIButton!
    
    @IBAction func backToHomeOnPress(_ sender: Any) {
        self.performSegue(withIdentifier: "backToHomeSegue", sender: nil)
    }
    
    
    //   @IBOutlet var linkView: UITextView!
    var ratings: Float = 0.0
    var latitude: Float = 0.0
    var longitude: Float = 0.0
    var restaurants = ["Udon Restaurant"]
    var fullAddress:String = ""
    var ratingInt: Int = 0
    var websiteUrl:String = ""
    var phoneNumber: String = ""
    var onlyAddress:String = ""
    
   // let apicall = "https://api.foursquare.com/v2/venues/542616e8498e7e2b1a06433d?client_id=0T5JYUXBZQEZN4KQWNE1150JUPO0BEQ3X2OPSUFBR3GTMVIK&client_secret=PPFXEGBT2CTUIP0ONYAAYOFERT2VQS510FLEPLWJ4HPVEWHC&v=20141020"
    
   
    
    @IBAction func phoneClicked(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://\(phoneNumber)")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func websiteClicked(_ sender: Any) {
        if let urlClick = URL(string: websiteUrl){
            UIApplication.shared.open(urlClick, options: [:]) {_ in }
        }
    }
    
    func zoomIntoLocation(lat: CLLocationDegrees, lng: CLLocationDegrees){
        let annotation = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        annotation.coordinate = location
        annotation.title = self.restaurantNameLabel.text
        mapView.addAnnotation(annotation)
//        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//
//        let region = MKCoordinateRegion(center: location, span: mapSpan)
//
//        self.mapView.setRegion(region, animated: true)
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let reuseID = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if(annotationView == nil){
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            
            annotationView?.canShowCallout = true
            annotationView?.leftCalloutAccessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        }
        
        return annotationView
    }
    
    
    func loadVenueDetails(){
        let finalResaurant = VotingSession.getFinalRestaurant()!
        SquareClient.fetchRestaurantInfo(restaurantId: finalResaurant){
             (venue) in
            
            self.restaurantNameLabel.text = venue.value(forKey: "name") as? String
            let contactInfo = venue.value(forKey: "contact") as? NSDictionary
            self.phoneNumber = contactInfo?.value(forKey: "phone") as? String ?? "None"
            let locationInfo = venue.value(forKey: "location") as? NSDictionary
            self.onlyAddress = (locationInfo?.value(forKey: "address") as? String)!
            self.onlyAddress += ", " + (locationInfo?.value(forKey: "city") as? String)!
            self.onlyAddress += ", " + (locationInfo?.value(forKey: "state") as? String)!
             self.onlyAddress += " " + (locationInfo?.value(forKey: "postalCode") as? String)!
             self.onlyAddress += ", " + (locationInfo?.value(forKey: "country") as? String)!
            self.latitude = Float(truncating: (locationInfo?.value(forKey: "lat") as? NSNumber)!)
            self.longitude = Float(truncating: (locationInfo?.value(forKey: "lng") as? NSNumber)!)
            self.ratings = Float(truncating: venue.value(forKey: "rating") as? NSNumber ??  0.0)
       //     self.ratings = Float(truncating: (venue.value(forKey: "rating") as? NSNumber)!)
            self.websiteUrl = (venue.value(forKey: "url") as? String) ?? "None"
            let roundedNum = round(self.ratings)
            self.ratingInt = Int( roundedNum / 2.0)
            print(self.ratingInt)
            self.starRating()

            print("https://google.com/maps/place/\(self.fullAddress)")
            let hoursinfo = venue.value(forKey: "hours") as? NSDictionary
            self.statusLabel.text = hoursinfo?.value(forKey: "status") as? String ?? "Status Unknown"
            self.displayMapAtLatitude(latitude: Double(self.latitude), longitude: Double(self.longitude))
          //  let mapTitle: String = "Open \(self.restaurantNameLabel.text!) in Google Maps"
            self.linkLabel.setTitle("Open in Google Maps", for: .normal)
            self.textViewLabel.text = self.onlyAddress
            self.textViewLabel.isEditable = false
            self.textViewLabel.dataDetectorTypes = UIDataDetectorTypes.all
            self.zoomIntoLocation(lat: CLLocationDegrees(self.latitude), lng: CLLocationDegrees(self.longitude))
            
            if self.websiteUrl == "None"{
                self.websiteButton.isHidden = true
            }
            if self.phoneNumber == "None"{
                self.phoneClicked.isHidden = true
            }
 
        }
    }
    
    
    func starRating(){
        if (self.ratingInt == 1){
            self.star1Image.image = UIImage(systemName: "star.fill");
            self.star2Image.image = UIImage(systemName: "star");
            self.star3Image.image = UIImage(systemName: "star");
            self.star4Image.image = UIImage(systemName: "star");
            self.star5Image.image = UIImage(systemName: "star");
        }
        else if (self.ratingInt == 2){
        self.star1Image.image = UIImage(systemName: "star.fill");
        self.star2Image.image = UIImage(systemName: "star.fill");
        self.star3Image.image = UIImage(systemName: "star");
        self.star4Image.image = UIImage(systemName: "star");
        self.star1Image.image = UIImage(systemName: "star");
        }
        else if (self.ratingInt == 3){
        self.star1Image.image = UIImage(systemName: "star.fill");
        self.star2Image.image = UIImage(systemName: "star.fill");
        self.star3Image.image = UIImage(systemName: "star.fill");
        self.star4Image.image = UIImage(systemName: "star");
        self.star5Image.image = UIImage(systemName: "star");
        }
        else if (self.ratingInt == 4){
        self.star1Image.image = UIImage(systemName: "star.fill");
        self.star2Image.image = UIImage(systemName: "star.fill");
        self.star3Image.image = UIImage(systemName: "star.fill");
        self.star4Image.image = UIImage(systemName: "star.fill");
        self.star5Image.image = UIImage(systemName: "star");
        }
        else if (self.ratingInt == 5){
        self.star1Image.image = UIImage(systemName: "star.fill");
        self.star2Image.image = UIImage(systemName: "star.fill");
        self.star3Image.image = UIImage(systemName: "star.fill");
        self.star4Image.image = UIImage(systemName: "star.fill");
        self.star5Image.image = UIImage(systemName: "star.fill");
        }
        else{
            self.star1Image.isHidden = true
            self.star2Image.isHidden = true
            self.star3Image.isHidden = true
            self.star4Image.isHidden = true
            self.star5Image.isHidden = true
            
        }
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVenueDetails()
        mapView.delegate = self as MKMapViewDelegate
            
    }
    @IBAction func onLinkClick(_ sender: Any) {
        if let urlClick = URL(string: "https://maps.google.com/maps?q="+(self.latitude.description) + "," + (self.longitude.description)){
               UIApplication.shared.open(urlClick, options: [:]) {_ in }
           }
       }


    
    func displayMapAtLatitude(latitude: Double, longitude: Double) {
        var region = mapView.region
        region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.setRegion(region, animated: true)
    }
        }


        

        // Do any additional setup after loading the view.
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


