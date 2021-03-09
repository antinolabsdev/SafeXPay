//
//  WalletView.swift
//  SafexPay
//
//  Created by Sandeep on 8/7/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import UIKit

class WalletView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var payBtn: UIButton!
    
    // MARK:- Properties
    let walletImages = ["w-airtel-money","w-freecharge","w-jio-money","w-mobikwik","w-olamoney","w-payumoney","w-payzapp"]
    var walletData: [PaymentModeDetailsList]?
    
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK:- Helpers
    func setupCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "WalletCell", bundle: safexBundle), forCellWithReuseIdentifier: "WalletCell")
        
        self.payBtn.applyGradient(colours: gradientColors)
        self.payBtn.layer.cornerRadius = 2
        self.payBtn.layer.masksToBounds = true
    }
}

extension WalletView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = self.walletData{
            return data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCell", for: indexPath) as! WalletCell
        if let data = self.walletData{
            cell.setData(data: data[indexPath.row])
        }
        return cell
    }
}

extension WalletView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
