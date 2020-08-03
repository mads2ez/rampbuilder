//
//  AnalyticsService.swift
//  RampBuilder
//
//  Created by Madsbook on 25.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation

public protocol AnalyticsService {
    func initialize()
    func logEvent(_ :String)
    func logEvent(_ :String, eventProperties: [AnyHashable : Any]!)
    func setUserProperties(_ properties: [AnyHashable : Any]!)
}

final class AnalyticsManager: AnalyticsService {
    // MARK: - Properties -
       
    // The list of services added to this class as observers.
    internal private(set) var services = [AnalyticsService]()

    // MARK: - Singleton -
    static let instance = AnalyticsManager()
    private init() {}

    // MARK: - Methods -

    /**
    Adds a service as an observer.
    */
    func add(service: AnalyticsService) {
       self.services.append(service)
    }

    // MARK: - AnalyticsService -
    func initialize() {
       // When AnalyticsManager is instantiated,
       // it also instantiates each service that
       // has been added to it.
       for service in services {
           service.initialize()
       }
    }

    func logEvent(_ event:String) {
       // When an event is tracked by AnalyticsManager,
       // it will notify all the services that has been added to it.
       for service in services {
           service.logEvent(event)
       }
    }
    
    func logEvent(_ event: String, eventProperties: [AnyHashable : Any]!) {
        for service in services {
            service.logEvent(event, eventProperties: eventProperties)
        }
    }
    
    func setUserProperties(_ properties: [AnyHashable : Any]!) {
        for service in services {
            service.setUserProperties(properties)
        }
    }
}
