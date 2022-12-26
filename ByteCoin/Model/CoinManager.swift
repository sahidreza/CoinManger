//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Sahid Reza on 26/12/22.
//

import Foundation

protocol CoinMangerDelegate{
    
    func didUpdateCoinData(_ coinManager:CoinManager  ,currentcoinValue: CoinModel)
    func didFailWithError(error:Error)
}

struct CoinManager {
    
    var delegate:CoinMangerDelegate?
    
   let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    
    func fectiongCoinData(coinValue:String){
        let urlString = "\(K.base_URL)BTC/\(coinValue)?apikey=\(K.api_key)"
        print(urlString)
        performRequest(with: urlString)
    }

    func performRequest(with urlString:String){

        // 1. create URL
        if let url = URL(string: urlString){

          // 2. crate URl sesion configaration
            let urlSession = URLSession(configuration: .default)

         // 3 . Create a sesion task

            let task =  urlSession.dataTask(with: url) { data, response, error in

                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    
                    if let coinData =  self.pharseJson(safeData) {
                        
                        delegate?.didUpdateCoinData(self, currentcoinValue: coinData)
                    }

                   
                }


            }

            task.resume()
        }

    }
    
    func pharseJson(_ coinData:Data) ->CoinModel?{
        
        let jsondecoder = JSONDecoder()
        
        do {
            let decodeData =  try jsondecoder.decode(CoinData.self, from: coinData)
            let rate = decodeData.rate
            let coinModelData = CoinModel(coinPrice: rate)
          
            
            return coinModelData
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
       
        
    }
    
}

