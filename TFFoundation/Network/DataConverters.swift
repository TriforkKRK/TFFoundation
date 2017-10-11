//
// MIT License
//
// Copyright (c) 2017 Trifork Kraków Office
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation
import UIKit

/// Types that conform to the DataConverterter protocol can convert Data to any TargetType.
public protocol DataConverterter {
    associatedtype TargetType
    static func makeInstance(from data: Data) throws -> TargetType
}

/// Noop converter. Returns unaltered Data.
public struct DataToDataConverter: DataConverterter {
    public static func makeInstance(from data: Data) -> Data { return data }
}

/// Converts Data to UTF-8 String.
public struct DataToUTF8StringConverter: DataConverterter {
    
    enum ConversionError: Error { case initializationFailed }
    
    public static func makeInstance(from data: Data) throws -> String {
        guard let string = String(data: data, encoding: .utf8) else { throw ConversionError.initializationFailed }
        return string
    }
}

/// Converts Data to UIImage.
public struct DataToImageConverter: DataConverterter {
    
    enum ConversionError: Error { case initializationFailed }
    
    public static func makeInstance(from data: Data) throws -> UIImage {
        guard let image = UIImage(data: data, scale: UIScreen.main.scale) else { throw ConversionError.initializationFailed }
        return image
    }
}
