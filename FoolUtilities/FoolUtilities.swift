//
//  FoolUtilities.swift
//  Reading
//
//  Created by foolbear on 2017/5/4.
//  Copyright © 2017年 Foolbear Co.,Ltd. All rights reserved.
//

import Foundation

func foolPrint<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
#if DEBUG
    let now = Date()
    let dformatter = DateFormatter(); dformatter.dateFormat = "yy-MM-dd HH:mm:ss"
    let time = dformatter.string(from: now)
    let fileName = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    print("\(time) \(fileName)[\(line)], \(method): \(message)")
#endif
}
