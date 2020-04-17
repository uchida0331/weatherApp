//
//  ViewController.swift
//  weatherApp
//
//  Created by yuta uchida on 2020/02/02.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var resultButton: UIButton!
    
    var cityData:[String] = ["016010", "札幌"]
    let cityList = CityList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        titleLabel.text = "天気予報"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "ヒラギノ明朝 ProN W3", size: 40)
        titleLabel.textAlignment = NSTextAlignment.center
        
        resultButton.setTitle("結果", for: .normal)
        resultButton.setTitleColor(UIColor.darkGray, for: .normal)
        resultButton.layer.borderWidth = 1.0
        resultButton.layer.borderColor = UIColor.gray.cgColor
        
        // Do any additional setup after loading the view.
    }


    //列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
     
    //行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.list.count
    }
    
    //表示するデータ
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList.list[row].name
    }
    
    //選択時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityData = [cityList.list[row].code,cityList.list[row].name]
    }
    
    
    @IBAction func resultButton(_ sender: Any) {
        performSegue(withIdentifier: "result", sender: nil)
    }
    
    //resultVCにデータ受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.cityData = cityData
        }
    }
    
}

