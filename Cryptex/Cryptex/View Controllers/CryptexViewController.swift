//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Michael Stoffer on 5/14/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    // MARK: - IBOutlets and Variables
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    var cryptexController: CryptexController = CryptexController()
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    var countdownTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cryptexPickerView.delegate = self
        self.cryptexPickerView.dataSource = self
        self.updateViews()
    }
    
    // MARK: - IBActions and Methods
    @IBAction func unlockButtonTapped(_ sender: UIButton) {
        if self.hasMatchingPassword() {
            print("Yay! You solved it!")
            self.reset()
        }
    }
    
    private func reset() {
        self.countdownTimer?.invalidate()
        self.countdownTimer = nil
        
        self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { timer in
            print("The timer has finished")
        })
        
        for index in 0...(self.cryptexPickerView!.numberOfComponents - 1) {
            self.cryptexPickerView!.selectRow(0, inComponent: index, animated: true)
        }
    }
    
    private func newCryptexAndReset() {
        self.cryptexController.randomCryptex()
        self.updateViews()
        self.reset()
    }
    
    private func updateViews() {
        self.hintLabel.text = self.cryptexController.currentCryptex?.hint
        self.cryptexPickerView.reloadAllComponents()
    }
}

extension CryptexViewController: UIPickerViewDelegate {
}

extension CryptexViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.cryptexController.currentCryptex!.password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.letters[row]
    }
    
    func hasMatchingPassword() -> Bool {
        var titles: [String] = []
        for index in 0...(self.cryptexPickerView!.numberOfComponents - 1) {
            titles.append(self.letters[self.cryptexPickerView!.selectedRow(inComponent: index)])
        }
        
        return titles.joined() == self.cryptexController.currentCryptex?.password.uppercased()
    }
}
