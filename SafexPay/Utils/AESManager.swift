//
//  Encryptions.swift
//  SafexPay
//
//  Created by Sandeep on 09/09/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    func AESEncrypt(jwtstring: String, KEY: String, IV: String) -> String
    {
        let base64DecodedData = NSData(base64Encoded: KEY, options: .ignoreUnknownCharacters)
        let input: Array<UInt8> = Array(jwtstring.utf8)
        let key: Array<UInt8> = [UInt8](base64DecodedData! as Data)
        let iv: Array<UInt8> = Array(IV.utf8)
        do
        {
            let encrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).encrypt(input)
            let encData = Data(bytes: encrypted, count: Int(encrypted.count))
            let base64String: String = encData.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
            let result = String(base64String)
            return result
        }
        catch
        {
            return ""
        }
    }
    
    func AESDecrypt(Encstring: String, KEY: String, IV: String) -> String
    {
        let base64DecodedData = NSData(base64Encoded: KEY, options: .ignoreUnknownCharacters)
        // let bytes = [UInt8](nsData as Data)
        let bytes1=[UInt8](base64DecodedData! as Data)
        let encryptedData = NSData(base64Encoded: Encstring, options:[])!
      //  print("decodedData: \(encryptedData)")
        let count = encryptedData.length / MemoryLayout<UInt8>.size
        // create an array of Uint8
        var encrypted = [UInt8](repeating: 0, count: count)
        // copy bytes into array
        encryptedData.getBytes(&encrypted, length:count * MemoryLayout<UInt8>.size)
        do
        {
            let decrypted = try AES(key: bytes1, blockMode: CBC(iv: Array(IV.utf8)), padding: .pkcs7).decrypt(encrypted)
            let decryptedString = String(bytes: decrypted, encoding: String.Encoding.utf8) ?? ""
            return decryptedString
        }
        catch
        {
            return ""
        }
    }
}
