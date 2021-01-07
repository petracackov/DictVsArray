//
//  TimeTools.swift
//  DictVsArray
//
//  Created by Petra Čačkov on 05/01/2021.
//

import UIKit

class TimeTools {

    static func runClosureForTime(_ closure: (() -> Void)) -> TimeInterval {
    
      let startDate = Date()
    
      closure()
      
      let endDate = Date()
    
      let interval = endDate.timeIntervalSince(startDate)
      
      return interval
    }

}
