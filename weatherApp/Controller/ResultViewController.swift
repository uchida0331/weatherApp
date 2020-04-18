//
//  ResultViewController.swift
//  weatherApp
//
//  Created by yuta uchida on 2020/04/11.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class ResultViewController: UIViewController {
        
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var todayWeatherLabel: UILabel!
    @IBOutlet weak var todayHighLabel: UILabel!
    @IBOutlet weak var todayLowLabel: UILabel!
    
    @IBOutlet weak var tommorowDateLabel: UILabel!
    @IBOutlet weak var tommorowWeatherLabel: UILabel!
    @IBOutlet weak var tommorowHighLabel: UILabel!
    @IBOutlet weak var tommorowLowLabel: UILabel!
    
    let highString = "最高気温："
    let lowString = "最低気温："
    
    var cityData:[String] = []
    var date:String = ""
    var weather:String = ""
    var high:String = ""
    var low:String = ""
    var details:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(cityData)
        
        cityNameLabel.text = "\(cityData[1])の天気"
        cityNameLabel.font = UIFont(name: "ヒラギノ明朝 ProN W3", size: 25)
        cityNameLabel.textAlignment = NSTextAlignment.center
        
        todayWeatherLabel.font = UIFont.systemFont(ofSize: 28)
        todayHighLabel.textColor = UIColor.darkGray
        todayHighLabel.font = UIFont.systemFont(ofSize: 18)
        todayLowLabel.textColor = UIColor.darkGray
        todayLowLabel.font = UIFont.systemFont(ofSize: 18)
        
        tommorowWeatherLabel.font = UIFont.systemFont(ofSize: 20)
        tommorowHighLabel.textColor = UIColor.darkGray
        tommorowHighLabel.font = UIFont.systemFont(ofSize: 15)
        tommorowLowLabel.textColor = UIColor.darkGray
        tommorowLowLabel.font = UIFont.systemFont(ofSize: 15)
        
        getWeatherData(row: 0)
        getWeatherData(row: 1)

        // Do any additional setup after loading the view.
    }
    
    //天気情報を取得
    private func getWeatherData(row: Int) {

        let url = "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(cityData[0])"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in

            switch response.result {
            case .success:
                let json:JSON = JSON(response.data as Any)

                let date = json["forecasts"][row]["date"].string
                let weather = json["forecasts"][row]["telop"].string
                let high = json["forecasts"][row]["temperature"]["max"]["celsius"].string
                let low = json["forecasts"][row]["temperature"]["min"]["celsius"].string
                let details = json["description"]["text"].string
                
                print(weather!)
                
                if date != nil {
                    self.date = String(date!.suffix(5))
                } else {
                    self.date = "No Data"
                }
                
                if weather != nil {
                    print(weather!)

                    self.weather = weather!
                } else {
                    self.weather = "No Data"
                }
                
                if high != nil {
                    self.high = "\(high!)°"
                } else {
                    self.high = "No Data"
                }
                
                if low != nil {
                    self.low = "\(low!)°"
                } else {
                    self.low = "No Data"
                }
                
                if details != nil {
                    self.details = (details?.components(separatedBy: .newlines))!
                } else {
                    self.details = ["No Details"]
                }
                
                self.setWeatherData(row: row)
                
            case .failure(let error):
                print("-------- エラー ------")
                print(error)
            }
        }
    }

    private func setWeatherData(row: Int) {
    
        if row == 0 {
        
            todayWeatherLabel.text = weather
            todayDateLabel.text = date
            todayHighLabel.text = highString + high
            todayLowLabel.text = lowString + low
            detailsTextView.text = details[0]
            
        } else if row == 1 {
            
            tommorowWeatherLabel.text = weather
            tommorowDateLabel.text = date
            tommorowHighLabel.text = highString + high
            tommorowLowLabel.text = lowString + low
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
