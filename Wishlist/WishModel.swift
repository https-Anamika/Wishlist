//
//  WishModel.swift
//  Wishlist
//
//  Created by anamika singh on 10/04/25.
//

import Foundation
import SwiftData
@Model
class Wish{
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
