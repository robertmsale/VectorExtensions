#if canImport(SceneKit)
import SceneKit
import VectorProtocol

infix operator ><: AdditionPrecedence
infix operator ><=: AdditionPrecedence

extension SCNVector3: Vector {
    #if os(macOS)
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
    
    /// Set Vector from Quaternion
    public mutating func set(quat q: SCNQuaternion) {
        var a: BFP, b: BFP, c: BFP, d: BFP = 0
        a = q.w * x; b = q.y * y; c = q.z * y
        let ix = a + b - c
        a = q.w * y; b = q.z * x; c = q.x * z
        let iy = a + b - c
        a = q.w * z; b = q.x * y; c = q.y * x
        let iz = a + b - c
        a = -q.x * x; b = q.y * y; c = q.z * z
        let iw = a - b - c
        a = ix * q.w; b = iw * -q.x; c = iy * -q.z; d = iz * -q.y
        x = a + b + c - d
        a = iy * q.w; b = iw * -q.y; c = iz * -q.x; d = ix * -q.z
        y = a + b + c - d
        a = iz * q.w; b = iw * -q.z; c = iz * -q.y; d = iy * -q.x
        z = a + b + c - d
    }
    /// Set Vector from 4x4 Matrix
    public mutating func set(matrix m: SCNMatrix4) {
        let w: BFP = 1 / ( m.m14 * x + m.m24 * y + m.m34 * z + m.m44 )
        x = ( m.m11 * x + m.m21 * y + m.m31 * z + m.m41 ) * w
        y = ( m.m12 * x + m.m22 * y + m.m32 * z + m.m42 ) * w
        z = ( m.m13 * x + m.m23 * y + m.m33 * z + m.m43 ) * w
    }
    /// Set Vector from *axis* Vector and *BFP* angle
    public mutating func set(axis: SCNVector3, angle: BFP) { set(quat: SCNQuaternion(axis: axis, angle: angle)) }
    /// Set Vector from Euler rotation
    public mutating func set(euler e: Euler) { set(quat: SCNQuaternion(euler: e)) }
    
    /// Calculate linear interpolation between this vector and another
    public mutating func lerp(_ v: Self, alpha: BFP) {
        x += ( v.x - x ) * alpha
        y += ( v.y - y ) * alpha
        z += ( v.z - z ) * alpha
    }
    /// Calculate linear interpolation between this vector and another, then return the result
    public func lerped(_ v: Self, alpha: BFP) -> Self { var new = self; new.lerp(v, alpha: alpha); return new }
    
    /// Calculate cross between this and another vector
    public mutating func cross(with v: Self) {
        let nx = y * v.z - z * v.y
        let ny = z * v.x - x * v.z
        let nz = x * v.y - y * v.x
        x = nx; y = ny; z = nz
    }
    /// Calculate cross between this and another vector, then return result
    public func crossed(with v: Self) -> Self { var new = self; new.cross(with: v); return new }
    

    public mutating func project(on v: Self) {
        let d = v.lengthSquared
        if d == 0 { self.zero(.x, .y, .z); return }
        
        let scalar = v.dotProduct(self) / d
        self.multiplyScalar(scalar)
    }
    public func projected(on v: Self) -> Self { var new = self; new.project(on: v); return new }
    
    /// Calculate angle between this and another vector, then return result in radians
    public func angle(to: Self) -> BFP {
        let d = sqrt(lengthSquared * to.lengthSquared)
        if d == 0 { return BFP.pi / 2 }
        let theta = dotProduct(to) / d
        return acos(theta.clamp(min: -1, max: 1))
    }
    
    public static func >< (l: Self, r: Self) -> Self { l.crossed(with: r) }
    public static func ><= (l: inout Self, r: Self) { l.cross(with: r) }
    public static func == (l: Self, r: Self) -> Bool {
        var res = true
        for a in Axis.allCases { if l[a] != r[a] { res = false } }
        return res
    }
}
#endif
