//
//  MineMedarbejdere.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 19/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit


class MineMedarbejdere: UIViewController {


    @IBOutlet weak var navnTextField: UITextField!
    @IBOutlet weak var alderTextField: UITextField!
    @IBOutlet weak var arbejdsområdeTextField: UITextField!
    @IBOutlet weak var loenTextField: UITextField!
    @IBOutlet weak var kommentarTextField: UITextView!
    @IBOutlet weak var startdatoTextField: UITextField!
    @IBOutlet weak var slutdatoTextField: UITextField!
    
    @IBOutlet weak var distanceTextField: UITextField!
    
    var medarbejder: Medarbejder!
    var loen: String!
    var kommentar: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kommentarTextField.layer.cornerRadius = 5
        kommentarTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        kommentarTextField.layer.borderWidth = 0.5
        kommentarTextField.clipsToBounds = true
        
        if(medarbejder != nil) {
            navnTextField.text = medarbejder.navn
            alderTextField.text = medarbejder.foedselsaar
            arbejdsområdeTextField.text = medarbejder.arbejdsomraade
            loenTextField.text = loen
            kommentarTextField.text = kommentar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func gemBtnPressed(_ sender: Any) {
        if(erAltTastetInd()){
            // Hvis start og slut dato ikker er indtastet (medarbejder er ikke "ledig")
            if(slutdatoTextField.text == "" && startdatoTextField.text == "") {
                let id = VirkSingleton.shared.dao.gemMedarbejder(navn: navnTextField.text!, alder: alderTextField.text!, arbejdsområde: arbejdsområdeTextField.text!, loen: loenTextField.text!, kommentar: kommentarTextField.text!, ledig: true)
        
        
                medarbejder = Medarbejder(navn: navnTextField.text!, id: id, foedselsaar: alderTextField.text!, arbejdsomraade: arbejdsområdeTextField.text!)
                medarbejder.loen = loenTextField.text!
                medarbejder.kommentar = kommentarTextField.text!
                medarbejder.ledig = true
                VirkSingleton.shared.virksomhed?.medarbejdere.append(medarbejder)
            }
            else if((slutdatoTextField.text?.count)! > 0 && (startdatoTextField.text?.count)!>0){
                let id = VirkSingleton.shared.dao.gemMedarbejder(navn: navnTextField.text!, alder: alderTextField.text!, arbejdsområde: arbejdsområdeTextField.text!, loen: loenTextField.text!, kommentar: kommentarTextField.text!, ledig: false)
            
            
                let medarbejder = Medarbejder(navn: navnTextField.text!, id: id, foedselsaar: alderTextField.text!, arbejdsomraade: arbejdsområdeTextField.text!)
                medarbejder.loen = loenTextField.text!
                medarbejder.kommentar = kommentarTextField.text!
                medarbejder.ledig = false
                VirkSingleton.shared.virksomhed?.medarbejdere.append(medarbejder)
            }
        
        
            let viewController = storyboard?.instantiateViewController(withIdentifier: "hovedMenu") as? HovedMenu
        
            NotificationCenter.default.post(name: NSNotification.Name("medarbejder"), object: self)
            self.navigationController?.pushViewController(viewController!, animated: true)
    
        }
        else{
            let alertController = UIAlertController(title: "Oops!", message: "Alle personsoplysningerne skal være udfyldt", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func erAltTastetInd() -> Bool {
        if(navnTextField.text == "" || alderTextField.text == "" || arbejdsområdeTextField.text == "" || loenTextField.text == ""){
            return false
        }
        else{
            return true
        }
    }

}
