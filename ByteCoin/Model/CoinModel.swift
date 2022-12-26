//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Sahid Reza on 26/12/22.
//

import Foundation

struct CoinModel{
    
    var coinPrice:Double
    var coinPriceString:String{
        return  String(format: "%.2f", coinPrice)
    }
    
    
}
