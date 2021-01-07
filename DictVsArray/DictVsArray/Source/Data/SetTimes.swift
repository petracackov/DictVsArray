//
//  SetTimes.swift
//  DictVsArray
//
//  Created by Petra Čačkov on 06/01/2021.
//

import UIKit

class SetTimes: Time {
    var removed1ObjectTime: TimeInterval?
    
    var removed5ObjectsTime: TimeInterval?
    
    var removed10ObjectsTime: TimeInterval?
    
    var lookup1ObjectTime: TimeInterval?
    
    var lookup10ObjectsTime: TimeInterval?
    
    var added1ObjectTime: TimeInterval?
    
    var added5ObjectsTime: TimeInterval?
    
    var added10ObjectsTime: TimeInterval?
    
    var creation: TimeInterval?
    
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
    

    private var setData: Set<Data> = Set<Data>()
    
    
    private func addObjects(_ count: Int) -> TimeInterval {
        var objectsArray = [Data]()
        for _ in 0 ..< count {
          objectsArray.append(Data())
        }
        
        let timeInterval = TimeTools.runClosureForTime() {
          let _ = self.setData.union(objectsArray)
        }
        
        // Reset
        for itemToRemove in objectsArray {
          self.setData.remove(itemToRemove)
        }
        
        return timeInterval
    }
    
    private func removeObjects(count: Int) -> TimeInterval {
        var objectsArray = [Data]()
        for _ in 0 ..< count {
          objectsArray.append(Data())
        }
        self.setData = self.setData.union(objectsArray)
        
        let timeInterval =  TimeTools.runClosureForTime() {
          for itemToRemove in objectsArray {
            self.setData.remove(itemToRemove)
          }
        }
        
        return timeInterval
    }
    
    private func lookup(count: Int) -> TimeInterval {
        var objectsArray = [Data]()
        for _ in 0 ..< count {
          objectsArray.append(Data())
        }
        setData = setData.union(objectsArray)
        
        let timeInterval =  TimeTools.runClosureForTime() {
          for itemToFind in objectsArray {
            let _ = self.setData.firstIndex(of: itemToFind)
            // TODO: maybe remove
            //let _ = setData[index]
          }
        }
        
        for itemToRemove in objectsArray {
          setData.remove(itemToRemove)
        }
        
        return timeInterval
    }
    

    func create(numberOfItems: Int) {
        creation = TimeTools.runClosureForTime {
            for _ in 0...numberOfItems {
                let data = Data()
                self.setData.insert(data)
            }
        }
    }
    
    func add1Object() {
        added1ObjectTime = addObjects(1)
    }
    
    func add5Objects() {
        added5ObjectsTime = addObjects(5)
    }
    
    func add10Objects() {
        added10ObjectsTime = addObjects(10)
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
