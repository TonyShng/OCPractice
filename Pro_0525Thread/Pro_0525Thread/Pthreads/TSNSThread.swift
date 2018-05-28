//
//  TSNSThread.swift
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/25.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

import UIKit

class TSNSThread: NSObject {
    
    override init() {
        super.init()
        self.test()
    }
    
    func test(){
        // 创建一个线程
        let thread = Thread(target: self, selector: Selector(("run:")), object: "Thread1");
        // 线程启动
        thread.start()
        
        // 创建并自动启动
        Thread.detachNewThreadSelector(Selector(("run:")), toTarget: self, with: "Thread2")
        
        // NSObject方法创建并自动启动一个线程
        self .performSelector(inBackground: Selector(("run:")), with: "Thread3")
        
        // 判断线程是否在执行
//        thread.isExecuting
        
        // 判断线程是否执行完成
//        thread.isFinished
        
        // 判断线程是否取消
//            thread.isCancelled;
        
        // 设置线程名字
//        thread.name = ""
        
        // 查看线程名字
//            thread.name
        
        // 获取当前线程信息
//        Thread.current
        
        // 获取主线程信息
//        Thread.main
        
        // 使当前线程暂停一段时间 或 到某个时刻
//        Thread.sleep(forTimeInterval: 0.5)
        
//        Thread.sleep(until:Date);
        
    }
    
    func run(object : NSObject) {
        print("currentThread \(Thread.current) \(object)")
    }
}
