//
//  Lej.swift
//  FlexicuV2
//
//  Created by Janus Olsen on 14/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

//For at tilføje navigationcontroller: tryk på et view -> editor -> embed in: vælg type

class Lej: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Return ledigemedarbejdere.count
    }
    //Sætter cellestørrelse
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (self.view.frame.size.width)
        return CGSize(width: width, height: 182.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SoegtArbejdskraftCVCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "SoegtArbejdskraftCell", for: indexPath) as? SoegtArbejdskraftCVCell
        //Initialiser labels
        cell?.arbejdsomraadeLabel.text = "Smed"
        cell?.NavnLabel.text = "Jonatan"
        cell?.LedigIPeriodeLabel.text = "01/12/2018 - 12/05/2019"
        cell?.PrisLabel.text = "96.000"
        cell?.layer.borderWidth = 3.0
        cell?.layer.borderColor = HexFarver.hexStringToUIColor(hex: "#427d3c").cgColor
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //Metode lånt fra stackoverflow til at returnere hexcolors

}
