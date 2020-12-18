#if canImport(CoreGraphics)
import CoreGraphics
#endif
import VectorProtocol
public struct Euler: Vector {
    #if os(macOS) && canImport(CoreGraphics)
    public typealias BFP = CGFloat
    #else
    public typealias BFP = Float
    #endif
    public typealias Axis = V3Axis
    public subscript(axis: Axis) -> BFP {
        get {
            switch axis {
                case .x: return x
                case .y: return y
                case .z: return z
            }
        }
        set(v) {
            switch axis {
                case .x: x = v
                case .y: y = v
                case .z: z = v
            }
        }
    }
    
    public var x: BFP
    public var y: BFP
    public var z: BFP
    public enum Order { case XYZ, YXZ, ZXY, ZYX, YZX, XZY }
    /// The order of which a rotation will be applied to some geometry
    public var order: Order
}
