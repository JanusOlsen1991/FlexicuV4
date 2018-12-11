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
    var loen = ""
    var arbejdsomraade:String
    var id:String
    var kommentar = ""
    var ledig = false
    
    init(navn: String, id: String, foedselsaar: String, arbejdsomraade:String){
        self.navn = navn
        self.foedselsaar = foedselsaar
        self.id = id
        self.arbejdsomraade = arbejdsomraade
    }
    
}
