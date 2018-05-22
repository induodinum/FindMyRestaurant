//
//  SearchViewController.swift
//  myApp
//
//  Created by admin on 21/5/2561 BE.
//  Copyright © 2561 admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SearchViewController: UITableViewController, UISearchResultsUpdating {
    
    var mapData: [String: [Double]]!
    var myAnnot: [CLLocation: MKAnnotation]!
    var filtered = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    let popOver = PopOverViewController()
    let viewCtrl = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60;
        
        // Load data
        mapData = popOver.getJsonData()
        myAnnot = viewCtrl.getAnnotation()
        
        // Set searchbar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Search results
    func updateSearchResults(for searchController: UISearchController) {
        filtered.removeAll(keepingCapacity: false)
        
        filtered = mapData.keys.filter {(str: String) in
            return str.lowercased().contains(searchController.searchBar.text!.lowercased())
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive) {
            return filtered.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchViewCell", for: indexPath) as! SearchViewCell
        // Configure the cell...
        if(searchController.isActive) {
            cell.searchLabel.text! = filtered[indexPath.row]
        }
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showResultOnMap"){
            let mapVC = segue.destination as! ViewController
            let idxPath = tableView.indexPathForSelectedRow
            let selectedPlace = filtered[(idxPath?.row)!]
            print(tableView.cellForRow(at: idxPath!)!)
            print(filtered[(idxPath?.row)!])
            
            let X = mapData[selectedPlace]![0]
            let Y = mapData[selectedPlace]![1]
            let location = CLLocation(latitude: CLLocationDegrees(X), longitude: CLLocationDegrees(Y))
            
            print(X,": ",Y)
            //print(CLLocation(latitude: Y, longitude: X))
            mapVC.initialLocation = location
            mapVC.centeredAnnot = myAnnot[location]
            print("centeredAnnot: ", myAnnot, " ###")
        }
    }

}
