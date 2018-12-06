//
//  HovedMenu.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 14/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HovedMenu: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var CollectionView1: UICollectionView! //Udlejede
    
    @IBOutlet weak var CollectionView2: UICollectionView! // Lejede
    
    @IBOutlet weak var CollectionView3: UICollectionView! // Alle ens medarbejdere
    
    let udlejedeMIdentifier = "udlejedeMCell"
    let lejetACVIdentifier = "lejetArbejdskraftCell"
    let alleMCVIdentifier = "alleMedarbejdereCell"
    
    var ref: DatabaseReference!
    var virksomhed: Virksomhed!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // returner længden på datasættene
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CollectionView1 {
            let cell: UdlejedeMedarbejdereCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: udlejedeMIdentifier, for: indexPath) as? UdlejedeMedarbejdereCollectionViewCell
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.gray.cgColor
            cell?.navnLabel.text = "Init All"
            
        return cell!
        } else if collectionView == CollectionView2{
            let cell: LejetArbejdskraftCVCell? = collectionView.dequeueReusableCell(withReuseIdentifier: lejetACVIdentifier, for: indexPath) as? LejetArbejdskraftCVCell
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.gray.cgColor
            cell?.navnLabel.text = "Hej hej"
            return cell!
        } else{
            let cell: AlleMedarbejdereCVCell? = collectionView.dequeueReusableCell(withReuseIdentifier: alleMCVIdentifier, for: indexPath) as? AlleMedarbejdereCVCell
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.gray.cgColor
            cell?.navnLabel.text = "Hej hej"
            cell?.lejetAfLabel.text = "Janus rules"
            //Bug hvis ikke de bliver specificeret
            cell?.LastImageView.isHidden=true
            cell?.navnLabel.isHidden = false
            cell?.lejetAfLabel.isHidden = false
            cell?.udlejetIPeriodeLabel.isHidden = false
            if indexPath.row == 9{
            cell?.LastImageView.isHidden = false
                cell?.navnLabel.isHidden = true
                cell?.lejetAfLabel.isHidden = true
                cell?.udlejetIPeriodeLabel.isHidden = true
            }
            return cell!
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO mangler at teste for om cellen er den sidste i rækken for så skal man kunne oprette
        
        //Test om det er lejede medarbejdere
        if collectionView == CollectionView3 {
            let viewController1 = storyboard?.instantiateViewController(withIdentifier: "ValgtMedarbejderView") as? MineMedarbejdere
            
            
            self.navigationController?.pushViewController(viewController1!, animated: true)
        }
            //Ellers vælg den for egne medarbejdere
            //Gælder begge de andre collections
        else {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "IndgaaedeAftalerView") as? IndgaaedeAftaler

        self.navigationController?.pushViewController(viewController!, animated: true)
    }
        
    }






        
}
    
    

