//
//  AnalyticsService.swift
//  Ramp Builder
//
//  Created by Madsbook on 25.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation

protocol AnalyticsService {
    func initialize()
    func logEvent(_ :String)
    func logEvent(_ :String, eventProperties: [AnyHashable : Any]!)
}
