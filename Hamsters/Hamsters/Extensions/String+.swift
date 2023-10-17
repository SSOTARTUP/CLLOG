//
//  String+.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/17/23.
//

import SwiftUI

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
