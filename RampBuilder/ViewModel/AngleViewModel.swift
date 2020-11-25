//
//  AngleViewModel.swift
//  RampBuilder
//
//  Created by Madsbook on 03.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation
import Combine
import CoreMotion

class AngleViewModel: ObservableObject {
    private var motionManager: CMMotionManager

    @Published var angle: String = "0"

    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 0.1
        self.motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
            guard error == nil else {
                print(error!)
                return
            }

            if let motionData = data {
                self.angle = (motionData.attitude.pitch * 180 / Double.pi).toString(format: ".")
            }
        }
    }
    
    func perform() {
        AnalyticsManager.instance.logEvent("AngleView opened")
    }
}
