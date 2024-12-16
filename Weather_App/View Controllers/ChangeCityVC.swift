//
//  ChangeCity_VC.swift
//  Weather_App
//
//  Created by mac on 15/12/2024.
//

import UIKit

class ChangeCityVC: UIViewController {
 
    
    var citiesArray = [City(name: "Alx", id: 361058),
                       City(name: "Cairo", id: 360630),
                       City(name: "Aswan", id: 359792),
                       City(name: "Ismailia", id: 361055),
                       City(name: "Hurghada", id: 361291),
                       City(name: "Luxor", id: 360502),
                       City(name: "Sohag", id: 359792)
    
    ]
    var selectedCity:City?
    
    @IBOutlet weak var citiesPickerView: UIPickerView!
    
   
    @IBOutlet weak var changedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changedButton.layer.cornerRadius = 15
        
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
    }
    

    
    @IBAction func changeButtonClicked(_ sender: Any) {
        if let city = selectedCity{
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cityChanged"), object: nil ,userInfo: ["city": city])
            
            self.dismiss(animated: true)
        }
            
        
        
    }
    
}
extension ChangeCityVC:  UIPickerViewDelegate & UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        citiesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
        return citiesArray[row].name
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = citiesArray[row]
    }
}
