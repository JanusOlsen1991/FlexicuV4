//
//  Udlej.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 14/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class Udlej: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let mNavn = ["Gunn", "Janus", "Christian", "Oliver", "Ahad"]
    let mArbejdsområde = ["Smed", "Tørmer", "Lagermand", "Smed", "Lagermand"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    /*    collectionViewCell.layer.borderColor = UIColor.green.cgColor
        collectionViewCell.layer.borderWidth = 3.0
        collectionViewCell.layer.cornerRadius = 3.0//if you want corner radius.addtional*/

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mNavn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
        cell?.layer.borderWidth = 1.0
        cell?.layer.borderColor = UIColor.green.cgColor
        cell?.layer.cornerRadius = 3.0
        cell?.navn.text = mNavn[indexPath.item]
        cell?.arbejdsområde.text = mArbejdsområde[indexPath.item]
        //ref til medarbejder objekt i klassen
        return cell!
    }
    
   // func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let vc = storyboard?.instantiateViewController(withIdentifier: "UdlejMedarbejder") as? UdlejMedarbejder
        //vc?.name = mNavn[indexPath.item]
        //vc?.arbejdsområde = mArbejdsområde[indexPath.item]
        
        //self.navigationController?.pushViewController(vc!, animated: true)
    //}
}
