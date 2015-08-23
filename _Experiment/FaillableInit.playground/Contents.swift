//: Playground - noun: a place where people can play

import Foundation

class myClass {
    
    init?(success: Bool) {
        if !success {
            return nil
        }
    }
    
    convenience init() {
        self.init(success: false)
        
    }
}


