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
    var foedselsaar:String
    var adresse = "" // Skal fjernes
    var loen = ""
    var arbejdsomraade:String
    var id:String
    var kommentar = ""
    var ledig = false
    
    init(navn: String , id: String , foedselsaarr: String, arbejdsomraade:String){
        self.navn = navn
        self.foedselsaar = foedselsaarr
        self.id = id
        self.arbejdsomraade = arbejdsomraade
    }
    
}
