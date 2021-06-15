//
//  RiddleStorage.swift
//  CustomTransition
//
//  Created by Damir L on 12.06.2021.
//

import UIKit

struct RiddleStorage {
    
    static let defaultRiddles: [Riddle] = {
        return parseRiddles()
    }()
    
    private static func parseRiddles() -> [Riddle] {
        guard let fileURL = Bundle.main.url(forResource: "Riddles", withExtension: "plist") else {
            return []
        }
        
        do {
            let riddleData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let riddles = try PropertyListDecoder().decode([Riddle].self, from: riddleData)
            return riddles
        } catch {
            print(error)
            return []
        }
    }
}
