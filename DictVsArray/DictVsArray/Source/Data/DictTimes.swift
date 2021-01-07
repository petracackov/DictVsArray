//
//  DictTimes.swift
//  DictVsArray
//
//  Created by Petra Čačkov on 06/01/2021.
//

import UIKit

class DictTimes: Time {
    var creation: TimeInterval?
    
    var added1ObjectTime: TimeInterval?
    
    var added5ObjectsTime: TimeInterval?
    
    var added10ObjectsTime: TimeInterval?
    
    var removed1ObjectTime: TimeInterval?
    
    var removed5ObjectsTime: TimeInterval?
    
    var removed10ObjectsTime: TimeInterval?
    
    var lookup1ObjectTime: TimeInterval?
    
    var lookup10ObjectsTime: TimeInterval?
    
    private var dictData: [UUID : Data] = [UUID : Data]()
    private var dictDaaata: [Int : Int] = [Int : Int]()
    
    func getAllData() -> [(title: String, timeInterval: TimeInterval?)] {
        var data = [(title: String, timeInterval: TimeInterval?)]()
        data.append(("creation", creation))
        data.append(("added1Object", added1ObjectTime))
        data.append(("added5Objects", added5ObjectsTime))
        data.append(("added10Objects", added10ObjectsTime))
        data.append(("removed1Object", removed1ObjectTime))
        data.append(("removed5Objects", removed5ObjectsTime))
        data.append(("removed10Objects", removed10ObjectsTime))
        data.append(("lookup1Object", lookup1ObjectTime))
        data.append(("lookup10Objects", lookup10ObjectsTime))
        return data
    }
    
    func create(numberOfItems: Int) {
        creation = TimeTools.runClosureForTime {
            for i in 0...numberOfItems {
                //let data = Data()
                //self.dictData[data.id] = data
                self.dictDaaata.updateValue(i, forKey: i)
            }
        }
    }
    
    private func addObjects(count: Int) -> TimeInterval {
        var array = [Data]()
        for _ in 0 ..< count {
          array.append(Data())
        }
        
        let timeInterval = TimeTools.runClosureForTime() {
          for item in array {
            self.dictData[item.id] = item
          }
        }
        
        //Restore
        for item in array {
            dictData.removeValue(forKey: item.id)
        }
        
        return timeInterval
    }
    
    private func removeObjects(count: Int) -> TimeInterval {
        var array = [Data]()
        for _ in 0 ..< count {
          array.append(Data())
        }
        
        let timeInterval = TimeTools.runClosureForTime() {
          for item in array {
            self.dictData[item.id] = nil
          }
        }
        
        return timeInterval
    }
    
    private func lookup(count: Int) -> TimeInterval {
        var array = [Data]()
        for _ in 0 ..< count {
          array.append(Data())
        }
        
        for item in array {
            self.dictData[item.id] = item
        }
        
        let timeInterval = TimeTools.runClosureForTime() {
          for item in array {
            let _ = self.dictData[item.id] = item
          }
        }
        
        //Restore
        for item in array {
            dictData.removeValue(forKey: item.id)
        }
        
        return timeInterval
    }
    
    func add1Object() {
        added1ObjectTime = addObjects(count: 1)
    }
    
    func add5Objects() {
        added5ObjectsTime = addObjects(count: 5)
    }
    
    func add10Objects() {
        added10ObjectsTime = addObjects(count: 10)
    }
    
    func remove1Object() {
        removed1ObjectTime = removeObjects(count: 1)
    }
    
    func remove5Objects() {
        removed5ObjectsTime = removeObjects(count: 5)
    }
    
    func remove10Objects() {
        removed10ObjectsTime = removeObjects(count: 10)
    }
    
    func lookup1Object() {
        lookup1ObjectTime = lookup(count: 1)
    }
    
    func lookup10Objects() {
        lookup10ObjectsTime = lookup(count: 10)
    }
    
}
