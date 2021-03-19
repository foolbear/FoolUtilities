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
        let suffix = ti > 0 ? "前".localized(.module) : "后".localized(.module)
        let timeInterval = abs(ti)
        var result: String = ""
        if timeInterval/60 < 1 {
            result = ti > 0 ? "刚刚".localized(.module) : "即将".localized(.module)
        } else {
            let temp: Double = timeInterval/60
            if temp < 60 {
                result = "\(Int(temp))" + "分钟".localized(.module) + "\(suffix)"
            } else {
                let temp: Double = timeInterval/60/60
                if temp < 24 {
                    result = "\(Int(temp))" + "小时".localized(.module) + "\(suffix)"
                } else {
                    let temp: Double = timeInterval / (24 * 60 * 60)
                    if temp < 30 {
                        result = "\(Int(temp))" + "天".localized(.module) + "\(suffix)"
                    } else {
                        let temp: Double = timeInterval/(30 * 24 * 60 * 60)
                        if temp < 12 {
                            result = "\(Int(temp))" + "个月".localized(.module) + "\(suffix)"
                        } else {
                            let temp: Double = timeInterval/(12 * 30 * 24 * 60 * 60)
                            result = "\(Int(temp))" + "年".localized(.module) + "\(suffix)"
                        }
                    }
                }
            }
        }
        return result
    }
    
    func toString(usingEasy easy: Bool = true) -> String {
        if easy {
            return self.easyDate()
        } else {
            let df = DateFormatter(); df.locale = .current; df.dateFormat = "yyyy-MM-dd HH:mm"
            return df.string(from: self)
        }
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
