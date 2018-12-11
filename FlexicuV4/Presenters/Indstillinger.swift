//
//  Indstillinger.swift
//  FlexicuV4
//
//  Created by Janus Olsen on 07/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import UIKit

class Indstillinger: UIViewController {
    @IBOutlet weak var CVRtxt: UITextField!
    @IBOutlet weak var vshNavntxt: UITextField!
    @IBOutlet weak var vshAdressetxt: UITextField!
    
    @IBOutlet weak var eMailTxt: UITextField!
    @IBOutlet weak var brugersTitelTxt: UITextField!
    @IBOutlet weak var brugersTlfTxt: UITextField!
    @IBOutlet weak var postNrtxt: UITextField!
    @IBOutlet weak var brugersNavnTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logAfAction(_ sender: Any) {
    //TODO -> gåtilbage til login skærm, samt data der bruges i programmet tømmes?
    }
    
 

}
