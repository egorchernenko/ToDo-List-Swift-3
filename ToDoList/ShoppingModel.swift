//
//  ShoppingModel.swift
//  ToDoList
//
//  Created by Egor on 08.07.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation

class Goods{
    var string: String = ""
    var check: Bool = false
    var price: Double = 0.0
    var quantity: Double = 0.0
    //let unit: [String] = ["PC","L","KG"]
    
    init(string: String, check: Bool){
        //super.init(string: string, check: check)
        self.string = string
        self.check = check
    }
    
    convenience init(string: String, check: Bool, price: Double, quantity: Double){
        self.init(string: string, check: check)
        self.price = price
        self.quantity = quantity
    }
    
    required init(coder decoder:NSCoder) {
        self.string = decoder.decodeObject(forKey: "string") as? String ?? ""
        self.check = decoder.decodeBool(forKey: "check")
        self.price = decoder.decodeDouble(forKey: "price")
        self.quantity = decoder.decodeDouble(forKey: "quantity")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(string, forKey: "string")
        aCoder.encode(check, forKey: "check")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(quantity, forKey: "quantity")
    }
}
