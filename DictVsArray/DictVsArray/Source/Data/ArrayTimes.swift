//
//  ArrayTimes.swift
//  DictVsArray
//
//  Created by Petra Čačkov on 06/01/2021.
//

import UIKit

class ArrayTimes: Time {
    var creation: TimeInterval?
    
    var added1ObjectTime: TimeInterval?
    
    var added5ObjectsTime: TimeInterval?
    
    var added10ObjectsTime: TimeInterval?
    
    var removed1ObjectTime: TimeInterval?
    
    var removed5ObjectsTime: TimeInterval?
    
    var removed10ObjectsTime: TimeInterval?
    
    var lookup1ObjectTime: TimeInterval?
    
    var lookup10ObjectsTime: TimeInterval?
    
    
    
    

    private var addingItemAtBeginning: TimeInterval?
    private var addingItemInTheMiddle: TimeInterval?
    private var addingItemAtTheEnd: TimeInterval?
    private var removedItemAtTheBeginning: TimeInterval?
    private var removedItemAtTheMiddle: TimeInterval?
    private var removedItemAtTheEnd: TimeInterval?
    private var foundItemAtTheBeginning: TimeInterval?
    private var foundItemAtTheMiddle: TimeInterval?
    private var findItemAtTheEnd: TimeInterval?
    
    private var arrayData: [Data] = [Data]()
    
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
        data.append(("addingItemAtBeginning", addingItemAtBeginning))
        data.append(("addingItemInTheMiddle", addingItemInTheMiddle))
        data.append(("addingItemAtTheEnd", addingItemAtTheEnd))
        data.append(("removedItemAtTheBeginning", removedItemAtTheBeginning))
        data.append(("removedItemAtTheMiddle", removedItemAtTheMiddle))
        data.append(("removedItemAtTheEnd", removedItemAtTheEnd))
        return data
    }
    
    func create(numberOfItems: Int) {
        creation = TimeTools.runClosureForTime {
            for _ in 0..<numberOfItems {
                let data = Data()
                self.arrayData.append(data)
            }
        }
    }
    
    private func addObjects(_ count: Int) -> TimeInterval {
        var objectsArray = [Data]()
        for _ in 0 ..< count {
          objectsArray.append(Data())
        }
        
        let timeInterval = TimeTools.runClosureForTime() {
            objectsArray.forEach { self.arrayData.append($0) }
        }
        
        // Reset
        for itemToRemove in objectsArray {
            arrayData = arrayData.filter { $0.id != itemToRemove.id }
        }
        
        return timeInterval
    }
    
    private func removeObjects(count: Int) -> TimeInterval {
        var objectsArray = [Data]()
        for _ in 0 ..< count {
          objectsArray.append(Data())
        }
        
        objectsArray.forEach { self.arrayData.append($0) }
        
        let timeInterval =  TimeTools.runClosureForTime() {
          for itemToRemove in objectsArray {
            self.arrayData = self.arrayData.filter { $0.id != itemToRemove.id }
          }
        }
        
        return timeInterval
    }
    
    private func lookup(count: Int) -> TimeInterval {
        var objectsArray = [Data]()
        for _ in 0 ..< count {
          objectsArray.append(Data())
        }
        objectsArray.forEach { self.arrayData.append($0) }
        
        let timeInterval =  TimeTools.runClosureForTime() {
          for itemToFind in objectsArray {
            let _ = self.arrayData.first(where: { itemToFind.id == $0.id })
          }
        }
        
        for itemToRemove in objectsArray {
            arrayData = arrayData.filter { itemToRemove.id == $0.id }
        }
        
        return timeInterval
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
    
    func insertItemAtTheBeginning() {
        let data = Data()
        addingItemAtBeginning = TimeTools.runClosureForTime {
            self.arrayData.insert(data, at: 0)
        }
        // Reset
        self.arrayData.removeFirst()
    }
    
    func insertItemAtTheEnd() {
        let data = Data()
        addingItemAtTheEnd = TimeTools.runClosureForTime {
            self.arrayData.append(data)
        }
        // Reset
        self.arrayData.removeLast()
    }
    
    func insertItemAtTheMiddle() {
        let data = Data()
        let halfCount = Int(arrayData.count/2)
        addingItemInTheMiddle = TimeTools.runClosureForTime {
            self.arrayData.insert(data, at: halfCount)
        }
        // Reset
        self.arrayData.remove(at: halfCount)
    }
    
    func removeItemAtTheBeginning() {
        var data = Data()
        removedItemAtTheBeginning = TimeTools.runClosureForTime {
            data = self.arrayData.removeFirst()
        }
        // Reset
        self.arrayData.insert(data, at: 0)
    }
    
    func removeItemAtTheEnd() {
        var data = Data()
        removedItemAtTheEnd = TimeTools.runClosureForTime {
            data = self.arrayData.removeLast()
        }
        // Reset
        self.arrayData.append(data)
    }
    
    func removeItemAtTheMiddle() {
        var data = Data()
        let halfCount = Int(arrayData.count/2)
        removedItemAtTheMiddle = TimeTools.runClosureForTime {
            data = self.arrayData.remove(at: halfCount)
        }
        // Reset
        self.arrayData.insert(data, at: halfCount)
    }
    
}
