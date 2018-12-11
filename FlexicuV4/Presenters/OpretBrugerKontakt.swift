//
//  OpretBrugerKontakt.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 04/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import UIKit

class OpretBrugerKontakt: UIViewController {
    
    var infoStruct: OpretBrugerVirk.OpretBrugerStruct?
    
    @IBOutlet weak var BTlfnrTextField: UITextField!
    @IBOutlet weak var BTitelTextField: UITextField!
    @IBOutlet weak var BEmailTextField: UITextField!
    @IBOutlet weak var BNavnTextField: UITextField!
    
    @IBOutlet weak var FortsætBtn: UIButton!
    
    @IBOutlet weak var message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        FortsætBtn.isEnabled=false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func FortsætBtnPressed1(_ sender: UIButton) {
        infoStruct?.BrugEmail = BEmailTextField.text
        infoStruct?.BrugNavn = BNavnTextField.text
        infoStruct?.BrugTitel = BTitelTextField.text
        infoStruct?.BrugTlfnr = BTlfnrTextField.text
        
        let opretBrugerLoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "opretLogin") as! OpretBrugerLogin
    opretBrugerLoginViewController.setStructDataReference(structDataReference: infoStruct!)
    self.navigationController?.pushViewController(opretBrugerLoginViewController, animated: true)
    }
    
    @IBAction func BNavnText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    @IBAction func BEmailText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    @IBAction func BTitelText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
        
    }
    @IBAction func BTlfnrText(_ sender: UITextField) {
        FortsætBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    
    func erAltTastetInd(text: String) -> Bool {
         if(BTlfnrTextField.text == "" || BTitelTextField.text == "" || BEmailTextField.text == "" || BNavnTextField.text == ""){
//            message.isHidden = true
            if((isValidEmail(email: BEmailTextField.text!) == false) && (BEmailTextField.text! != "")){
//                message.isHidden = false
            }
            return false
        }
        else{
            if(isValidEmail(email: BEmailTextField.text!) == false){
//                message.isHidden = false
                return false
            }
            else{
//                message.isHidden = true
                return true
            }
            
        }
    }
    
    func isValidEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func setStructDataReference(structDataReference: OpretBrugerVirk.OpretBrugerStruct){
        self.infoStruct = structDataReference;
    }
}

