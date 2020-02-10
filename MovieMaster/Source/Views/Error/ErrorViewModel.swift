//
//  ErrorViewModel.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 09/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation

class ErrorViewModel {

    private var text: String?

    func getText() -> String? {
        return text
    }

    func setErrorText(_ text: String) {
        self.text = text
    }
}
