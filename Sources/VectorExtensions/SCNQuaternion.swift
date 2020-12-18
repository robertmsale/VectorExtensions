#if canImport(SceneKit)
import SceneKit
import VectorProtocol
extension SCNQuaternion: Vector {
    
    #if os(macOS)
    public typealias BFP = CGFloat
    #else
    public typealias BFP = Float
    #endif
    public typealias Axis = V4Axis
    
    public subscript(axis: Axis) -> BFP {
        get {
            switch axis {
                case .x: return x
                case .y: return y
                case .z: return z
                case .w: return w
            }
        }
        set(v) {
            switch axis {
                case .x: x = v
                case .y: y = v
                case .z: z = v
                case .w: w = v
            }
        }
    }
    
    /// Normalize the quaternion values
    public mutating func normalize() {
        if length == 0 { x = 0; y = 0; z = 0; w = 1 }
        else {
            let l = 1 / length
            x *= l
            y *= l
            z *= l
            w *= l
        }
    }
    /// Normalize the quaternion values and return result
    public func normalized() -> Self {
        if length == 0 { return Self(0, 0, 0, 1) }
        else {
            let l = 1 / length
            return Self(x * l, y * l, z * l, w * l)
        }
    }
    
    /// Initialize Quaternion from a Euler rotation
    public init(euler e: Euler) {
        let c1 = cos(e.x / 2)
        let c2 = cos(e.y / 2)
        let c3 = cos(e.z / 2)

        let s1 = sin(e.x / 2)
        let s2 = sin(e.y / 2)
        let s3 = sin(e.z / 2)

        switch e.order {
            case .XYZ:
                let x = s1 * c2 * c3 + c1 * s2 * s3
                let y = c1 * s2 * s3 - s1 * c2 * s3
                let z = c1 * c2 * s3 + s1 * s2 * c3
                let w = c1 * c2 * c3 - s1 * s2 * s3
                self.init(x, y, z, w)
            case .YXZ:
                let x = s1 * c2 * c3 + c1 * s2 * s3
                let y = c1 * s2 * c3 - s1 * c2 * s3
                let z = c1 * c2 * s3 - s1 * s2 * c3
                let w = c1 * c2 * c3 + s1 * s2 * s3
                self.init(x, y, z, w)
            case .ZXY:
                let x = s1 * c2 * c3 - c1 * s2 * s3
                let y = c1 * s2 * c3 + s1 * c2 * s3
                let z = c1 * c2 * s3 + s1 * s2 * c3
                let w = c1 * c2 * c3 - s1 * s2 * s3
                self.init(x, y, z, w)
            case .ZYX:
                let x = s1 * c2 * c3 - c1 * s2 * s3
                let y = c1 * s2 * c3 + s1 * c2 * s3
                let z = c1 * c2 * s3 - s1 * s2 * c3
                let w = c1 * c2 * c3 + s1 * s2 * s3
                self.init(x, y, z, w)
            case .YZX:
                let x = s1 * c2 * c3 + c1 * s2 * s3
                let y = c1 * s2 * c3 + s1 * c2 * s3
                let z = c1 * c2 * s3 - s1 * s2 * c3
                let w = c1 * c2 * c3 - s1 * s2 * s3
                self.init(x, y, z, w)
            case .XZY:
                let x = s1 * c2 * c3 - c1 * s2 * s3
                let y = c1 * s2 * c3 - s1 * c2 * s3
                let z = c1 * c2 * s3 + s1 * s2 * c3
                let w = c1 * c2 * c3 + s1 * s2 * s3
                self.init(x, y, z, w)
        }
    }

    /// Initialize Quaternion from an axis of Vector3 and angle of *BFP*
    public init(axis: SCNVector3, angle: BFP) {
        let halfAngle = angle / 2
        let s = sin(halfAngle)
        self.init(axis.x * s, axis.y * s, axis.z * s, cos(halfAngle))
    }

    /// Initialize Quaternion from a 4x4 matrix
    public init(matrix m: SCNMatrix4) {
        let trace = m.m11 + m.m22 + m.m33
        var x: BFP = 0
        var y: BFP = 0
        var z: BFP = 0
        var w: BFP = 0
        if trace > 0 {
            let s = 0.5 * sqrt(trace + 1.0)
            w = 0.25 / s
            x = ( m.m32 - m.m23 ) * s
            y = ( m.m13 - m.m31 ) * s
            z = ( m.m21 - m.m12 ) * s
        } else if m.m11 > m.m22 && m.m11 > m.m33 {
            let s = 2.0 * sqrt( 1.0 + m.m11 - m.m22 - m.m33 )
            w = ( m.m32 - m.m23 ) / s
            x = 0.25 * s
            y = ( m.m12 + m.m21 ) / s
            z = ( m.m13 + m.m31 ) / s
        } else if m.m22 > m.m33 {
            let s = 2.0 * sqrt( 1.0 + m.m22 - m.m11 - m.m33 )
            w = ( m.m13 - m.m31 ) / s
            x = ( m.m12 + m.m21 ) / s
            y = 0.25 * s
            z = ( m.m23 + m.m32 ) / s
        } else {
            let s = 2.0 * sqrt( 1.0 + m.m33 - m.m11 - m.m22 )
            w = ( m.m21 - m.m12 ) / s
            x = ( m.m13 + m.m31 ) / s
            y = ( m.m23 + m.m32 ) / s
            z = 0.25 * s
        }
        self.init(x, y, z, w)
    }

