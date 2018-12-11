//
//  Aftale.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 06/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import Foundation

class Aftaler {
    
    var id:String
    var medarbejder:Medarbejder
    var loen:String
    var startDato:String
    var slutDato:String
    var udlejer:Virksomhed?
    var indlejer:Virksomhed?
    var kommentar:String
    
    init(id:String, medarbejder:Medarbejder, loen:String, startDato:String, slutDato:String, udlejer:Virksomhed?, indlejer:Virksomhed?, kommentar:String){
        self.id = id
        self.medarbejder = medarbejder
        self.loen = loen
        self.startDato = startDato
        self.slutDato = slutDato
        self.udlejer = udlejer
        self.indlejer = indlejer
        self.kommentar = kommentar
    }
    
    
    
}

