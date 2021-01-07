//
//  Time.swift
//  DictVsArray
//
//  Created by Petra Čačkov on 05/01/2021.
//

import UIKit

protocol Time {

    var creation: TimeInterval? { get set }
    var added1ObjectTime: TimeInterval? { get set }
    var added5ObjectsTime: TimeInterval? { get set }
    var added10ObjectsTime: TimeInterval? { get set }
    var removed1ObjectTime: TimeInterval? { get set }
    var removed5ObjectsTime: TimeInterval? { get set }
    var removed10ObjectsTime: TimeInterval? { get set }
    var lookup1ObjectTime: TimeInterval? { get set }
    var lookup10ObjectsTime: TimeInterval? { get set }
    
    func getAllData() -> [(title: String, timeInterval: TimeInterval?)]
    func create(numberOfItems: Int) 
    func add1Object()
    func add5Objects()
    func add10Objects()
    func remove1Object()
    func remove5Objects()
    func remove10Objects()
    func lookup1Object()
    func lookup10Objects()
    
}
