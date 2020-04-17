//
//  CityModel.swift
//  weatherApp
//
//  Created by yuta uchida on 2020/04/11.
//  Copyright © 2020 yuta. All rights reserved.
//

import Foundation

class CityModel {
    
    let code: String
    let name: String
    
    init(cityCode:String, cityName:String) {
        code = cityCode
        name = cityName
    }
}
