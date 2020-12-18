//  CGPoint.swift
//  Created by Robert Sale on 11/21/20.

#if canImport(CoreGraphics)
import CoreGraphics
import VectorProtocol

extension CGPoint: Vector {
    public typealias BFP = CGFloat
    public typealias Axis = V2Axis
    public subscript(axis: Axis) -> BFP {
        get {
            switch axis {
                case .x: return x
                case .y: return y
            }
        }
        set(v) {
            switch axis {
                case .x: x = v
                case .y: y = v
            }
        }
    }
    
    /// Rotate Vector around an origin point
    public mutating func rotate(degrees: BFP, origin: Self = Self.zero) {
        let n = self.translated(origin.flipped(.x, .y))
        let theta = degrees.rad
        let cs = cos(theta)
        let sn = sin(theta)
        let dx = n.x * cs - n.y * sn
        let dy = n.x * sn - n.y * cs
        x = dx; y = dy; self.translate(origin)
    }
    /// Rotate Vector around an origin point and return resulting vector
    public func rotated(degrees: BFP, origin: Self = Self.zero) -> Self {
        let n = self.translated(origin.flipped(.x, .y))
        let theta = degrees.rad
        let cs = cos(theta)
        let sn = sin(theta)
        let dx = n.x * cs - n.y * sn
        let dy = n.x * sn - n.y * cs
        return Self(x: dx, y: dy).translated(origin)
    }
}

extension CGSize: Vector {
    public typealias BFP = CGFloat
    public typealias Axis = V2Axis
    public subscript(axis: Axis) -> BFP {
        get {
            switch axis {
                case .x: return width
                case .y: return height
            }
        }
        set(v) {
            switch axis {
                case .x: width = v
                case .y: height = v
            }
        }
    }
}
#endif
