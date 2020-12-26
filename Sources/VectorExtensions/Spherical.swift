import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif
import VectorProtocol

public struct Spherical {
    #if os(macOS) && canImport(CoreGraphics)
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
    
    public init(radius r: BFP, phi p: BFP, theta t: BFP) {
        radius = r
        phi = p
        theta = t
    }
    public init() {
        self.init(radius: 0, phi: 0, theta: 0)
    }
}
