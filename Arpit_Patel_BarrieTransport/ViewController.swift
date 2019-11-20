//
//  ViewController.swift
//  Arpit_Patel_BarrieTransport
//
//  Created by Arpit Kamalkumar Patel on 2019-11-20.
//  Copyright © 2019 Arpit Kamalkumar Patel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    //MARK:- Outletes
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK:- Class Variables
    var model = AP_BTS_Model()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let barrieLattitude = 44.389355
        let barrieLongitude = -79.690331
        
        let barrieLocation = CLLocationCoordinate2D(latitude: barrieLattitude, longitude: barrieLongitude)
        
        let delta = 0.1
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        
        let region = MKCoordinateRegion(center: barrieLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        for driver in model.drivers{
            print("driver name is\(driver.key)")
            
            //delta is 0.1
            //so random number will be between 0.05 to -0.05
            
            let random1 = Double.random(in: -0.05...0.05)
            let random2 = Double.random(in: -0.05...0.05)
            
            let annotation = MKPointAnnotation()
            
            let annotationLocation = CLLocationCoordinate2D(latitude: barrieLattitude +
                random1, longitude: barrieLongitude + random2)
            
            annotation.coordinate = annotationLocation
            annotation.title = driver.key
            annotation.subtitle = driver.value
            
            mapView.addAnnotation(annotation)
        }
        
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }


}

class CustomAnnotationView : MKMarkerAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.canShowCallout = true
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 35))
        
        button.setTitle("Call", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        
        button.addTarget(self, action: #selector(CustomAnnotationView.callTheNumber), for: .touchUpInside)
        
        self.rightCalloutAccessoryView = button
    }
    
    @objc func callTheNumber(sender : UIButton) {
        print("Call the driver!")
        
        let phoneNumber = (annotation?.subtitle)!
        let urlString = "tel://" + phoneNumber!
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
