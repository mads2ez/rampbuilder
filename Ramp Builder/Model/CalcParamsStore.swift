//
//  CalcParamsStore.swift
//  Ramp Builder
//
//  Created by younke on 26.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation

protocol CalcParamsStore {

    func set(params: CalcParams)
    func get() -> CalcParams?
}

final class CalcParamsUserDefaults: CalcParamsStore {

    private enum Constants {
        static let key = "CalcParamsStore.params"
    }

    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    convenience init() {
        self.init(userDefaults: .standard)
    }

    // MARK: -

    func set(params: CalcParams) {
        guard
            let encoded = try? JSONEncoder().encode(params),
            let jsonString = String(data: encoded, encoding: .utf8) else {
                return
        }
        userDefaults.set(jsonString, forKey: Constants.key)
    }

    enum MyError: Error {
        case blabla
    }

    func get() -> CalcParams? {
        guard
            let json = userDefaults.string(forKey: Constants.key),
            let jsonData = json.data(using: .utf8),
            let result = try? JSONDecoder().decode(CalcParams.self, from: jsonData) else {
            return nil
        }
        return result
    }
}
