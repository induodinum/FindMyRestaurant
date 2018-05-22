//
//  ArtworkView.swift
//  myApp
//
//  Created by admin on 30/4/2561 BE.
//  Copyright © 2561 admin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ArtworkView: MKMarkerAnnotationView{
    override var annotation: MKAnnotation?{
        willSet{
            guard let artwork = newValue as? Artwork else{ return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = UIColor.red
            //print(artwork.title!)
        }
    }
}
