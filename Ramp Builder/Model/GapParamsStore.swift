//
//  GapParamsStore.swift
//  Ramp Builder
//
//  Created by younke on 26.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation

protocol GapParamsStore {
    func set(params: GapParams)
    func get() -> GapParams?
}

final class GapParamsUserDefaults: GapParamsStore {

    private enum Constants {
        static let key = "GapParamsStore.params"
    }

    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    convenience init() {
        self.init(userDefaults: .standard)
    }

    // MARK: -

    func set(params: GapParams) {
        guard
            let encoded = try? JSONEncoder().encode(params),
            let jsonString = String(data: encoded, encoding: .utf8) else {
                return
        }
        userDefaults.set(jsonString, forKey: Constants.key)
    }

    func get() -> GapParams? {
        guard
            let json = userDefaults.string(forKey: Constants.key),
            let jsonData = json.data(using: .utf8),
            let result = try? JSONDecoder().decode(GapParams.self, from: jsonData) else {
            return nil
        }
        return result
    }
}


final class GapParamsMock: GapParamsStore {
    
    var gapParams: GapParams
    
    init() {
        self.gapParams = GapParams.defaultParams
    }
    
    func set(params: GapParams) {
        self.gapParams = params
    }

    func get() -> GapParams? {
        return GapParams.defaultParams
    }
}
