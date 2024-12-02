//
//  OffsetKey.swift
//  BookMaster
//
//  Created by Максим Шишлов on 02.12.2024.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
