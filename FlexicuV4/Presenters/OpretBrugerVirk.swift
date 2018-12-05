//
//  OpretBrugerVirk.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 04/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import UIKit

class OpretBrugerVirk: UIViewController {

    
    @IBOutlet weak var VCVRTextField: UITextField!
    @IBOutlet weak var VNavnTextField: UITextField!
    @IBOutlet weak var VAdresseTextField: UITextField!
    @IBOutlet weak var VPostnrTextField: UITextField!

    @IBOutlet weak var FortsætBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FortsætBtn.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func fortsætBtnPressed(_ sender: UIButton) {
        
            let infoStruct = OpretBrugerStruct(VirkCVRnummer: VCVRTextField.text!, VirkNavn: VNavnTextField.text!, VirkAdresse: VAdresseTextField.text!, VirkPostnr: VPostnrTextField.text!, BrugNavn: nil, BrugEmail: nil, BrugTitel: nil, BrugTlfnr: nil, Email: nil, Password: nil)
        
            let opretBrugerKontaktViewController = self.storyboard?.instantiateViewController(withIdentifier: "opretKontakt") as! OpretBrugerKontakt
            opretBrugerKontaktViewController.setStructDataReference(structDataReference: infoStruct)
            self.navigationController?.pushViewController(opretBrugerKontaktViewController, animated: true)
            
        
    }
    
    @IBAction func VCVRText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    
    @IBAction func VNavnText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    @IBAction func VAdresseText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    @IBAction func VPostnrText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    func erAltTastetInd(text: String) -> Bool {
        if(VCVRTextField.text == "" || VNavnTextField.text == "" || VAdresseTextField.text == "" || VPostnrTextField.text?.count != 4){
            return false
        }
        else{
            return true
        }
    }
    
    struct OpretBrugerStruct {
        var VirkCVRnummer:String
        var VirkNavn:String
        var VirkAdresse:String
        var VirkPostnr:String
        var BrugNavn:String?
        var BrugEmail:String?
        var BrugTitel:String?
        var BrugTlfnr:String?
        var Email:String?
        var Password:String?
    }
    
}
