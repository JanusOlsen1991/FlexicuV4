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
    @IBOutlet weak var alderTextField: UITextField!
    @IBOutlet weak var arbejdsområdeTextField: UITextField!
    @IBOutlet weak var loenTextField: UITextField!
    @IBOutlet weak var kommentarTextField: UITextView!
    @IBOutlet weak var startdatoTextField: UITextField!
    @IBOutlet weak var slutdatoTextField: UITextField!
    
    @IBOutlet weak var distanceTextField: UITextField!
    
    @IBOutlet weak var gemBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func gemBtnPressed(_ sender: Any) {
//        VirkSingleton.shared.dao.gemMedarbejder(
        
        
//        let medarbejder = Medarbejder(
        
        
    }
    
    @IBAction func navnIndtastet(_ sender: Any) {
        gemBtn.isEnabled = erAltTastetInd()
    }
    @IBAction func alderIndtastet(_ sender: Any) {
        gemBtn.isEnabled = erAltTastetInd()
    }
    @IBAction func arbejdsområdeIndtastet(_ sender: Any) {
        gemBtn.isEnabled = erAltTastetInd()
    }
    @IBAction func loenIndtastet(_ sender: Any) {
        gemBtn.isEnabled = erAltTastetInd()
    }
    @IBAction func distanceIndtastet(_ sender: Any) {
        gemBtn.isEnabled = erAltTastetInd()
    }
    @IBAction func startdatoIndtastet(_ sender: Any) {
        gemBtn.isEnabled = erAltTastetInd()
    }
    @IBAction func slutdatoIndtastet(_ sender: Any) {
        gemBtn.isEnabled = erAltTastetInd()
    }
    
    func erAltTastetInd() -> Bool {
        if(navnTextField.text == "" || alderTextField.text == "" || arbejdsområdeTextField.text == "" || loenTextField.text == ""){
            return false
        }
        else{
            return true
        }
    }

}
