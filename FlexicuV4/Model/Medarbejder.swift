//
//  Medarbejder.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 16/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Medarbejder{
    
    var navn:String
    var foedselsaar:Int
    var adresse:String
    var postnr:String
    var loen:Int
    var arbejdsomraade:String
    var id:String
    
    
    init(navn: String , id: String , foedselsaarr: Int , adresse: String, postnr:String, loen: Int, arbejdsomraade:String){
        self.navn = navn
        self.foedselsaar = foedselsaarr
        self.adresse = adresse
        self.loen = loen
        self.id = id
        self.postnr = postnr
        self.arbejdsomraade = arbejdsomraade
    }
}
