//
//  Extension - UserDefaults.swift
//  contadorApp
//
//  Created by Marilyn on 5/26/17.
//  Copyright © 2017 Marco Del Angel. All rights reserved.
//

import Foundation

fileprivate let UserDefaultsNumbersKey = "numbers"

extension UserDefaults {
    
    func loadNumbers() -> [Int] {
        guard let loadedNumbers = array(forKey: UserDefaultsNumbersKey) as? [Int] else {
            return []
        }
        
        return loadedNumbers
    }
    
    func saveNumbers(_ numbers: [Int]) {
        set(numbers, forKey: UserDefaultsNumbersKey)
        synchronize()
    }
}
