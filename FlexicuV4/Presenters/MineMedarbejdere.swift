//
//  MineMedarbejdere.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 19/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit


class MineMedarbejdere: UIViewController {

    @IBOutlet weak var navnTextField: UITextField!
    @IBOutlet weak var foedselsaarTextField: UITextField!
    @IBOutlet weak var stillingTextField: UITextField!
    @IBOutlet weak var loenTextField: UITextField!
    @IBOutlet weak var kommentarTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        kommentarTextView.layer.cornerRadius = 5
        kommentarTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        kommentarTextView.layer.borderWidth = 0.5
        kommentarTextView.clipsToBounds = true
        
      /*
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        kommentarTextView.layer.borderWidth = 0.5
        kommentarTextView.layer.borderColor = borderColor.cgColor
        kommentarTextView.layer.cornerRadius = 5.0
*/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}
