//
//  SafexPay.swift
//  SafexPay
//
//  Created by Sandeep on 8/4/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import Foundation
import KRProgressHUD
import UIKit

@objc open class SafexPay: NSObject {
    public static let sharedInstance = SafexPay()
    private var merchantId = String.empty
    private var BrandDetails: BrandingDetail?
    
    override init() {
        super.init()
    }
    
    @objc open func configure(MerchantId: String){
        self.configureSafex(merchantId: MerchantId)
    }
    
    private func configureSafex(merchantId: String){
        self.merchantId = merchantId
        self.getBrandingDetails(merchantId: self.merchantId)
    }
    
    @objc open func showPaymentGateway(on viewController: UIViewController, price: String, orderId: String){
        let vc = ContactDetailsVC()
        vc.modalPresentationStyle = .fullScreen
        vc.price = price
        vc.orderId = orderId
        vc.mechantId = self.merchantId
        vc.BrandDetails = self.BrandDetails
        viewController.present(vc, animated: true, completion: nil)
    }
    
}

extension SafexPay{
    private func getBrandingDetails(merchantId: String){
        KRProgressHUD.show()
        DataClient.getBrandingDetails(merchantId: merchantId) { (status, data) in
            if status{
                if let details = data{
                    self.decryptBrandingDetail(encData: details)
                }
            }else{
                KRProgressHUD.dismiss()
                Console.log(ErrorMessages.somethingWentWrong)
            }
        }
    }
    
    private func decryptBrandingDetail(encData: String){
        let payloadResponse = AESClient.AESDecrypt(dataToDecrypt: encData, decryptionKey: AESData.decryptKey)
        let dataDict = convertToDictionary(text: payloadResponse)
        do{
            let data2 = try JSONSerialization.data(withJSONObject: dataDict , options: .prettyPrinted)
            let decoder = JSONDecoder()
            do {
                self.BrandDetails = try decoder.decode(BrandingDetail.self, from: data2)
                if let details = self.BrandDetails{
                    headerColor = UIColor(hexString: details.merchantThemeDetails.headingBgcolor)
                    bgColor = UIColor(hexString: details.merchantThemeDetails.bgcolor)
                }
                KRProgressHUD.dismiss()
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                KRProgressHUD.dismiss()
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                KRProgressHUD.dismiss()
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                KRProgressHUD.dismiss()
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                KRProgressHUD.dismiss()
            } catch {
                print("error: ", error)
                KRProgressHUD.dismiss()
            }
        } catch {
            Console.log(error.localizedDescription)
            KRProgressHUD.dismiss()
        }
    }
}
