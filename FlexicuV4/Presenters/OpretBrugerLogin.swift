//
//  OpretBrugerLogin.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 04/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OpretBrugerLogin: UIViewController {

    var infoStruct: OpretBrugerVirk.OpretBrugerStruct?
    var ref: DatabaseReference!
    var virksomhed: Virksomhed?
    
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
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OpretBtnPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: LEmailTextField.text!, password: LPassword1TextField.text!) { (user, error) in
            if(error != nil){
                let alertController = UIAlertController(title: "Fejl!", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                print(error!)
            }
            else{
                print("Du har oprettet en bruger")
//                var virksomhed = Virksomhed(CVR: (self.infoStruct!.VirkCVRnummer), virkNavn: (self.infoStruct?.VirkNavn)!, virkAdresse: (self.infoStruct?.VirkAdresse)!, postnr: (self.infoStruct?.VirkPostnr)!, brugNavn: (self.infoStruct?.BrugNavn)!, brugEmail: (self.infoStruct?.BrugEmail)!, brugTlf: (self.infoStruct?.BrugTlfnr)!)
                self.infoStruct?.BrugEmail = self.LEmailTextField.text
                let user = Auth.auth().currentUser?.uid
                self.infoStruct?.Email = self.LEmailTextField.text
                
//                var ref: DatabaseReference
//                ref = Database.database().reference()
                self.ref.child("user").child(user!).setValue(["CVR": self.infoStruct?.VirkCVRnummer, "virkNavn": self.infoStruct?.VirkNavn, "virkAdresse":self.infoStruct?.VirkAdresse, "postnr":self.infoStruct?.VirkPostnr, "brugerNavn":self.infoStruct?.BrugNavn, "brugEmail":self.infoStruct?.BrugEmail, "brugerTlf":self.infoStruct?.BrugTlfnr])

                let loginSkærmVC = self.storyboard?.instantiateViewController(withIdentifier: "logindSkærm") as! Login
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
