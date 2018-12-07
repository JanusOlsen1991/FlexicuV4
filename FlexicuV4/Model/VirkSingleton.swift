//
//  VirkSingleton.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 06/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


class VirkSingleton{
    private init(){}
    static let shared = VirkSingleton()
    var virksomhed: Virksomhed?
    var ref: DatabaseReference!
    
    func launch(){
        readData()
    }
    
    func readData(){
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        let weee = "wee"
        print("Current user ID is \(userID ?? weee)")
        ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let CVR = value?["CVR"] as? String ?? ""
            let virkNavn = value?["virkNavn"] as? String ?? ""
            let virkAdresse = value?["virkAdresse"] as? String ?? ""
            let postnr = value?["postnr"] as? String ?? ""
            let brugerNavn = value?["brugerNavn"] as? String ?? ""
            let brugEmail = value?["brugEmail"] as? String ?? ""
            let brugerTlf = value?["brugerTlf"] as? String ?? ""
            
            self.virksomhed = Virksomhed(CVR: CVR, virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, brugNavn: brugerNavn, brugEmail: brugEmail, brugTlf: brugerTlf)
            
            
            let array:NSArray = snapshot.childSnapshot(forPath: "medarbejdere").children.allObjects as NSArray
            
            for obj in array {
                let snapshot:DataSnapshot = obj as! DataSnapshot
                let medid = snapshot.key
                print(medid)
                if let childSnapshot = snapshot.value as? [String : AnyObject]{
                    let mednavn = childSnapshot["navn"] as? String ?? ""
                    print(mednavn)
                    let medadresse = childSnapshot["adresse"] as? String ?? ""
                    let medaar = childSnapshot["fødselsår"] as? String ?? ""
                    let medarbejdsom = childSnapshot["arbejdsområde"] as? String ?? ""
                    let medloen = childSnapshot["loen"] as? String ?? ""
                    
                    let medarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: medaar, adresse: medadresse, loen: medloen, arbejdsomraade: medarbejdsom)
                    self.virksomhed?.medarbejdere.append(medarbejder)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //        ref.child("user").child(userID!).child("medarbejdere").observeSingleEvent(of: .value, with: { (snapshot) in
        //            // Get user value
        //            if(snapshot.exists()) {
        //                let array:NSArray = snapshot.children.allObjects as NSArray
        //                for obj in array {
        //                    let snapshot:DataSnapshot = obj as! DataSnapshot
        //                    let medid = snapshot.key
        //                    print(medid)
        //                    if let childSnapshot = snapshot.value as? [String : AnyObject]{
        //                        let mednavn = childSnapshot["navn"] as? String ?? ""
        //                        print(mednavn)
        //                        let medadresse = childSnapshot["adresse"] as? String ?? ""
        //                        let medaar = childSnapshot["fødselsår"] as? String ?? ""
        //                        let medarbejdsom = childSnapshot["arbejdsområde"] as? String ?? ""
        //                        let medloen = childSnapshot["loen"] as? String ?? ""
        //
        //                        let medarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: medaar, adresse: medadresse, loen: medloen, arbejdsomraade: medarbejdsom)
        //                        self.virksomhed.medarbejdere.append(medarbejder)
        //
        //                    }
        //                }
        //            }
        //        }) { (error) in
        //            print(error.localizedDescription)
        //        }
    }
    
    
}
