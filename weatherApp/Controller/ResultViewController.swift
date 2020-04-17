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

class ResultViewController: UIViewController {
        
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var todayWeatherLabel: UILabel!
    @IBOutlet weak var todayHighLabel: UILabel!
    @IBOutlet weak var todayLowLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var cityData:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       print(cityData)

        getWeather()
        
        // Do any additional setup after loading the view.
    }
    
    //天気を取得
    func getWeather() {
        
        let high = "最高気温："
        let low = "最低気温："
        let parameters:[String: Any] = ["city": cityData[0]]
        let url = "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(cityData[0])"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in

            switch response.result {
            case .success:
                let json:JSON = JSON(response.data as Any)

                let cityName = json["title"].string
                let todayDate = json["forecasts"][0]["date"].string
                let todayWeather = json["forecasts"][0]["telop"].string
                let todayHigh = json["forecasts"][0]["temperature"]["max"]["celsius"].string
                let todayLow = json["forecasts"][0]["temperature"]["min"]["celsius"].string
                
                let description = json["description"]["text"].string
                
                print(description)
                
                if cityName != nil {
                    self.cityNameLabel.text = cityName
                } else {
                    self.cityNameLabel.text = self.cityData[1]
                }
                
                if todayDate != nil {
                    self.todayDateLabel.text = "Today \(todayDate!.suffix(5))"
                }
                
                if todayWeather != nil {
                    self.todayWeatherLabel.text = todayWeather
                } else {
                    self.todayWeatherLabel.text = low + "No Data"
                }
                
                if todayHigh != nil {
                    self.todayHighLabel.text = "\(high)\(todayHigh!)°"
                } else {
                    self.todayHighLabel.text = low + "No Data"
                }
        
                if todayLow != nil {
                    self.todayLowLabel.text = "\(low)\(todayLow!)°"
                } else {
                    self.todayLowLabel.text = low + "No Data"
                }
                
                if description != nil {
                    self.descriptionTextView.text = description
                } else {
                    self.descriptionTextView.text = "No Description"
                }
                
            case .failure(let error):
                print("-------- エラー ------")
                print(error)
            }

            
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
