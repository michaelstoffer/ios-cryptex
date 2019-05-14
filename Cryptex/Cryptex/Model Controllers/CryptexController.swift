//
//  CryptexController.swift
//  Cryptex
//
//  Created by Michael Stoffer on 5/14/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        createCryptex(withPassword: "CRYPTEX", withHint: "The thing you are trying to solve right now")
        createCryptex(withPassword: "CRUD", withHint: "The 4 basic functions of persistent storage")
        createCryptex(withPassword: "SWIFT", withHint: "The programming language you are learning")
        
        self.randomCryptex()
    }
    
    private (set) var cryptexes: [Cryptex] = []
    var currentCryptex: Cryptex?
    
    func createCryptex(withPassword password: String, withHint hint: String) {
        let cryptex = Cryptex(password: password, hint: hint)
        cryptexes.append(cryptex)
    }
    
    func randomCryptex() {
        self.currentCryptex = self.cryptexes.randomElement()
    }
}
