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
    
  
    
    //   @IBOutlet var linkView: UITextView!
    var ratings: Float = 0.0
    var latitude: Float = 0.0
    var longitude: Float = 0.0
    var restaurants = ["Udon Restaurant"]
    var fullAddress:String = ""
    var ratingInt: Int = 0
    var websiteUrl:String = ""
    var phoneNumber: String = ""
    
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
    func zoomIntoLocation(){
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
//        let region = MKCoordinateRegion( center: location, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
//        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = self.restaurantNameLabel.text
        mapView.addAnnotation(annotation)
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    
    func loadVenueDetails(){
        let finalResaurant = VotingSession.getFinalRestaurant()!
        SquareClient.fetchRestaurantInfo(restaurantId: finalResaurant){
             (venue) in
            
            self.restaurantNameLabel.text = venue.value(forKey: "name") as? String
            let contactInfo = venue.value(forKey: "contact") as? NSDictionary
            self.phoneNumber = contactInfo?.value(forKey: "phone") as! String
            let locationInfo = venue.value(forKey: "location") as? NSDictionary
            let addressArray = locationInfo?.value(forKey: "formattedAddress") as? Array<Any>
            var addressString = addressArray?[0] as? String
            self.latitude = Float(truncating: (locationInfo?.value(forKey: "lat") as? NSNumber)!)
            self.longitude = Float(truncating: (locationInfo?.value(forKey: "lng") as? NSNumber)!)
            self.ratings = Float(truncating: (venue.value(forKey: "rating") as? NSNumber)!)
          //  self.ratingLabel.text = "Rating: \(self.ratings.description)"
            self.websiteUrl = (venue.value(forKey: "url") as? String)!
        //    self.websiteView.text = venue.value(forKey: "url") as? String
            self.ratingInt = Int(self.ratings/2.0)
            print(self.ratingInt)
            self.starRating()


            addressString! += ", " + (addressArray?[1] as? String)!
            addressString! += ", " + (addressArray?[2] as? String)!
        //    self.locationLabel.text = addressString
            self.fullAddress = addressString!
            print("https://google.com/maps/place/\(self.fullAddress)")
            let hoursinfo = venue.value(forKey: "hours") as? NSDictionary
            self.statusLabel.text = hoursinfo?.value(forKey: "status") as? String
            self.displayMapAtLatitude(latitude: Double(self.latitude), longitude: Double(self.longitude))
          //  let mapTitle: String = "Open \(self.restaurantNameLabel.text!) in Google Maps"
            self.linkLabel.setTitle("Open in Google Maps", for: .normal)
            self.textViewLabel.text = self.fullAddress
            self.textViewLabel.isEditable = false;
            self.textViewLabel.dataDetectorTypes = UIDataDetectorTypes.all;
       //     self.websiteView.isEditable = false;
       //     self.websiteView.dataDetectorTypes = UIDataDetectorTypes.all;
   
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
        else{
        self.star1Image.image = UIImage(systemName: "star.fill");
        self.star2Image.image = UIImage(systemName: "star.fill");
        self.star3Image.image = UIImage(systemName: "star.fill");
        self.star4Image.image = UIImage(systemName: "star.fill");
        self.star5Image.image = UIImage(systemName: "star.fill");
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVenueDetails()
        zoomIntoLocation()
            
    }
    @IBAction func onLinkClick(_ sender: Any) {
        if let urlClick = URL(string: "https://maps.google.com/maps?q="+(self.latitude.description) + "," + (self.longitude.description)){
               UIApplication.shared.open(urlClick, options: [:]) {_ in }
           }
       }

//            func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//                UIApplication.shared.open(URL)
//                return false
//            }
    
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


