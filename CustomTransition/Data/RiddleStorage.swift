//
//  RiddleStorage.swift
//  CustomTransition
//
//  Created by Damir L on 12.06.2021.
//

import UIKit

struct RiddleStorage {
  
  static let defaultRiddles: [Riddle] = {
    return parsePets()
  }()
  
  private static func parsePets() -> [Riddle] {
    guard let fileURL = Bundle.main.url(forResource: "Riddles", withExtension: "plist") else {
      return []
    }

    do {
      let petData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
      let pets = try PropertyListDecoder().decode([Riddle].self, from: petData)
      return pets
    } catch {
      print(error)
      return []
    }
  }
}
