//
//  UpiView.swift
//  SafexPay
//
//  Created by Sandeep on 8/10/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import UIKit

protocol UpiViewProtocol {
    func PayViaUPI()
}

class UpiView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var upiTxtFld: UnderLineImageTextField!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var qrDownloadBtn: UIButton!
    
    // MARK:- Properties
    var delegate: UpiViewProtocol?
    
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- Helpers
    func setupView(){
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.payBtn.applyGradient(colours: gradientColors)
        self.payBtn.layer.cornerRadius = 2
        self.payBtn.layer.masksToBounds = true
        
        self.qrDownloadBtn.layer.masksToBounds = true
        self.qrDownloadBtn.layer.cornerRadius = 2
        self.qrDownloadBtn.layer.borderWidth = 1
        self.qrDownloadBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.6078431373, blue: 0.8745098039, alpha: 1)
        
    }
    
    @IBAction func payBtnPressed(_ sender: UIButton) {
        self.delegate?.PayViaUPI()
    }
}
