//
//  RestInfoViewController.swift
//  myApp
//
//  Created by admin on 1/5/2561 BE.
//  Copyright © 2561 admin. All rights reserved.
//

import UIKit

class RestInfoViewController: UIViewController {

    var name: String!
    var labelX: Double!
    var labelY: Double!
    
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var coordX: UILabel!
    @IBOutlet weak var coordY: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restName.text = name
        coordX.text = String(labelX)
        coordY.text = String(labelY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
