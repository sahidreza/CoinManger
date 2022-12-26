//
//  ViewController.swift
//  ByteCoin
//
//  Created by Sahid Reza on 26/12/22.
//

import UIKit

class CoinViewController: UIViewController {
   
    
    
    @IBOutlet weak var bitCoinLabel: UILabel!
    
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManger = CoinManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManger.delegate = self
       
        
    }
    
   


}

// MARK: - PICKER VIEW DATA SOURCE

extension CoinViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManger.currencyArray.count
    }
}

// MARK: - PICKER VIEW DELEGATE

extension CoinViewController:UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return  coinManger.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentCurrencyLabel.text = coinManger.currencyArray[row]
        
        if let currencyLabelValue = currentCurrencyLabel.text {
            coinManger.fectiongCoinData(coinValue: currencyLabelValue)
        }
    }
    
}

// MARK: - Coin Manger Delegate

extension CoinViewController:CoinMangerDelegate{
    
    func didUpdateCoinData(_ coinManager:CoinManager  ,currentcoinValue: CoinModel) {
    
        DispatchQueue.main.async {
            
            self.bitCoinLabel.text = currentcoinValue.coinPriceString
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
