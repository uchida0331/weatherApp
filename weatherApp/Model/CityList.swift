//
//  CityList.swift
//  weatherApp
//
//  Created by yuta uchida on 2020/04/11.
//  Copyright © 2020 yuta. All rights reserved.
//

import Foundation

class CityList {
    
    var list = [CityModel]()
    
    init() {
        list.append(CityModel(cityCode: "016010", cityName: "札幌"))
        list.append(CityModel(cityCode: "015010", cityName: "室蘭"))
        list.append(CityModel(cityCode: "040010", cityName: "仙台"))
        list.append(CityModel(cityCode: "110010", cityName: "さいたま"))
        list.append(CityModel(cityCode: "130010", cityName: "東京"))
        list.append(CityModel(cityCode: "140010", cityName: "横浜"))

    }
    
}
