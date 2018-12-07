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
            
           // self.writeAftaler()
            self.readMedarbejder()
            self.readUdlej()
            self.readMineAftaler()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func gemMedarbejter(navn: String, alder: String, arbejdsområde:String, loen:String, kommentar:String, startdato:String, slutdato:String){
        let medarb = ref.child("user").child(userID!).child("medarbejdere").childByAutoId()
        medarb.setValue(["navn": navn, "fødselsår": alder, "loen": loen, "arbejdsområde": arbejdsområde, "kommentar":kommentar])
        
        
    }
    
    
    func writeAftaler(){
        let med1 = ref.child("user").child(userID!).child("medarbejdere").childByAutoId()
        med1.setValue(["navn": "Gunn", "fødselsår": "1992", "adresse": "Dalslandsgade 8G", "loen": "32000", "arbejdsområde": "Smed", "kommentar":""])
        let med1id = med1.key

        ref.child("medarbejdere").child(med1id!).setValue(["navn": "Gunn", "fødselsår": "1992", "adresse": "Dalslandsgade 8G", "loen": "32000", "arbejdsområde": "Smed", "kommentar": "", "Virksomhedid":userID])

        let med2 = ref.child("user").child(userID!).child("medarbejdere").childByAutoId()
        med2.setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar":""])
        let med2id = med2.key

        ref.child("medarbejdere").child(med2id!).setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar": "", "Virksomhedid":userID])


        let aft1 = ref.child("aftaler").childByAutoId()
        aft1.setValue(["loen": "32000", "startperiode": "1/12-18", "slutperiode": "1/1-19", "aktiv": true])
        let aft1id = aft1.key
        
        let virk1id = "UcwtMYrS0OWvsSIChzfphTo6uJ33"
        let virk2id = userID
        
        ref.child("aftaler").child(aft1id!).child("medarbejder").setValue(["navn": "Gunn", "fødselsår": "1992", "adresse": "Dalslandsgade 8G", "loen": "32000", "arbejdsområde": "Smed", "kommentar":"", "id":med1id!])
        ref.child("aftaler").child(aft1id!).child("lejer").setValue(["id": userID, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        ref.child("aftaler").child(aft1id!).child("udlejer").setValue(["id": "UcwtMYrS0OWvsSIChzfphTo6uJ33", "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])

        
        let aft2 = ref.child("aftaler").childByAutoId()
        aft2.setValue(["loen": "32000", "startperiode": "1/12-18", "slutperiode": "1/1-19", "aktiv": true])
        let aft2id = aft2.key
        ref.child("ledig").child(aft2id!).child("medarbejder").setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar":"", "id": med2id!])
        ref.child("ledig").child(aft2id!).child("lejer").setValue(["id": userID, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        ref.child("ledig").child(aft2id!).child("lejer").setValue(["id": virk1id, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        
        let aft3 = ref.child("aftaler").childByAutoId()
        aft3.setValue(["loen": "32000", "startperiode": "1/12-18", "slutperiode": "1/1-19", "aktiv": true])
        let aft3id = aft3.key
        ref.child("ledig").child(aft3id!).child("medarbejder").setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar":"", "id": med2id!])
        ref.child("ledig").child(aft3id!).child("lejer").setValue(["id": virk1id, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        ref.child("ledig").child(aft3id!).child("lejer").setValue(["id": virk2id, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        
        let aft4 = ref.child("aftaler").childByAutoId()
        aft4.setValue(["loen": "32000", "startperiode": "1/12-18", "slutperiode": "1/1-19", "aktiv": true])
        let aft4id = aft4.key
        ref.child("ledig").child(aft4id!).child("medarbejder").setValue(["navn": "Janus", "fødselsår": "1991", "adresse": "Herlev", "postnr": "2500", "loen": "32000", "arbejdsområde": "Tømrer", "kommentar":"", "id": med1id!])
        ref.child("ledig").child(aft4id!).child("lejer").setValue(["id": virk1id, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
        ref.child("ledig").child(aft4id!).child("lejer").setValue(["id": virk2id, "virkNavn": VirkSingleton.shared.virksomhed?.virkNavn, "virkAdresse":VirkSingleton.shared.virksomhed?.virkAdresse, "postnr":VirkSingleton.shared.virksomhed?.postnr])
    }
    
    func readMedarbejder(){
        ref.child("user").child(userID!).child("medarbejdere").observeSingleEvent(of: .value, with: { (snapshot) in
            let array:NSArray = snapshot.children.allObjects as NSArray
            for obj in array {
                
                let snapshot:DataSnapshot = obj as! DataSnapshot
                let medid = snapshot.key
                if let childSnapshot = snapshot.value as? [String : AnyObject]{
                    let mednavn = childSnapshot["navn"] as? String ?? ""
                    let medaar = childSnapshot["fødselsår"] as? String ?? ""
                    let medarbejdsom = childSnapshot["arbejdsområde"] as? String ?? ""
                    let medloen = childSnapshot["loen"] as? String ?? ""
                    let medkommentar = childSnapshot["kommentar"] as? String ?? ""
                    
                    let medarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: medaar, arbejdsomraade: medarbejdsom)
                    medarbejder.loen = medloen
                    medarbejder.kommentar = medkommentar
                    VirkSingleton.shared.virksomhed?.medarbejdere.append(medarbejder)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("readData"), object: self)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    func readUdlej(){
        
        ref.child("ledig").queryOrdered(byChild: "aktiv").queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (snapshot) in
            //            let aft_array:NSArray = snapshot.children.allObjects as NSArray
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                
                
                //                let snapshot:DataSnapshot = child as! DataSnapshot
                let aftaleid = child.key
                
                let aftvalue = child.value as? NSDictionary
                let loen = aftvalue!["loen"] as? String ?? ""
                let startperiode = aftvalue!["startperiode"] as? String ?? ""
                let slutperiode = aftvalue!["slutperiode"] as? String ?? ""
                let kommentar = aftvalue!["kommentar"] as? String ?? ""
                
                
                
                let childMedarbSnapshot = child.childSnapshot(forPath: "medarbejder")
                let childUdlejSnapshot = child.childSnapshot(forPath: "lejer")
                let medid = childMedarbSnapshot.key
                var mednavn = ""
                var alder = ""
                var arbejdsområde = ""
                
                let medValue = childMedarbSnapshot.value as? NSDictionary
                mednavn = medValue?["navn"] as? String ?? ""
                alder = medValue?["fødselsår"] as? String ?? ""
                arbejdsområde = medValue?["arbejdsområde"] as? String ?? ""
                
                
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
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("readData"), object: self)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func readMineAftaler(){
        
        ref.child("aftaler").queryOrdered(byChild: "aktiv").queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (snapshot) in
            //            let aft_array:NSArray = snapshot.children.allObjects as NSArray
            
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                
                //                let snapshot:DataSnapshot = child as! DataSnapshot
                let aftaleid = child.key
                
                let aftvalue = child.value as? NSDictionary
                let loen = aftvalue!["loen"] as? String ?? ""
                let startperiode = aftvalue!["startperiode"] as? String ?? ""
                let slutperiode = aftvalue!["slutperiode"] as? String ?? ""
                let kommentar = aftvalue!["kommentar"] as? String ?? ""
             //   print("loen",loen)
                
                
                
                let childMedarbSnapshot = child.childSnapshot(forPath: "medarbejder")
                let childUdlejSnapshot = child.childSnapshot(forPath: "Udlejer")
                let childLejSnapshot = child.childSnapshot(forPath: "lejer")
                
                let medid = childMedarbSnapshot.key
                var mednavn = ""
                var alder = ""
                var arbejdsområde = ""
                
            //    print("medid", medid)
                
                let medValue = childMedarbSnapshot.value as? NSDictionary
                mednavn = medValue?["navn"] as? String ?? ""
                alder = medValue?["fødselsår"] as? String ?? ""
                arbejdsområde = medValue?["arbejdsområde"] as? String ?? ""

                
                
                var virkNavn = ""
                var virkAdresse = ""
                var postnr = ""
                var lejid = ""
                var udlejid = ""
                
                if let udlejValue = childUdlejSnapshot.value as? NSDictionary{
                    virkNavn = udlejValue["virkNavn"] as? String ?? ""
                    virkAdresse = udlejValue["virkAdresse"] as? String ?? ""
                    postnr = udlejValue["postnr"] as? String ?? ""
                    udlejid = udlejValue["id"] as? String ?? ""
                    print("virkudlejNavn:",virkNavn)
                }
                if let lejValue = childLejSnapshot.value as? NSDictionary{
                    virkNavn = lejValue["virkNavn"] as? String ?? ""
                    virkAdresse = lejValue["virkAdresse"] as? String ?? ""
                    postnr = lejValue["postnr"] as? String ?? ""
                    lejid = lejValue["id"] as? String ?? ""
                    print("virkindlejNavn: ",virkNavn)
                    
                }
                
                print("udlejid:",udlejid, "userId:", self.userID, "lejid:", lejid)
                if((udlejid == self.userID) || (lejid == self.userID)){
                    print("Kom igennem if")
                    let ledigMedarbejder = Medarbejder(navn: mednavn, id: medid, foedselsaarr: alder, arbejdsomraade: arbejdsområde)
                    let udlejVirksomhed = Virksomhed(virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, id: udlejid)
                    let lejVirksomhed = Virksomhed(virkNavn: virkNavn, virkAdresse: virkAdresse, postnr: postnr, id: lejid)
                    let aftale = Aftaler(id: aftaleid, medarbejder: ledigMedarbejder, loen: loen, startDato: startperiode, slutDato: slutperiode, udlejer: udlejVirksomhed, indlejer: lejVirksomhed, kommentar: kommentar)
                    print("Startdato:",startperiode)
                    print("Slutdato:",slutperiode)
                    if(udlejid == self.userID){
                        print("Der kommer en udlejer!!!!")
                        VirkSingleton.shared.udlejedeFolk.append(aftale)
                    }
                    else {
                        VirkSingleton.shared.indlejedeFolk.append(aftale)
                        print("Der kommer en indlejer!!!!")
                    }
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("readAftaler"), object: self)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

