//
//  Constants.swift
//  SafexPay
//
//  Created by Sandeep on 8/5/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import UIKit

let Rupee = "\u{20B9}"
let safexBundle = Bundle(for: SafexPay.self)
let BASE_URL = "https://test.avantgardepayments.com"
//let BASE_URL = "https://www.avantgardepayments.com"

var headerColor = UIColor(hexString: "#283c93")
var bgColor = UIColor(hexString: "#F0FCFE")

var gradientColors = [
    UIColor(hexString: "#283c93").cgColor,
    UIColor(hexString: "#009cdc").cgColor
]

enum AESData{
    static let decryptKey = "oqUl4D0LqA4plZw4reAX/K3UKJoQdet0k/N6X6K4Y5k=" //External Test
//    static let decryptKey = "OtRV+i3EAkLU1M5cT/coIJUR6CfU34Z4EpMdI7BM2Os="  //External Prod
    static let encryptKey = "HiktfH0Mhdla4zDg0/4ASwFQh2OS+nf9MVL0ik3DsmE=" //Internal
}

