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
        emailTextField.text = "teest@test.dk"
        passwordTextField.text = "janus12"
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
                
                //self.writeData()
                
                VirkSingleton.shared.dao.readVirksomhed()
//                VirkSingleton.shared.dao.readMedarbejder()
                
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
        med1.setValue(["navn": "Gunn", "fødselsår": "1992", "adresse": "Dalslandsgade 8G", "loen": "32000", "arbejdsområde": "Smed", "kommentar":""])
        var med1id = med1.key
        
        ref.child("medarbejdere").child(med1id!).setValue(["navn": "Gunn", "fødselsår": "1992", "adresse": "Dalslandsgade 8G", "loen": "32000", "arbejdsområde": "Smed", "kommentar": "", "Virksomhedid":userID])
        
        var med2 = ref.child("user").child(userID!).child("medarbejdere").childByAutoId()
        med2.setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar":""])
        var med2id = med2.key
        
        ref.child("medarbejdere").child(med2id!).setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar": "", "Virksomhedid":userID])
        

        var aft1 = ref.child("ledig").childByAutoId()
        aft1.setValue(["loen": "32000", "startperiode": "1/12-18", "slutperiode": "1/1-19", "aktiv": true])
        var aft1id = aft1.key
        ref.child("ledig").child(aft1id!).child("medarbejder").setValue(["navn": "Gunn", "fødselsår": "1992", "adresse": "Dalslandsgade 8G", "loen": "32000", "arbejdsområde": "Smed", "kommentar":"", "id":med1id!])
        ref.child("ledig").child(aft1id!).child("lejer").setValue(["id": userID, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        
        var aft2 = ref.child("ledig").childByAutoId()
        aft2.setValue(["loen": "32000", "startperiode": "1/12-18", "slutperiode": "1/1-19", "aktiv": true])
        var aft2id = aft2.key
        ref.child("ledig").child(aft2id!).child("medarbejder").setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar":"", "id": med2id!])
        ref.child("ledig").child(aft2id!).child("lejer").setValue(["id": userID, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        
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
