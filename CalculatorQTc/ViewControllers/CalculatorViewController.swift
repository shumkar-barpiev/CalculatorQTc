//
//  CalculatorViewController.swift
//  CalculatorQTc
//
//  Created by User on 8/2/23.
//

import UIKit

extension String {
    var isNumber: Bool {
        return self.allSatisfy { character in
            character.isNumber

        }
    }
}

class CalculatorViewController: UIViewController {

    
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var speedEKGSegmentControl: UISegmentedControl!
    @IBOutlet weak var chssTextField: UITextField!
    @IBOutlet weak var qtTextField: UITextField!
    @IBOutlet weak var qrsTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    
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

    
// MARK: temporary variables
    var qt = 0
    var chss = 0
    var qrs = 0
    var RR = 0
    var speedEKG = 0.0
    var k = 0.0
    var qrsController = false
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculateButton.layer.cornerRadius = 15
    }
    
    @IBAction func calculateButtonAction(_ sender: Any) {
        switch speedEKGSegmentControl.selectedSegmentIndex {
            case 0:
                speedEKG = 0.25
                break
            case 1:
                speedEKG = 0.5
                break
            default: break
        }
        switch genderSegmentControl.selectedSegmentIndex {
            case 0:
            k = -22.0
                break
            case 1:
            k = -34.0
                break
            default: break
        }
        
        
        
        
        if (!(chssTextField.text?.isEmpty ?? true)! && !(qtTextField.text?.isEmpty ?? true)!){
            let chssNumber = chssTextField.text!
            let rangeCHSS = NSRange(location: 0, length: chssNumber.utf16.count)
            let regexCHSS = try! NSRegularExpression(pattern: "[0-9].[0-9]")
            
            
            if regexCHSS.firstMatch(in: chssNumber, options: [], range: rangeCHSS) != nil || (chssTextField.text?.isNumber)!{
                
                let tempArr = Array(chssNumber)
                var switchController = true
                
                for i in tempArr{
                    if i.isLetter{
                        switchController = false
                        break
                    }
                }
                
                if switchController{
                    if let chssDouble = Double("\(chssNumber)"){
                        chss = Int(round(chssDouble))
                    }else{
                        chss = Int(chssNumber)!
                    }
                }else{
                    let alertController = UIAlertController(title: "Введите правилное данные на ЧСС!", message: "", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                        
                    }
                    alertController.addAction(alertAction)
                    present(alertController, animated: false, completion: nil)
                }
            }else{
                let alertController = UIAlertController(title: "Введите правилное данные на ЧСС!", message: "", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                    
                }
                alertController.addAction(alertAction)
                present(alertController, animated: false, completion: nil)
            }
            
            
            let qtNumber = qtTextField.text!
            let rangeQT = NSRange(location: 0, length: qtNumber.utf16.count)
            let regexQT = try! NSRegularExpression(pattern: "[0-9].[0-9]")
            
            
            if regexQT.firstMatch(in: qtNumber, options: [], range: rangeQT) != nil || (qtTextField.text?.isNumber)!{
                
                let tempArr = Array(qtNumber)
                var switchController = true
                
                for i in tempArr{
                    if i.isLetter{
                        switchController = false
                        break
                    }
                }
                
                if switchController{
                    if let qtDouble = Double("\(qtNumber)"){
                        qt = Int(round(qtDouble))
                    }else{
                        qt = Int(qtNumber)!
                    }
                }else{
                    let alertController = UIAlertController(title: "Введите правилное данные на QT!", message: "", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                        
                    }
                    alertController.addAction(alertAction)
                    present(alertController, animated: false, completion: nil)
                }
                
            }else{
                let alertController = UIAlertController(title: "Введите правилное данные на QT!", message: "", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                    
                }
                alertController.addAction(alertAction)
                present(alertController, animated: false, completion: nil)
            }
            
            
            let RR = 60.0/Double(chss)
            let QT = Double(qt*10) / speedEKG
            
            if !(qrsTextField.text?.isEmpty ?? true)!{
                self.qrsController = true
                let qrsNumber = qrsTextField.text!
                let rangeQRS = NSRange(location: 0, length: qrsNumber.utf16.count)
                let regexQRS = try! NSRegularExpression(pattern: "[0-9].[0-9]")
                
                
                if regexQRS.firstMatch(in: qrsNumber, options: [], range: rangeQRS) != nil || (qrsTextField.text?.isNumber)!{
                    
                    let tempArr = Array(qrsNumber)
                    var switchController = true
                    
                    for i in tempArr{
                        if i.isLetter{
                            switchController = false
                            break
                        }
                    }
                    
                    if switchController{
                        if let qrsDouble = Double("\(qrsNumber)"){
                            qrs = Int(round(qrsDouble))
                        }else{
                            qrs = Int(qrsNumber)!
                        }
                        
                        let tempQrsQt = Double(qrs*10) / speedEKG
                        
                        bogossian.calculationResult = QT - (0.48 * tempQrsQt)
//                        print("bogossian = \(bogossian.calculationResult)")
                        
                        
                        rautaharjuQRS.calculationResult = QT - 155.0 * (60.0 / Double(chss) - 1.0) - 0.93 * (tempQrsQt - 139.0) + k
//                        print("rautaharjuQRS = \(rautaharjuQRS.calculationResult)")
                        
                        
                        wang.calculationResult = QT - (0.86 * tempQrsQt - 71.0)
//                        print("wang = \(wang.calculationResult)")
                        
                        
                    }else{
                        let alertController = UIAlertController(title: "Введите правилное данные на QRS!", message: "", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                            
                        }
                        alertController.addAction(alertAction)
                        present(alertController, animated: false, completion: nil)
                    }
                }else{
                    let alertController = UIAlertController(title: "Введите правилное данные на QRS!", message: "", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                        
                    }
                    alertController.addAction(alertAction)
                    present(alertController, animated: false, completion: nil)
                }
                
                
                
            }
            
            if Int(qt) > 0 && Int(chss) > 0 {
                bazett.calculationResult = QT / pow(RR, 0.5)
    //                print("bazet result = \(bazett.calculationResult)")
                
                fridericia.calculationResult = QT / pow(RR, 1/3)
    //                print("fridericia result = \(fridericia.calculationResult)")
                
                dmitrienko.calculationResult = QT / pow(RR, 0.413)
    //                print("dmitrienko result = \(dmitrienko.calculationResult)")
                
                framingham.calculationResult = QT + 154 * (1 - RR)
    //                print("framingham result = \(framingham.calculationResult)")
                
                hodges.calculationResult = QT + 1.75*(Double(chss) - 60.0)
    //                print("hodges result = \(hodges.calculationResult)")
                
                rautaharju.calculationResult = QT + 242.51 - 434.0 * pow(2.718281828, -0.0097*Double(chss))
    //                print("rautaharju result = \(rautaharju.calculationResult)")
               
                
                
                
                switch genderSegmentControl.selectedSegmentIndex {
                    case 0:
    //                    MARK: bazett calculation male
                        if bazett.calculationResult < 430{
                            bazett.calculationStatus = "Нормальный"
                            bazett.calculationStatusColor = UIColor.green
                        }else if bazett.calculationResult > 430 && bazett.calculationResult < 450{
                            bazett.calculationStatus = "Пограничный"
                            bazett.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            bazett.calculationStatus = "Удлинённый"
                            bazett.calculationStatusColor = UIColor.red
                            bazett.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: fridericia calculation male
                        if fridericia.calculationResult < 429{
                            fridericia.calculationStatus = "Нормальный"
                            fridericia.calculationStatusColor = UIColor.green
                        }else if fridericia.calculationResult > 429 && fridericia.calculationResult < 441{
                            fridericia.calculationStatus = "Пограничный"
                            fridericia.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            fridericia.calculationStatus = "Удлинённый"
                            fridericia.calculationStatusColor = UIColor.red
                            fridericia.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: dmitrienko calculation male
                        if dmitrienko.calculationResult < 430{
                            dmitrienko.calculationStatus = "Нормальный"
                            dmitrienko.calculationStatusColor = UIColor.green
                        }else if dmitrienko.calculationResult > 430 && dmitrienko.calculationResult < 442{
                            dmitrienko.calculationStatus = "Пограничный"
                            dmitrienko.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            dmitrienko.calculationStatus = "Удлинённый"
                            dmitrienko.calculationStatusColor = UIColor.red
                            dmitrienko.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: framingham calculation male
                        if framingham.calculationResult < 428{
                            framingham.calculationStatus = "Нормальный"
                            framingham.calculationStatusColor = UIColor.green
                        }else if framingham.calculationResult > 428 && framingham.calculationResult < 440{
                            framingham.calculationStatus = "Пограничный"
                            framingham.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            framingham.calculationStatus = "Удлинённый"
                            framingham.calculationStatusColor = UIColor.red
                            framingham.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: hodges calculation male
                        if hodges.calculationResult < 428{
                            hodges.calculationStatus = "Нормальный"
                            hodges.calculationStatusColor = UIColor.green
                        }else if hodges.calculationResult > 428 && hodges.calculationResult < 441{
                            hodges.calculationStatus = "Пограничный"
                            hodges.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            hodges.calculationStatus = "Удлинённый"
                            hodges.calculationStatusColor = UIColor.red
                            hodges.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: rautaharju calculation male
                        if rautaharju.calculationResult < 431{
                            rautaharju.calculationStatus = "Нормальный"
                            rautaharju.calculationStatusColor = UIColor.green
                        }else if rautaharju.calculationResult > 431 && rautaharju.calculationResult < 443{
                            rautaharju.calculationStatus = "Пограничный"
                            rautaharju.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            rautaharju.calculationStatus = "Удлинённый"
                            rautaharju.calculationStatusColor = UIColor.red
                            rautaharju.calculationStatusTextColor = UIColor.white
                        }
                    
                    
                        break
                    case 1:
    //                    MARK: bazett calculation female
                        if bazett.calculationResult < 440{
                            bazett.calculationStatus = "Нормальный"
                            bazett.calculationStatusColor = UIColor.green
                        }else if bazett.calculationResult > 440 && bazett.calculationResult < 460{
                            bazett.calculationStatus = "Пограничный"
                            bazett.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            bazett.calculationStatus = "Удлинённый"
                            bazett.calculationStatusColor = UIColor.red
                            bazett.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: fridericia calculation female
                        if fridericia.calculationResult < 438{
                            fridericia.calculationStatus = "Нормальный"
                            fridericia.calculationStatusColor = UIColor.green
                        }else if fridericia.calculationResult > 438 && fridericia.calculationResult < 451{
                            fridericia.calculationStatus = "Пограничный"
                            fridericia.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            fridericia.calculationStatus = "Удлинённый"
                            fridericia.calculationStatusColor = UIColor.red
                            fridericia.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: dmitrienko calculation female
                        if dmitrienko.calculationResult < 440{
                            dmitrienko.calculationStatus = "Нормальный"
                            dmitrienko.calculationStatusColor = UIColor.green
                        }else if dmitrienko.calculationResult > 440 && dmitrienko.calculationResult < 460{
                            dmitrienko.calculationStatus = "Пограничный"
                            dmitrienko.calculationStatusColor = UIColor.yellow
                        
                        }else{
                            dmitrienko.calculationStatus = "Удлинённый"
                            dmitrienko.calculationStatusColor = UIColor.red
                            dmitrienko.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: framingham calculation female
                        if framingham.calculationResult < 438{
                            framingham.calculationStatus = "Нормальный"
                            framingham.calculationStatusColor = UIColor.green
                        }else if framingham.calculationResult > 438 && framingham.calculationResult < 450{
                            framingham.calculationStatus = "Пограничный"
                            framingham.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            framingham.calculationStatus = "Удлинённый"
                            framingham.calculationStatusColor = UIColor.red
                            framingham.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: hodges calculation female
                        if hodges.calculationResult < 436{
                            hodges.calculationStatus = "Нормальный"
                            hodges.calculationStatusColor = UIColor.green
                        }else if hodges.calculationResult > 436 && hodges.calculationResult < 449{
                            hodges.calculationStatus = "Пограничный"
                            hodges.calculationStatusColor = UIColor.yellow
                           
                        }else{
                            hodges.calculationStatus = "Удлинённый"
                            hodges.calculationStatusColor = UIColor.red
                            hodges.calculationStatusTextColor = UIColor.white
                        }
                    
    //                    MARK: rautaharju calculation female
                        if rautaharju.calculationResult < 440{
                            rautaharju.calculationStatus = "Нормальный"
                            rautaharju.calculationStatusColor = UIColor.green
                        }else if rautaharju.calculationResult > 440 && rautaharju.calculationResult < 454{
                            rautaharju.calculationStatus = "Пограничный"
                            rautaharju.calculationStatusColor = UIColor.yellow
                            
                        }else{
                            rautaharju.calculationStatus = "Удлинённый"
                            rautaharju.calculationStatusColor = UIColor.red
                            rautaharju.calculationStatusTextColor = UIColor.white
                        }
                        break
                    default: break
                    
                }
                    let controller = storyboard?.instantiateViewController(withIdentifier: "ResultNavViewController") as! ResultNavViewController
                    
                    let vc = controller.topViewController as! ResultViewController
                    
                    vc.bazett = self.bazett
                    vc.fridericia = self.fridericia
                    vc.dmitrienko = self.dmitrienko
                    vc.framingham = self.framingham
                    vc.hodges = self.hodges
                    vc.rautaharju = self.rautaharju
                
                    if qrsController{
                        vc.bogossian = self.bogossian
                        vc.rautaharjuQRS = self.rautaharjuQRS
                        vc.wang = self.wang
                        vc.qtc = self.qtc
                    }
                    
                    controller.modalPresentationStyle = .fullScreen
                    present(controller, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Введенные данные должны быть больше нуля!", message: "", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                    
                }
                alertController.addAction(alertAction)
                present(alertController, animated: false, completion: nil)
            }
        }else{
            let alertController = UIAlertController(title: "Введите достаточное данные!", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Хорошо", style: .cancel) { _ in
                
            }
            alertController.addAction(alertAction)
            present(alertController, animated: false, completion: nil)
        }
    }
}
