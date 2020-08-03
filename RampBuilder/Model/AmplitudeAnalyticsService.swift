//
//  AmplitudeAnalyticsService.swift
//  RampBuilder
//
//  Created by Madsbook on 25.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation
import Amplitude

final class AmplitudeAnalyticsService: AnalyticsService {
    private static let APIkey = <INSERT YOUR API KEY HERE>
    
    func initialize() {
        Amplitude.instance().trackingSessionEvents = true
        Amplitude.instance().initializeApiKey(AmplitudeAnalyticsService.APIKey)
    }
    
    func logEvent(_ event: String) {
        self.logEvent(event, eventProperties: nil)
    }
    
    func logEvent(_ event: String, eventProperties: [AnyHashable : Any]! = nil) {
        Amplitude.instance()?.logEvent(event, withEventProperties: eventProperties)
    }
    
    func setUserProperties(_ properties: [AnyHashable : Any]!) {
        Amplitude.instance()?.setUserProperties(properties)
    }
}
