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
    override func viewDidLoad() {
   //     var ref: DatabaseReference
     //   ref = Database.database().reference()
       // ref.child("hey").child("1").setValue("Gunn")
        super.viewDidLoad()

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
                
                
                let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = tabBar
                
//                let tabBarCV = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! TabBarController
//                self.navigationController?.pushViewController(tabBarCV, animated: true)
            }
        }
        
    }
    
}
