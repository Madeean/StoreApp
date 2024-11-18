//
//  Locale+Extensions.swift
//  StoreApp
//
//  Created by made reihan on 18/11/24.
//

import Foundation

extension Locale{
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "IDR"
    }
}
