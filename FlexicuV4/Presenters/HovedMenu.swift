//
//  HovedMenu.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 14/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class HovedMenu: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var CollectionView1: UICollectionView! //Udlejede
    
    @IBOutlet weak var CollectionView2: UICollectionView! // Lejede
    
    @IBOutlet weak var CollectionView3: UICollectionView! // Alle ens medarbejdere
    
    let udlejedeMIdentifier = "udlejedeMCell"
    let lejetACVIdentifier = "lejetArbejdskraftCell"
    let alleMCVIdentifier = "alleMedarbejdereCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
            cell?.navnLabel.text = "Init All"
        return cell!
        } else if collectionView == CollectionView2{
            let cell: LejetArbejdskraftCVCell? = collectionView.dequeueReusableCell(withReuseIdentifier: lejetACVIdentifier, for: indexPath) as? LejetArbejdskraftCVCell
            cell?.navnLabel.text = "Hej hej"
            return cell!
        } else{
            let cell: AlleMedarbejdereCVCell? = collectionView.dequeueReusableCell(withReuseIdentifier: alleMCVIdentifier, for: indexPath) as? AlleMedarbejdereCVCell
            cell?.navnLabel.text = "Hej hej"
            cell?.lejetAfLabel.text = "Janus rules"
            return cell!
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO mangler at teste for om cellen er den sidste i rækken for så skal man kunne oprette
        
        //Test om det er lejede medarbejdere
        if collectionView == CollectionView2 {
            let viewController = storyboard?.instantiateViewController(withIdentifier: "")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
            //Ellers vælg den for egne medarbejdere
            //Gælder begge de andre collections
        else {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "MineMedarbejdere")
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
        
    }






        
}
    
    

