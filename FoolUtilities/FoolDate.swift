//
//  FoolDate.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/20.
//

import Foundation

public extension Date {
    
    func easyDate() -> String {
        let ti  = Date().timeIntervalSince(self)
        let suffix = ti > 0 ? "前" : "后"
        let timeInterval = abs(ti)
        var result: String = ""
        if timeInterval/60 < 1 {
            result = ti > 0 ? "刚刚" : "即将"
        } else {
            let temp: Double = timeInterval/60
            if temp < 60 {
                result = "\(Int(temp))分钟\(suffix)"
            } else {
                let temp: Double = timeInterval/60/60
                if temp < 24 {
                    result = "\(Int(temp))小时\(suffix)"
                } else {
                    let temp: Double = timeInterval / (24 * 60 * 60)
                    if temp < 30 {
                        result = "\(Int(temp))天\(suffix)"
                    } else {
                        let temp: Double = timeInterval/(30 * 24 * 60 * 60)
                        if temp < 12 {
                            result = "\(Int(temp))个月\(suffix)"
                        } else {
                            let temp: Double = timeInterval/(12 * 30 * 24 * 60 * 60)
                            result = "\(Int(temp))年\(suffix)"
                        }
                    }
                }
            }
        }
        return result
    }
    
}

public extension Double {
    
    func niceTime() -> String {
        if self < 60 {
            return NSString(format: "%.1fs", self) as String
        }
        let t = Int(self);
        let hours = t/60/60;
        let minutes = (t - hours * 60 * 60)/60;
        let seconds = t - hours * 60 * 60 - minutes * 60
        if hours > 0 {
            return NSString(format: "%dh%dm%ds", hours, minutes, seconds) as String
        } else {
            return NSString(format: "%dm%ds", minutes, seconds) as String
        }
    }
    
}
