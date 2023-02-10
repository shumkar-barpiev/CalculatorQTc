//
//  ResultViewController.swift
//  CalculatorQTc
//
//  Created by User on 8/2/23.
//

import UIKit



class ResultViewController: UIViewController {
//  MARK: result labels
    @IBOutlet weak var bazetResultLabel: UILabel!
    @IBOutlet weak var fridericiaResultLabel: UILabel!
    @IBOutlet weak var dmitrienkoResultLabel: UILabel!
    @IBOutlet weak var framinghamResultLabel: UILabel!
    @IBOutlet weak var hodgesResultLabel: UILabel!
    @IBOutlet weak var rautaharjuResultLabel: UILabel!
    
    @IBOutlet weak var bogossianQRSLabel: UILabel!
    @IBOutlet weak var rautaharjuQRSLabel: UILabel!
    @IBOutlet weak var wangQRSLabel: UILabel!
    @IBOutlet weak var qtcQRSLabel: UILabel!
    
//  MARK: status labels
    @IBOutlet weak var bazettStatusLabel: UILabel!
    @IBOutlet weak var fridericiaStatusLabel: UILabel!
    @IBOutlet weak var dmitrienkoStatusLabel: UILabel!
    @IBOutlet weak var framinghamStatusLabel: UILabel!
    @IBOutlet weak var hodgesStatusLabel: UILabel!
    @IBOutlet weak var rautaharjuStatusLabel: UILabel!
    
    
    @IBOutlet weak var bogossianQRSStatusLabel: UILabel!
    @IBOutlet weak var rautaharjuQRSStatusLabel: UILabel!
    @IBOutlet weak var wangQRSStatusLabel: UILabel!
    @IBOutlet weak var qtcQRSStatusLabel: UILabel!
    
//    MARK: calculation Objects
    var bazett = CalculatorModel()
    var fridericia = CalculatorModel()
    var dmitrienko = CalculatorModel()
    var framingham = CalculatorModel()
    var hodges = CalculatorModel()
    var rautaharju = CalculatorModel()
    
    var bogossian = CalculatorModel()
    var rautaharjuQRS = CalculatorModel()
    var wang = CalculatorModel()
    var qtc = CalculatorModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        MARK: bazet
        bazetResultLabel.text = "\(Int(round(bazett.calculationResult)))"
        bazettStatusLabel.text = bazett.calculationStatus
        bazettStatusLabel.backgroundColor = bazett.calculationStatusColor
        bazettStatusLabel.textColor = bazett.calculationStatusTextColor
        
//        MARK: fridericia
        fridericiaResultLabel.text = "\(Int(round(fridericia.calculationResult)))"
        fridericiaStatusLabel.text = fridericia.calculationStatus
        fridericiaStatusLabel.backgroundColor = fridericia.calculationStatusColor
        fridericiaStatusLabel.textColor = fridericia.calculationStatusTextColor

//        MARK: dmitrienko
        dmitrienkoResultLabel.text = "\(Int(round(dmitrienko.calculationResult)))"
        dmitrienkoStatusLabel.text = dmitrienko.calculationStatus
        dmitrienkoStatusLabel.backgroundColor = dmitrienko.calculationStatusColor
        dmitrienkoStatusLabel.textColor = dmitrienko.calculationStatusTextColor

//        MARK: framingham
        framinghamResultLabel.text = "\(Int(round(framingham.calculationResult)))"
        framinghamStatusLabel.text = framingham.calculationStatus
        framinghamStatusLabel.backgroundColor = framingham.calculationStatusColor
        framinghamStatusLabel.textColor = framingham.calculationStatusTextColor

//        MARK: hodges
        hodgesResultLabel.text = "\(Int(round(hodges.calculationResult)))"
        hodgesStatusLabel.text = hodges.calculationStatus
        hodgesStatusLabel.backgroundColor = hodges.calculationStatusColor
        hodgesStatusLabel.textColor = hodges.calculationStatusTextColor

//        MARK: rautaharju
        rautaharjuResultLabel.text = "\(Int(round(rautaharju.calculationResult)))"
        rautaharjuStatusLabel.text = rautaharju.calculationStatus
        rautaharjuStatusLabel.backgroundColor = rautaharju.calculationStatusColor
        rautaharjuStatusLabel.textColor = rautaharju.calculationStatusTextColor
        
        
    }
    
    
    @IBAction func goBackAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: false, completion: nil)
    }
}
