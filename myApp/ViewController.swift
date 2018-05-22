//
//  ViewController.swift
//  myApp
//
//  Created by admin on 17/4/2561 BE.
//  Copyright © 2561 admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var initialLocation: CLLocation!
    var mapData: [String: [Double]]!
    var myAnnotation = [CLLocation : MKAnnotation]()
    var centeredAnnot: MKAnnotation!
    
    let isCurrentLocation = false
    let locationManager = CLLocationManager()
    let popOver = PopOverViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if initialLocation == nil {
            initialLocation = CLLocation(latitude: 13.738623, longitude: 100.532055)
        }
//        else{
//            print("Assigning centeredAnnot value")
//            centeredAnnot = myAnnotation[initialLocation]
//        }
        centerMapOnLocation(location: initialLocation)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        let currentLocationButton = MKUserTrackingButton(mapView: mapView)
        mapView.addSubview(currentLocationButton)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapData = popOver.getJsonData()
        addAnnotation()
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        print("888888")
        
        if (centeredAnnot != nil) {
            mapView.selectAnnotation(centeredAnnot, animated: true)
        }else{
            print("No centeredAnnot values yet")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: custom func
    func addAnnotation(){
        for place in mapData {
            let loc = CLLocation(latitude: place.value[0], longitude: place.value[1])
            let artwork = Artwork(title: place.key, coordinate: CLLocationCoordinate2D(latitude: place.value[0], longitude: place.value[1]))
            mapView.addAnnotation(artwork)
            myAnnotation[loc] = artwork
            if(place.key == "True coffee"){
                print("True coffee location: ", loc, " ###")
                print(myAnnotation[loc]!)
            }
        }
    }
    
    func getAnnotation() -> [CLLocation : MKAnnotation]{
        return myAnnotation
    }
    
    @objc func showRestInfo(sender: UIControl){
        print("1111")
        performSegue(withIdentifier: "showRestView", sender: sender)
    }
    
    //MARK: prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showRestView"){
            let restInfoView = segue.destination as! RestInfoViewController
            restInfoView.name = activeAnnot.title!
            restInfoView.labelX = activeAnnot.coordinate.latitude
            restInfoView.labelY = activeAnnot.coordinate.longitude
            print("5555")
        }
    }
    
    //MARK: show popover view    
    @IBAction func showList(_ sender: UIBarButtonItem) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "popOver") as! PopOverViewController
        VC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        let navController = UINavigationController(rootViewController: VC)
        navController.modalPresentationStyle = .popover
        
        let popOverController = navController.popoverPresentationController
        popOverController?.delegate = self
        popOverController?.barButtonItem = sender
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //MARK: map methods
    let regionRadius: CLLocationDistance = 1500
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        if (mapView != nil) {
            mapView.setRegion(coordinateRegion, animated: true)
        }else{
            print("No values in mapView")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else {
            return nil
        }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
            view.canShowCallout = true
        }else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
        }
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return view
    }
    
    var activeAnnot: MKAnnotation!
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("1234")
        //let annot = view.annotation as! Artwork
        //let button = view.rightCalloutAccessoryView as! UIButton
        //button.addTarget(self, action: #selector(showRestInfo(sender:)), for: .touchUpInside)
        //annotationData[button] = annot
        activeAnnot = view.annotation
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("1111")
        performSegue(withIdentifier: "showRestView", sender: self)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: ArtworkView.self){
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
    
}

