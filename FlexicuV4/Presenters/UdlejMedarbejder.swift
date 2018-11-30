//
//  UdlejMedarbejder.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 30/11/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import UIKit

class UdlejMedarbejder: UIViewController {

    @IBOutlet weak var navn: UILabel!
    var name = ""
    var arbejdsområde = ""
    
    @IBOutlet weak var workfield: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navn.text = name
        workfield.text = arbejdsområde

        // Do any additional setup after loading the view.
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
