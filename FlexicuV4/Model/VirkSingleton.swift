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
    var ledigFolk: [Aftaler] = []
    var udlejedeFolk: [Aftaler] = []
    var dao = DAO()
    
//    func readVirksomhed(){
//        ref = Database.database().reference()
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
//            self.virksomhed = Virksomhed(virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, id: self.userID!)
//            self.virksomhed?.CVR = CVR
//            self.virksomhed?.brugNavn = brugerNavn
//            self.virksomhed?.brugEmail = brugEmail
//            self.virksomhed?.brugTlf = brugerTlf
//
//
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
//
//    func readMedarbejder(){
//        ref.child(userID!).child("medarbejdere").observeSingleEvent(of: .value, with: { (snapshot) in
//            let array:NSArray = snapshot.children.allObjects as NSArray
//
//            for obj in array {
//                let snapshot:DataSnapshot = obj as! DataSnapshot
//                let medid = snapshot.key
//                print(medid)
//                if let childSnapshot = snapshot.value as? [String : AnyObject]{
//                    let mednavn = childSnapshot["navn"] as? String ?? ""
//                    let medaar = childSnapshot["fødselsår"] as? String ?? ""
//                    let medarbejdsom = childSnapshot["arbejdsområde"] as? String ?? ""
//                    let medloen = childSnapshot["loen"] as? String ?? ""
//                    let medkommentar = childSnapshot["kommentar"] as? String ?? ""
//
//                    let medarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: medaar, arbejdsomraade: medarbejdsom)
//                    medarbejder.loen = medloen
//                    medarbejder.kommentar = medkommentar
//                    self.virksomhed?.medarbejdere.append(medarbejder)
//                    NotificationCenter.default.post(name: NSNotification.Name("readData"), object: self)
//                    print("medarbejdere hentet")
//                }
//            }
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
//
//
//    func readUdlej(){
//
//        ref.child("ledig").queryOrdered(byChild: "aktiv").queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (snapshot) in
//            let aft_array:NSArray = snapshot.children.allObjects as NSArray
//            for obj in aft_array{
//                let childMedarbSnapshot = snapshot.childSnapshot(forPath: "medarbejdere").children
//                let childUdlejSnapshot = snapshot.childSnapshot(forPath: "udlejer").children
//
//                let snapshot:DataSnapshot = obj as! DataSnapshot
//                let aftaleid = snapshot.key
//
//                if let snapshot = snapshot.value as? NSDictionary{
//                    let loen = snapshot["loen"] as? String ?? ""
//                    let startperiode = snapshot["startperiode"] as? String ?? ""
//                    let slutperiode = snapshot["slutperiode"] as? String ?? ""
//                    let kommentar = snapshot["kommentar"] as? String ?? ""
//
//
//                    let childMedarbSnapshot:DataSnapshot = obj as! DataSnapshot
//                    let medid = childMedarbSnapshot.key
//
//                    let childUdlejSnapshot:DataSnapshot = obj as! DataSnapshot
//                    let udlejid = childUdlejSnapshot.key
//
//                    var mednavn = ""
//                    var alder = ""
//                    var arbejdsområde = ""
//
//
//                    if let childMedarbSnapshot = childMedarbSnapshot.value as? NSDictionary{
//                        mednavn = childMedarbSnapshot["navn"] as? String ?? ""
//                        alder = childMedarbSnapshot["fødselsår"] as? String ?? ""
//                        arbejdsområde = childMedarbSnapshot["arbejdsområde"] as? String ?? ""
//
//                    }
//
//                    var virkNavn = ""
//                    var virkAdresse = ""
//                    var postnr = ""
//
//
//                    if(udlejid != self.userID){
//                        if let childUdlejSnapshot = childUdlejSnapshot.value as? NSDictionary{
//                            virkNavn = childUdlejSnapshot["virkNavn"] as? String ?? ""
//                            virkAdresse = childUdlejSnapshot["virkAdresse"] as? String ?? ""
//                            postnr = childUdlejSnapshot["postnr"] as? String ?? ""
//                        }
//
//                    }
//
//                    if(udlejid == self.userID!){
//                        for med in (self.virksomhed?.medarbejdere)!{
//                            if(med.id == medid){
//                                med.ledig = false
//                            }
//                        }
//                    }
//                    else{
//                        let ledigMedarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: alder, arbejdsomraade: arbejdsområde)
//                        let udlejVirksomhed = Virksomhed(virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, id: udlejid)
//                        let udlejning = Aftaler(id: aftaleid, medarbejder: ledigMedarbejder, loen: loen, startDato: startperiode, slutDato: slutperiode, udlejer: udlejVirksomhed, indlejer: nil, kommentar: kommentar)
//
//                        VirkSingleton.shared.ledigFolk.append(udlejning)
//                    }
//
//                    //                    NotificationCenter.default.post(name: NSNotification.Name("readData"), object: self)
//
//                }
//
//
//            }
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
}
