//
//  OpretBrugerLogin.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 04/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import UIKit
import FirebaseAuth

class OpretBrugerLogin: UIViewController {

    var infoStruct: OpretBrugerVirk.OpretBrugerStruct?
    
    @IBOutlet weak var LPassword2TextField: UITextField!
    @IBOutlet weak var LPassword1TextField: UITextField!
    @IBOutlet weak var LEmailTextField: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var OpretBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        OpretBtn.isEnabled = false
        LEmailTextField.text = infoStruct?.BrugEmail
        message.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OpretBtnPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: LEmailTextField.text!, password: LPassword1TextField.text!) { (user, error) in
            if(error != nil){
                
                print(error!)
            }
            else{
                print("Du har oprettet en bruger")
                let loginSkærmVC = self.storyboard?.instantiateViewController(withIdentifier: "loginSkærm") as! Login
//                loginSkærmVC.setStructDataReference(structDataReference: infoStruct!)
                self.navigationController?.pushViewController(loginSkærmVC, animated: true)
            }
        }
    }
    @IBAction func LBrugeremail(_ sender: UITextField) {
        OpretBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    @IBAction func LPassword(_ sender: UITextField) {
        OpretBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    @IBAction func LPassword2(_ sender: UITextField) {
        OpretBtn.isEnabled = erAltTastetInd(text: sender.text!)
    }
    
    
    func erAltTastetInd(text: String) -> Bool {
        if(LPassword1TextField.text == "" || LPassword2TextField.text == "" || LEmailTextField.text == ""){
            message.isHidden = true
            return false
        }
        else{
            if(LPassword1TextField.text != LPassword2TextField.text){
                message.isHidden = false
                return false
            }
            else {
                message.isHidden = true
                return true
            }
        }
    }
    func setStructDataReference(structDataReference: OpretBrugerVirk.OpretBrugerStruct){
        self.infoStruct = structDataReference;
    }

}
