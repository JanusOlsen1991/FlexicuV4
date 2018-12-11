//
//  UdlejMedarbejder.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 30/11/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import UIKit

class LejUdlejMedarbejder: UIViewController {

    @IBOutlet weak var medarbejderNavn: UITextField!
    
    @IBOutlet weak var medarbejderAlder: UITextField!
    
    @IBOutlet weak var medarbejderArbejdsområde: UITextField!
    
    
    @IBOutlet weak var prisTotal: UITextField!
    @IBOutlet weak var flexicuFee: UITextField!
    @IBOutlet weak var samletPris: UITextField!
    @IBOutlet weak var kommentar: UITextView!
    @IBOutlet weak var slutdato: UITextField!
    @IBOutlet weak var startdato: UITextField!
    @IBOutlet weak var lejerUdlejer: UILabel!
    @IBOutlet weak var lejerNavn: UITextField!
    var aftale: Aftaler!
    var lejerOrUdlejer: String!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        medarbejderNavn.text = aftale.medarbejder.navn
        medarbejderAlder.text = aftale.medarbejder.foedselsaar
        medarbejderArbejdsområde.text = aftale.medarbejder.arbejdsomraade
        lejerNavn.text = aftale.udlejer?.virkNavn
        startdato.text = aftale.startDato
        slutdato.text = aftale.slutDato
        kommentar.text = aftale.kommentar
        samletPris.text = aftale.loen
//        String(startString.characters.prefix(2))
//        let num = Double(String((samletPris.text?.prefix(aftale.loen.count))!))
//        let fee = num!*0.025
//        flexicuFee.text = fee as? String
//        prisTotal.text = num!+fee as! String
//
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lejBtnPressed(_ sender: Any) {
        if(lejerOrUdlejer == "lejer"){
            VirkSingleton.shared.dao.gemAftaleIndgaaet(medarbejder: aftale.medarbejder, udlejer: aftale.udlejer!, lejer: VirkSingleton.shared.virksomhed!, startdato: aftale.startDato, slutdato: aftale.slutDato, loen: aftale.loen, aktiv: true)
            VirkSingleton.shared.indlejedeFolk.append(aftale)
            
            VirkSingleton.shared.dao.updateUdlej(aftaleid: aftale.id, aktiv: false)
//            var i=0
//            for aft in VirkSingleton.shared.ledigFolk{
//                i+=1
//                if(aftale.id == aft.id){
//                    VirkSingleton.shared.ledigFolk.remove(at: i)
//                }
//            }
//            a = a.filter { $0 != "two" }
            
            VirkSingleton.shared.indlejedeFolk = VirkSingleton.shared.indlejedeFolk.filter { $0 !== aftale }
            
        }
        else {
            VirkSingleton.shared.dao.gemUdlej(medarbejder: aftale.medarbejder, udlejer: aftale.udlejer!, loen: aftale.loen, startdato: aftale.startDato, slutdato: aftale.slutDato, kommentar: aftale.kommentar, aktiv: true)
        }
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "hovedMenu") as? HovedMenu
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    

    
}