    /// Initialize Quaternion from the rotation required to rotate from vector *from* to vector *to*
    public init(from: SCNVector3, to: SCNVector3) {
        let EPS: BFP = 0.000001
        var v = SCNQuaternion()

        var r = from.dotProduct(to) + 1

        if ( r < EPS ) {
            r = 0
            if abs(from.x) > abs(from.z) {
                v.x = -from.y; v.y = from.x; v.z = 0; v.w = r
            } else {
                v.x = 0; v.y = -from.z; v.z = from.y; v.w = r
            }
        } else {
            v.x = from.y * to.z - from.z * to.y
            v.y = from.z * to.x - from.x * to.z
            v.z = from.x * to.y - from.y * to.x
            v.w = r
        }
        v.normalize()
        self.init(v.x, v.y, v.z, v.w)
    }

    /// Set Quaternion from a Euler rotation
    public mutating func set(euler e: Euler) {
        let q = Self(euler: e)
        x = q.x; y = q.y; z = q.z; w = q.w
    }
    /// Set Quaternion from an axis of Vector3 and angle of *BFP*
    public mutating func set(axis: SCNVector3, angle: BFP) {
        let q = Self(axis: axis, angle: angle)
        x = q.x; y = q.y; z = q.z; w = q.w
    }
    /// Set Quaternion from a 4x4 matrix
    public mutating func set(matrix m: SCNMatrix4) {
        let q = Self(matrix: m)
        x = q.x; y = q.y; z = q.z; w = q.w
    }
    /// Set Quaternion from the rotation required to rotate from vector *from* to vector *to*
    public mutating func set(from: SCNVector3, to: SCNVector3) {
        let q = Self(from: from, to: to)
        x = q.x; y = q.y; z = q.z; w = q.w
    }

    /// Sets this quaternion to *a* times *b*
    public mutating func multiply(a: Self, b: Self) {
        x = a.x * b.w + a.w * b.x + a.y * b.z - a.z * b.y
        y = a.y * b.w + a.w * b.y + a.z * b.x - a.x * b.z
        z = a.z * b.w + a.w * b.z + a.x * b.y - a.y * b.x
        w = a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z
    }

    /// Calculate spherical linear interpollation between this quaternion and *q*. *t* represents the amount of rotation between this (where *t* === 0) and *q* (where *t* === 1)
    public mutating func slerp(q: Self, t: BFP) {

        if t == 0 { return }
        if t == 1 { self = q }

        var cosHalfTheta = w * q.w + x * q.x + y * q.y + z * q.z

        if ( cosHalfTheta < 0 ) {
            w = -q.w
            x = -q.x
            y = -q.y
            z = -q.z
            cosHalfTheta = -cosHalfTheta
        } else {
            x = q.x; y = q.y; z = q.z; w = q.w
        }

        if ( cosHalfTheta >= 1.0 ) { return }
        let sqrSinHalfTheta = 1.0 - cosHalfTheta * cosHalfTheta
        let EPS = BFP.ulpOfOne
        if sqrSinHalfTheta <= EPS {

            let s = 1 - t;
            w = s * w + t * w;
            x = s * x + t * x;
            y = s * y + t * y;
            z = s * z + t * z;

            self.normalize();
            return
        }

        let sinHalfTheta = sqrt( sqrSinHalfTheta )
        let halfTheta = atan2( sinHalfTheta, cosHalfTheta )
        let ratioA = sin( ( 1 - t ) * halfTheta ) / sinHalfTheta
        let ratioB = sin( t * halfTheta ) / sinHalfTheta

        w = ( w * ratioA + w * ratioB )
        x = ( x * ratioA + x * ratioB )
        y = ( y * ratioA + y * ratioB )
        z = ( z * ratioA + z * ratioB )
    }

    /// Calulate angle from this Quaternion to another
    public func angle(to: SCNQuaternion) -> BFP {
        let res = 2 * acos( abs( self.dotProduct(to).clamp(min: -1, max: 1) ) )
        return res
    }
    
    /// Variadic funtion for zeroing out axis values (overrides default implementation)
    public mutating func zero(_ axis: Axis...) {
        for a in axis { switch a { case .w: w = 1; case .x: x = 0; case .y: y = 0; case .z: z = 0 } }
    }

    public static func == (l: Self, r: Self) -> Bool {
        var res = true
        for a in Axis.allCases { if l[a] != r[a] { res = false } }
        return res
    }
}
#endif
