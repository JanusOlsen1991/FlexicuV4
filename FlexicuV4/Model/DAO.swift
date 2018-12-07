//
//  DAO.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 07/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class DAO{
    var ref: DatabaseReference!
    var userID = Auth.auth().currentUser?.uid
    var ref1: DatabaseReference!
    init(){ }
    
    func readVirksomhed(){
        ref = Database.database().reference()
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
            
            VirkSingleton.shared.virksomhed = Virksomhed(virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, id: self.userID!)
            VirkSingleton.shared.virksomhed?.CVR = CVR
            VirkSingleton.shared.virksomhed?.brugNavn = brugerNavn
            VirkSingleton.shared.virksomhed?.brugEmail = brugEmail
            VirkSingleton.shared.virksomhed?.brugTlf = brugerTlf
            
            print(VirkSingleton.shared.virksomhed?.CVR)
            //self.writeAftaler()
            self.readMedarbejder()
            self.readUdlej()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func writeAftaler(){
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
    }
    
    func readMedarbejder(){
        ref.child("user").child(userID!).child("medarbejdere").observeSingleEvent(of: .value, with: { (snapshot) in
            let array:NSArray = snapshot.children.allObjects as NSArray
            print(snapshot.childrenCount)
            for obj in array {
                
                let snapshot:DataSnapshot = obj as! DataSnapshot
                let medid = snapshot.key
                if let childSnapshot = snapshot.value as? [String : AnyObject]{
                    print("test")
                    let mednavn = childSnapshot["navn"] as? String ?? ""
                    let medaar = childSnapshot["fødselsår"] as? String ?? ""
                    let medarbejdsom = childSnapshot["arbejdsområde"] as? String ?? ""
                    let medloen = childSnapshot["loen"] as? String ?? ""
                    let medkommentar = childSnapshot["kommentar"] as? String ?? ""
                    
                    let medarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: medaar, arbejdsomraade: medarbejdsom)
                    medarbejder.loen = medloen
                    medarbejder.kommentar = medkommentar
                    VirkSingleton.shared.virksomhed?.medarbejdere.append(medarbejder)
                    print("medarbejdere hentet: \(String(describing: VirkSingleton.shared.virksomhed?.medarbejdere.count))")
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("readMedarbejdere"), object: self)
            print("medarbejdere hentet: \(String(describing: VirkSingleton.shared.virksomhed?.medarbejdere.count))")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    func readUdlej(){
        
        ref.child("ledig").queryOrdered(byChild: "aktiv").queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (snapshot) in
            //            let aft_array:NSArray = snapshot.children.allObjects as NSArray
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                print(snapshot.childrenCount)
                
                
                //                let snapshot:DataSnapshot = child as! DataSnapshot
                let aftaleid = child.key
                
                let aftvalue = child.value as? NSDictionary
                let loen = aftvalue!["loen"] as? String ?? ""
                let startperiode = aftvalue!["startperiode"] as? String ?? ""
                let slutperiode = aftvalue!["slutperiode"] as? String ?? ""
                let kommentar = aftvalue!["kommentar"] as? String ?? ""
                print("loen",loen)
                
                
                
                let childMedarbSnapshot = child.childSnapshot(forPath: "medarbejder")
                let childUdlejSnapshot = child.childSnapshot(forPath: "lejer")
                print(childUdlejSnapshot.key)
                let medid = childMedarbSnapshot.key
                var mednavn = ""
                var alder = ""
                var arbejdsområde = ""
                
                print("medid", medid)
                
                let medValue = childMedarbSnapshot.value as? NSDictionary
                mednavn = medValue?["navn"] as? String ?? "1"
                alder = medValue?["fødselsår"] as? String ?? "1"
                arbejdsområde = medValue?["arbejdsområde"] as? String ?? "1"
                
                print("medNavn", mednavn)
                
                //                let udlejSnapshot:DataSnapshot = child as! DataSnapshot
                let udlejid = childUdlejSnapshot.key
                //                        getudlejid.key
                
                
                var virkNavn = ""
                var virkAdresse = ""
                var postnr = ""
                
                
                if(udlejid != self.userID){
                    if let udlejValue = childUdlejSnapshot.value as? NSDictionary{
                        virkNavn = udlejValue["virkNavn"] as? String ?? ""
                        virkAdresse = udlejValue["virkAdresse"] as? String ?? ""
                        postnr = udlejValue["postnr"] as? String ?? ""
                    }
                    
                }
                
                if(udlejid == self.userID!){
                    for med in (VirkSingleton.shared.virksomhed?.medarbejdere)!{
                        if(med.id == medid){
                            med.ledig = false
                        }
                    }
                }
                else{
                    let ledigMedarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: alder, arbejdsomraade: arbejdsområde)
                    let udlejVirksomhed = Virksomhed(virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, id: udlejid)
                    let udlejning = Aftaler(id: aftaleid, medarbejder: ledigMedarbejder, loen: loen, startDato: startperiode, slutDato: slutperiode, udlejer: udlejVirksomhed, indlejer: nil, kommentar: kommentar)
                    
                    VirkSingleton.shared.ledigFolk.append(udlejning)
                    print("medarbejder navn til udlejning",VirkSingleton.shared.ledigFolk[0].medarbejder.navn)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("readUdlejede"), object: self)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func readMineAftaler(){
        
        ref.child("ledig").queryOrdered(byChild: "aktiv").queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (snapshot) in
            //            let aft_array:NSArray = snapshot.children.allObjects as NSArray
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                print(snapshot.childrenCount)
                
                
                //                let snapshot:DataSnapshot = child as! DataSnapshot
                let aftaleid = child.key
                
                let aftvalue = child.value as? NSDictionary
                let loen = aftvalue!["loen"] as? String ?? ""
                let startperiode = aftvalue!["startperiode"] as? String ?? ""
                let slutperiode = aftvalue!["slutperiode"] as? String ?? ""
                let kommentar = aftvalue!["kommentar"] as? String ?? ""
                print("loen",loen)
                
                
                
                let childMedarbSnapshot = child.childSnapshot(forPath: "medarbejder")
                let childUdlejSnapshot = child.childSnapshot(forPath: "lejer")
                print(childUdlejSnapshot.key)
                let medid = childMedarbSnapshot.key
                var mednavn = ""
                var alder = ""
                var arbejdsområde = ""
                
                print("medid", medid)
                
                let medValue = childMedarbSnapshot.value as? NSDictionary
                mednavn = medValue?["navn"] as? String ?? "1"
                alder = medValue?["fødselsår"] as? String ?? "1"
                arbejdsområde = medValue?["arbejdsområde"] as? String ?? "1"
                
                print("medNavn", mednavn)
                
                //                let udlejSnapshot:DataSnapshot = child as! DataSnapshot
                let udlejid = childUdlejSnapshot.key
                //                        getudlejid.key
                
                
                var virkNavn = ""
                var virkAdresse = ""
                var postnr = ""
                
                
                if(udlejid != self.userID){
                    if let udlejValue = childUdlejSnapshot.value as? NSDictionary{
                        virkNavn = udlejValue["virkNavn"] as? String ?? ""
                        virkAdresse = udlejValue["virkAdresse"] as? String ?? ""
                        postnr = udlejValue["postnr"] as? String ?? ""
                    }
                    
                }
                
                if(udlejid == self.userID!){
                    for med in (VirkSingleton.shared.virksomhed?.medarbejdere)!{
                        if(med.id == medid){
                            med.ledig = false
                        }
                    }
                }
                else{
                    let ledigMedarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: alder, arbejdsomraade: arbejdsområde)
                    let udlejVirksomhed = Virksomhed(virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, id: udlejid)
                    let udlejning = Aftaler(id: aftaleid, medarbejder: ledigMedarbejder, loen: loen, startDato: startperiode, slutDato: slutperiode, udlejer: udlejVirksomhed, indlejer: nil, kommentar: kommentar)
                    
                    VirkSingleton.shared.ledigFolk.append(udlejning)
                    print("medarbejder navn til udlejning",VirkSingleton.shared.ledigFolk[0].medarbejder.navn)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("readUdlejede"), object: self)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

