//
//  File.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 05/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import Foundation

class Virksomhed{
    
    var CVR = ""
    var virkNavn:String
    var virkAdresse:String
    var postnr:String
    var id:String
    var brugNavn = ""
    var brugEmail = ""
    var brugTlf = ""
    var medarbejdere: [Medarbejder] = []
    
    init(virkNavn:String, virkAdresse: String, postnr:String, id:String){
        
        self.virkNavn = virkNavn
        self.virkAdresse = virkAdresse
        self.postnr = postnr
        self.id = id
    }
}
