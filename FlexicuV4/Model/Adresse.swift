//
//  Adresse.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 16/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
class Adresse{
    var postNr: String? = ""
    var vej: String? = ""
    var husnummer: String? = ""
    
    init(postNr: String?, vej: String? , husnummer: String?){
        self.postNr = postNr
        self.vej = vej
        self.husnummer = husnummer
        
    }
}
