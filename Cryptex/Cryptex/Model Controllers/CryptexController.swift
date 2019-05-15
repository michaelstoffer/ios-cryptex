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
        self.randomCryptex()
        self.loadFromPersistentStore()
    }
    
    private (set) var cryptexes: [Cryptex] = [Cryptex(password: "CRYPTEX", hint: "The thing you are trying to solve right now"), Cryptex(password: "CRUD", hint: "The 4 basic functions of persistent storage"), Cryptex(password: "SWIFT", hint: "The programming language you are learning")]
    
    var currentCryptex: Cryptex?
    
    private var cryptexURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("Cryptex.plist")
    }
    
    func createCryptex(withPassword password: String, withHint hint: String) {
        let cryptex = Cryptex(password: password, hint: hint)
        cryptexes.append(cryptex)
        self.saveToPersistentStore()
    }
    
    func randomCryptex() {
        self.currentCryptex = self.cryptexes.randomElement()
    }
    
    func saveToPersistentStore() {
        guard let url = self.cryptexURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.cryptexes)
            try data.write(to: url)
        } catch {
            NSLog("Error saving cryptexes data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = self.cryptexURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.cryptexes = try decoder.decode([Cryptex].self, from: data)
        } catch {
            NSLog("Error loading cryptexes data: \(error)")
        }
    }
}
