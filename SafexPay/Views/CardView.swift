//
//  CardView.swift
//  SafexPay
//
//  Created by Sandeep on 8/17/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payBtn: UIButton!
    
    // MARK:- Properties
    var isSectionExpanded = false
    var delegate: DetailViewProtocol?
    
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK:- Helpers
    func setupCardView(info: PaymentMode){
        self.titleLbl.text = info.paymentMode
        self.titleImg.image = UIImage(named: info.payModeID, in: safexBundle, compatibleWith: nil)
        self.payBtn.backgroundColor = headerColor
        self.payBtn.layer.cornerRadius = 2
        self.payBtn.layer.masksToBounds = true
        self.setupTableView()
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AddCardCell", bundle: safexBundle), forCellReuseIdentifier: "AddCardCell")
        self.tableView.register(UINib(nibName: "SavedCardCollection", bundle: safexBundle), forCellReuseIdentifier: "SavedCardCollection")
        self.tableView.register(UINib(nibName: "SavedCardsHeader", bundle: safexBundle), forHeaderFooterViewReuseIdentifier: "SavedCardsHeader")
    }
    
    @IBAction func backToMainPressed(_ sender: UIButton) {
        self.delegate?.backToMain()
    }
}

extension CardView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isSectionExpanded{
                return 1
            } else {
                return 0
            }
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCardCollection") as! SavedCardCollection
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardCell") as! AddCardCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        } else {
            return 175
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SavedCardsHeader") as! SavedCardsHeader
            view.tag = section
            if isSectionExpanded {
                view.sectionExpandButton.setImage(UIImage(named: "up", in: safexBundle, compatibleWith: nil), for: .normal)
            } else {
                view.sectionExpandButton.setImage(UIImage(named: "down", in: safexBundle, compatibleWith: nil), for: .normal)
            }
            view.delegate = self
            view.setdata(headerLbl: "SAVED CARDS")
            return view
        } else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SavedCardsHeader") as! SavedCardsHeader
            view.tag = section
            view.sectionExpandButton.isHidden = true
            view.setdata(headerLbl: "ADD NEW CARD")
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

extension CardView: SavedCardsHeaderProtocol {
    func sectionExpandPressed(tag: Int, view: SavedCardsHeader) {
        if isSectionExpanded {
            self.isSectionExpanded = false
            let sections = IndexSet(integer: tag)
            tableView.reloadSections(sections, with: .top)
        } else {
            self.isSectionExpanded = true
            let sections = IndexSet(integer: tag)
            tableView.reloadSections(sections, with: .top)
        }
    }
    
    
}
