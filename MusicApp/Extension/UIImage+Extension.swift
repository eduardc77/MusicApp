//
//  UIImage+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

extension UIImage {
  var firstAverageColor: UIColor? {
    guard let inputImage = CIImage(image: self) else { return nil }
    
    var bitmap = [UInt8](repeating: 0, count: 4)
    let context = CIContext()
    let extent = inputImage.extent
    let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
    
    guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent]), let outputImage = filter.outputImage else { return nil }
    
    let outputExtent = outputImage.extent
    assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)
    
    // Render to bitmap.
    context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
    
    // Compute result.
    let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: 1)
    
    return result
  }
  
  var secondAverageColor: UIColor? {
    guard let inputImage = cgImage ?? CIContext().createCGImage(ciImage!, from: ciImage!.extent) else { return nil }
    var bitmap = [UInt8](repeating: 0, count: 4)
    
    // Create 1x1 context that interpolates pixels when drawing to it.
    let context = CGContext(data: &bitmap, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    
    // Render to bitmap.
    context.draw(inputImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))
    
    // Compute result.
    let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: 1)
    
    return result
  }
}
