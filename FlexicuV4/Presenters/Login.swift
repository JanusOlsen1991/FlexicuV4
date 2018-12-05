//
//  Login.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 15/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class Login: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtnPressed: UIButton!
    var ref: DatabaseReference!
    var virksomhed: Virksomhed!
    
    override func viewDidLoad() {
   //     var ref: DatabaseReference
     
       // ref.child("hey").child("1").setValue("Gunn")
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Metode sørger for at keyboardet forsvinder ved tryk andre steder på skærmen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Ikke den rigtige metode. Tror der skal bruges willTransitionTo
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation.isLandscape)
    }

    
    @IBAction func LoginPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if(error != nil){
                print(error!)
            }
            else{
                print("Du er logget ind")
                self.readData()
                
                let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = tabBar
                
            }
        }
        
    }
    
    func readData(){
        
        let userID = Auth.auth().currentUser?.uid
        let weee = "wee"
        print("Current user ID is \(userID ?? weee)")
        ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("antal",snapshot.childrenCount)
            let value = snapshot.value as? NSDictionary
            let CVR = value?["CVR"] as? String ?? ""
            let virkNavn = value?["virkNavn"] as? String ?? ""
            let virkAdresse = value?["virkAdresse"] as? String ?? ""
            let postnr = value?["postnr"] as? String ?? ""
            let brugerNavn = value?["brugerNavn"] as? String ?? ""
            let brugEmail = value?["brugEmail"] as? String ?? ""
            let brugerTlf = value?["brugerTlf"] as? String ?? ""
            
            self.virksomhed = Virksomhed(CVR: CVR, virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, brugNavn: brugerNavn, brugEmail: brugEmail, brugTlf: brugerTlf)
            print("CVR:\(CVR)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
