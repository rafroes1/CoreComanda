//
//  HideKeyboardExtension.swift
//  CoreComanda
//
//  Created by Rafael Carvalho on 07/03/23.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
