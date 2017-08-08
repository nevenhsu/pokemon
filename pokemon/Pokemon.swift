//
//  Pokemon.swift
//  pokemon
//
//  Created by Neven on 06/08/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _dex: Double!
    private var _describeLbl: String!
    private var _defense: Double!
    private var _type: String!
    private var _height: Double!
    private var _weight: Double!
    private var _attack: Double!
    private var _evo: String!
    
    var name: String {
        return _name
    }
    
    var dex: Double {
        return _dex
    }
    
    init(name: String, dex: Double) {
        _name = name
        _dex = dex
    }
}
