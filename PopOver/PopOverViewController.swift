//
//  PopOverViewController.swift
//  myApp
//
//  Created by admin on 22/4/2561 BE.
//  Copyright © 2561 admin. All rights reserved.
//

import UIKit

class PopOverViewController: UITableViewController {

    var tableData = [String]()
    var dataFromJson = [String: [Double]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
//        for data in tableData {
//            print(data)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "popOverCell", for: indexPath) as? popOverCell else{
            fatalError("No cells")
        }

        cell.restaurantLabel.text = tableData[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    func getJsonData() -> [String: [Double]]{
        if let path = Bundle.main.path(forResource: "shapefile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                for str in (jsonData?.keys)! {
                    if let coordinate = jsonData?[str] as? NSArray {
                        let long = (coordinate[0] as! NSNumber).doubleValue
                        let lat = (coordinate[1] as! NSNumber).doubleValue
                        dataFromJson[str] = [lat,long]
                        tableData.append(str)
                    }
                }
                tableData.sort()
            } catch {
                // handle error
            }
        }
        return dataFromJson
    }
    
}
