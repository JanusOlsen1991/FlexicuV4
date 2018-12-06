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
                VirkSingleton.shared.readData()
//                self.writeData()
                
                let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = tabBar
                
            }
        }
        
    }
    
//    func readData(){
//        
//        let userID = Auth.auth().currentUser?.uid
//        let weee = "wee"
//        print("Current user ID is \(userID ?? weee)")
//        ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let CVR = value?["CVR"] as? String ?? ""
//            let virkNavn = value?["virkNavn"] as? String ?? ""
//            let virkAdresse = value?["virkAdresse"] as? String ?? ""
//            let postnr = value?["postnr"] as? String ?? ""
//            let brugerNavn = value?["brugerNavn"] as? String ?? ""
//            let brugEmail = value?["brugEmail"] as? String ?? ""
//            let brugerTlf = value?["brugerTlf"] as? String ?? ""
//            
//            self.virksomhed = Virksomhed(CVR: CVR, virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, brugNavn: brugerNavn, brugEmail: brugEmail, brugTlf: brugerTlf)
//            
//            
//            let array:NSArray = snapshot.childSnapshot(forPath: "medarbejdere").children.allObjects as NSArray
//            
//            for obj in array {
//                let snapshot:DataSnapshot = obj as! DataSnapshot
//                let medid = snapshot.key
//                print(medid)
//                if let childSnapshot = snapshot.value as? [String : AnyObject]{
//                    let mednavn = childSnapshot["navn"] as? String ?? ""
//                    print(mednavn)
//                    let medadresse = childSnapshot["adresse"] as? String ?? ""
//                    let medaar = childSnapshot["fødselsår"] as? String ?? ""
//                    let medarbejdsom = childSnapshot["arbejdsområde"] as? String ?? ""
//                    let medloen = childSnapshot["loen"] as? String ?? ""
//                    
//                    let medarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: medaar, adresse: medadresse, loen: medloen, arbejdsomraade: medarbejdsom)
//                    self.virksomhed.medarbejdere.append(medarbejder)
//                }
//            }
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        
////        ref.child("user").child(userID!).child("medarbejdere").observeSingleEvent(of: .value, with: { (snapshot) in
////            // Get user value
////            if(snapshot.exists()) {
////                let array:NSArray = snapshot.children.allObjects as NSArray
////                for obj in array {
////                    let snapshot:DataSnapshot = obj as! DataSnapshot
////                    let medid = snapshot.key
////                    print(medid)
////                    if let childSnapshot = snapshot.value as? [String : AnyObject]{
////                        let mednavn = childSnapshot["navn"] as? String ?? ""
////                        print(mednavn)
////                        let medadresse = childSnapshot["adresse"] as? String ?? ""
////                        let medaar = childSnapshot["fødselsår"] as? String ?? ""
////                        let medarbejdsom = childSnapshot["arbejdsområde"] as? String ?? ""
////                        let medloen = childSnapshot["loen"] as? String ?? ""
////
////                        let medarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: medaar, adresse: medadresse, loen: medloen, arbejdsomraade: medarbejdsom)
////                        self.virksomhed.medarbejdere.append(medarbejder)
////
////                    }
////                }
////            }
////        }) { (error) in
////            print(error.localizedDescription)
////        }
//    }
    
    
    func getVirksomhed() -> Virksomhed{
        return self.virksomhed
    }
    
    func writeData(){
        let userID = Auth.auth().currentUser?.uid
        
        
        var med1 = ref.child("user").child(userID!).child("medarbejdere").childByAutoId()
        med1.setValue(["navn": "Gunn", "fødselsår": "1992", "adresse": "Dalslandsgade 8G", "loen": "32000", "arbejdsområde": "Smed"])
        var med1id = med1.key
        
        ref.child("user").child(userID!).child("medarbejdere").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            if(snapshot.exists()) {
                let array:NSArray = snapshot.children.allObjects as NSArray
                
                for obj in array {
                    let snapshot:DataSnapshot = obj as! DataSnapshot
                    if let childSnapshot = snapshot.value as? [String : AnyObject]
                    {
                        if let clubName = childSnapshot["name"] as? String {
                            print(clubName)
                        }
                    }
                }
                
            }
        
            
            
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
            
            self.ref.child("user").child(userID!).child("medarbejder")
            
            print("CVR:\(CVR)")
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        
        
        ref.child("user").child(userID!).child("medarbejdere").childByAutoId().setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer"])

        
        
//        ref.child("user").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //print("antal",snapshot.childrenCount)
//            let value = snapshot.value as? NSDictionary
//            let CVR = value?["CVR"] as? String ?? ""
//            let virkNavn = value?["virkNavn"] as? String ?? ""
//            let virkAdresse = value?["virkAdresse"] as? String ?? ""
//            let postnr = value?["postnr"] as? String ?? ""
//            let brugerNavn = value?["brugerNavn"] as? String ?? ""
//            let brugEmail = value?["brugEmail"] as? String ?? ""
//            let brugerTlf = value?["brugerTlf"] as? String ?? ""
        
//            self.virksomhed = Virksomhed(CVR: CVR, virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, brugNavn: brugerNavn, brugEmail: brugEmail, brugTlf: brugerTlf)
//            print("CVR:\(CVR)")
//
//            var navn:String
//            var foedselsaar:Int
//            var adresse:String
//            var postnr:String
//            var loen:Int
//            var arbejdsomraade:String
//            var id:String
//        }) { (error) in
//            print(error.localizedDescription)
//        }
    }
    
}
