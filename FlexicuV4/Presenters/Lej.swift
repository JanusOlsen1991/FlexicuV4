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
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.readData, object: nil, queue: OperationQueue.main) { (notification) in
            print("Opdatering incoming")
            self.collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VirkSingleton.shared.ledigFolk.count // Return ledigemedarbejdere.count
    }
    //Sætter cellestørrelse
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (self.view.frame.size.width-20)
        return CGSize(width: width, height: 182.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SoegtArbejdskraftCVCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "SoegtArbejdskraftCell", for: indexPath) as? SoegtArbejdskraftCVCell
        //Initialiser labels
        
        
        
        cell?.arbejdsomraadeLabel.text = VirkSingleton.shared.ledigFolk[indexPath.item].medarbejder.arbejdsomraade
        cell?.NavnLabel.text = VirkSingleton.shared.ledigFolk[indexPath.item].medarbejder.navn
        cell?.LedigIPeriodeLabel.text = "\(VirkSingleton.shared.ledigFolk[indexPath.item].startDato) - \(VirkSingleton.shared.ledigFolk[indexPath.item].slutDato)"
        cell?.PrisLabel.text = VirkSingleton.shared.ledigFolk[indexPath.item].loen
        cell?.layer.borderWidth = 3.0
        cell?.layer.borderColor = HexFarver.hexStringToUIColor(hex: "#427d3c").cgColor
        return cell!
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
