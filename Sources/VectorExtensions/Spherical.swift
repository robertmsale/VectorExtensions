import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import VectorProtocol

public struct Spherical {
    #if canImport(CoreGraphics)
    public typealias BFP = CGFloat
    #else
    public typealias BFP = Float
    #endif
    public var radius: BFP
    public var phi: BFP
    public var theta: BFP
    
    public mutating func makeSafe() {
        let EPS: BFP = 0.000001
        phi = max(EPS, min(BFP.pi - EPS, phi))
    }
}
