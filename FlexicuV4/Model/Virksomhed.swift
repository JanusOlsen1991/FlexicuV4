//
//  File.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 05/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import Foundation

class Virksomhed{
    
    var CVR:String
    var virkNavn:String
    var virkAdresse:String
    var postnr:String
    //    var id:String
    var brugNavn:String
    var brugEmail:String
    var brugTlf:String
    var medarbejdere: Array<Medarbejder> = Array()
    
    init(CVR: String , virkNavn:String, virkAdresse: String, postnr:String, /*id: String,*/ brugNavn:String, brugEmail:String, brugTlf:String){
        self.CVR = CVR
        self.virkNavn = virkNavn
        self.virkAdresse = virkAdresse
        self.postnr = postnr
        //        self.id = id
        self.brugNavn = brugNavn
        self.brugEmail = brugEmail
        self.brugTlf = brugTlf
    }
}
