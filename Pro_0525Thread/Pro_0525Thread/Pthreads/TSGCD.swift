//
//  TSGCD.swift
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/25.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

import UIKit

class TSGCD: NSObject {
    
    override init() {
        super.init()
        self.test()
    }
    
    func test() {
        // 主队列
        let mainQueue = DispatchQueue.main
        let nullQueue = DispatchQueue(label: "serailQueue");
        
        print("\(mainQueue) \(nullQueue)")
        
        
        
        
    }
    
}
