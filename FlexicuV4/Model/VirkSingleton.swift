//
//  VirkSingleton.swift
//  FlexicuV4
//
//  Created by Gunn Hentze on 06/12/2018.
//  Copyright © 2018 DTu Diplom. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


class VirkSingleton{
    private init(){}
    static let shared = VirkSingleton()
    var virksomhed: Virksomhed?
    var ledigFolk: [Aftaler] = []
    var udlejedeFolk: [Aftaler] = []
    var indlejedeFolk: [Aftaler] = []
    var dao = DAO()
}
