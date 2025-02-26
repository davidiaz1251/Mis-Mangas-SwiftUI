//
//  Numbers.swift
//  Mis Mangas
//
//  Created by luis david diaz ramirez on 27/2/25.
//

import Foundation


extension Double {
    func formatted(withDecimals decimals: Int) -> String {
        self.formatted(.number.precision(.fractionLength(decimals)))
    }
}
