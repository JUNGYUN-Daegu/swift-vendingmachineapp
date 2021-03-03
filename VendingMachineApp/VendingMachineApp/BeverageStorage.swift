//
//  BeverageStorage.swift
//  VendingMachineApp
//
//  Created by 조중윤 on 2021/02/23.
//

import Foundation

class BeverageStorage {
    enum StorageError: Error {
        case noStock
    }
    
    private var stock: [Beverage:Int]
    
    init() {
        stock = [:]
    }
    
    public func increaseStock(beverage: Beverage, by amount: Int) {
        if stock[beverage] != nil {
            stock[beverage]! += amount
        } else {
            stock[beverage] = amount
        }
    }

    public func checkStock() -> [Beverage:Int] {
       return stock
    }

    public func checkPurchasables(with money: Int) -> [Beverage:Int] {
        let purchasableBeverages = stock.filter { (bev, amt) -> Bool in
            bev.isPurchasable(with: money)
        }
        return purchasableBeverages
    }
    
    public func checkExpired() -> [Beverage:Int] {
        let purchasableBeverages = stock.filter { (bev, amt) -> Bool in
            bev.isExpired()
        }
        return purchasableBeverages
    }
    
    public func decreaseStock(beverage: Beverage, completionHandlerWhenStockIsDecreased: () -> Void) throws {
        if stock[beverage] != nil {
            stock[beverage]! -= 1
            completionHandlerWhenStockIsDecreased()
        } else {
            throw StorageError.noStock
        }
    }
}

