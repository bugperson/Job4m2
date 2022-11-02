//
//  TagModel.swift
//  Job4m2
//
//  Created by Danil Dubov on 02.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import SwiftUI

struct TagModel {
    var id: Int
    var text: String
    var color: TagColor
}

enum TagColor {
    typealias RawValue = UIColor

    case deepGreen
    case deepPurple
    case lightGreen
    case blue
    case purple
    case deepBlue
    case green

    public var rawValue: Color {
        switch self {
        case .deepGreen:
            return UIColor(rgb: 0x41A06F).asColor()
        case .deepPurple:
            return UIColor(rgb: 0x796DCE).asColor()
        case .lightGreen:
            return UIColor(rgb: 0x81E1AF).asColor()
        case .blue:
            return  UIColor(rgb: 0x6C95EC).asColor()
        case .purple:
            return UIColor(rgb: 0xA45FE6).asColor()
        case .deepBlue:
            return UIColor(rgb: 0x7A8CF0).asColor()
        case .green:
            return UIColor(rgb: 0x7BE77E).asColor()
        }
    }
}
