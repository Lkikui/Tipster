//
//  ViewController.swift
//  Tipster
//
//  Created by Lisa Ryland on 1/11/18.
//  Copyright © 2018 Lisa Ryland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tipIncrement: [Float] = [0, 0.05, 0.10]
    var runningTotal: (Float, String) = (0.00, "")
    
    @IBOutlet weak var beforeTipLabel: UILabel!
    @IBOutlet weak var groupSizeLabel: UILabel!
    @IBOutlet weak var decimalButton: UIButton!
    
    @IBOutlet var percentageLabels: [UILabel]!
    @IBOutlet var tipPerPersonLabel: [UILabel]!
    @IBOutlet var totalWithTipLabel: [UILabel]!
    
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var groupSizeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beforeTipLabel.text = "0.00"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button7(_ sender: UIButton) {
        if sender == decimalButton {
            sender.isEnabled = false
        }
        runningTotal.1 += sender.currentTitle!
        runningTotal.0 = Float(runningTotal.1)!
        
        beforeTipLabel.text = runningTotal.1
        updateTotal()
    }
    
    @IBAction func tipSliderMoved(_ sender: UISlider) {
        self.updateTotal()
        percentageLabels.enumerated().forEach {
            index, percentageLabel in
            percentageLabel.text = String((sender.value + tipIncrement[index]) * 100)
        }
    }
    
    @IBAction func groupSizeSliderMoved(_ sender: UISlider) {
        groupSizeLabel.text = "Group Size: \(Int(round(sender.value)))"
        self.updateTotal()
    }
    
    func updateTotal() {
        tipPerPersonLabel.enumerated().forEach {
            index, tipLabel in
            let updatedTip = ((tipSlider.value + tipIncrement[index]) * runningTotal.0)
            tipLabel.text = String(updatedTip / round(groupSizeSlider.value))
            totalWithTipLabel[index].text = String(runningTotal.0 + updatedTip)
        }
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        beforeTipLabel.text = "0.00"
        tipSlider.value = 0.05
        groupSizeSlider.value = 1
        decimalButton.isEnabled = true
        runningTotal = (0.00, "")
        
        percentageLabels.enumerated().forEach {
            index, percentageLabel in
            percentageLabel.text = String((tipSlider.value + tipIncrement[index]) * 100)
            tipPerPersonLabel[index].text = "0.00"
            totalWithTipLabel[index].text = "0.00"
        }
    }
}

