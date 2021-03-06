//
//  FoolString.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/20.
//

import Foundation
import UIKit

public extension Optional where Wrapped == String {
    func toString(default: String) -> String {
        guard let self = self, self.isEmpty == false else { return `default` }
        return self
    }
}

public extension Optional where Wrapped == String {
    var imageQRCode: UIImage? {
        guard let self = self else { return nil }
        return self.imageQRCode
    }
}

public extension String {
    enum SizeAvailable { case available, empty, oversize }
    
    var utf8Data: Data? { return self.data(using: .utf8) }
    var localized: String { return NSLocalizedString(self, comment: self) }
    
    func localized(_ bundle: Bundle = Bundle.main) -> String {
        NSLocalizedString(self, bundle: bundle, comment: self)
    }
    
    static func localizer() -> (_ key: String, _ params: CVaListPointer) -> String {
        return { (key: String, params: CVaListPointer) in return NSString(format: key.localized, arguments: params) as String }
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return withVaList(arguments) { String.localizer()(self, $0) }
    }
    
    func subString(start: Int, length: Int = -1) -> String {
        let count = self.count
        var len = length
        if len == -1 {
            len = self.count - start
        }
        if start + len > count {
            len = count - start
        }
        let s = self.index(self.startIndex, offsetBy: start)
        let e = self.index(s, offsetBy: len)
        return String(self[s ..< e])
    }
    
    func isSizeAvailable(_ maxSize: Int = 0) -> SizeAvailable {
        if maxSize != 0 && self.count > maxSize {
            return .oversize
        }
        return self.isEmpty ? .empty : .available
    }
    
    func truncated(_ maxSize: Int) -> String {
        if self.count > maxSize {
            return self.subString(start: 0, length: maxSize)
        }
        return self
    }
    
    mutating func truncate(_ maxSize: Int) {
        if self.count > maxSize {
            self = self.subString(start: 0, length: maxSize)
        }
    }
}
 
public extension String {
    var imageQRCode: UIImage? {
        guard let data = self.data(using: .utf8), let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else { return nil }
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
