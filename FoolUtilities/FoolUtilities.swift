//
//  FoolUtilities.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/20.
//

import Foundation

public func foolPrint<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    let now = Date()
    let dformatter = DateFormatter(); dformatter.dateFormat = "yy-MM-dd HH:mm:ss.SSSS"
    let time = dformatter.string(from: now)
    let fileName = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    let QueueName = isRunningInMainQueue() ? "M" : "c"
    print("\(time) \(fileName)[\(line)], \(method)[\(QueueName)]: \(message)")
    #endif
}

public func uInt64ToHumanReadable(input: UInt64, bBinary: Bool) -> String {
    let unit:UInt64 = bBinary ? 1024 : 1000;
    if input < unit { return String(describing: input)+" B"; }
    let exp:Int = Int(log(Double(input)) / log(Double(unit)));
    let units: String = (bBinary ? "KMGTPE": "kMGTPE");
    let startIndex = units.index(units.startIndex, offsetBy: exp-1);
    let endIndex = units.index(units.startIndex, offsetBy: exp-1);
    let str = units[startIndex...endIndex]+(bBinary ? "i": "");
    return String(format: "%.2f %@B",  Double(input) / pow(Double(unit), Double(exp)), str as CVarArg);
}

public func isRunningInMainQueue() -> Bool {
    let currentLabel = getCurrentQueueLabel()
    let mainLabel = DispatchQueue.main.label
    return currentLabel == mainLabel
}

public func getCurrentQueueLabel() -> String? {
    return String(cString: __dispatch_queue_get_label(nil), encoding: .utf8)
}
