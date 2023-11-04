# VectorExtensions

# Archive Notice
This repository is now archived. The algorithms in this Swift package are not performant and it is recommended that you use [SIMDExtensions](https://github.com/robertmsale/SIMDExtensions) if you are looking for an explicitly typed way of doing vector arithmetic. SIMD is made easy with Apple's framework, and SIMDExtensions is an API that cuts down on the effort of reading through code documentation to figure out what c-style SIMD function will work with what SIMD types. It also includes utilities similar to the ones present in this project. This repository will remain here for educational purposes because it showcases the power of the protocol-oriented nature of Swift. This package is no longer used in FieldFab for iOS.

This Swift package enhances the functionality of the built in Vector data types for SceneKit and Core Graphics, making it much easier to work with procedurally generated 2D and 3D content. This package is also one of the many core components powering [FieldFab](https://fieldfab.net) for iOS.

If you do not want to extend the built in data types, but would like to roll your own Vector data types, see the [VectorProtocol](https://github.com/robertmsale/VectorProtocol) page. VectorExtensions depends upon VectorProtocol.

## Features
- Advanced mathematical functions integrated for CGPoint, SCNVector3, and SCNQuaternion using protocol composition, making the library extremely small and easy to maintain
- Compiler flags that allow this package to be compiled for iOS or macOS, using the correct underlying data types
- Euler and Spherical data types included in addition, making it easier to deal with vector rotations of different kinds
- Code documentation that covers usage and allows for descriptive SourceKit LSP code completions in Xcode
- XCTest suite included
- Extensions to the BinaryFloatingPoint protocol with useful mathematical functions
- VectorProtocol allows you to roll your own data types

## Usage

![FieldFab VectorExtensions implementation in action](https://www.fieldfab.net/wp-content/uploads/2020/10/2020-10-16-07.18.16.gif)

With this swift package, working with procedurally generated 2D and 3D content is a piece of cake. Rather than converting to and from SIMD data types just to perform vector calculations, you can do all of them on the data types that SceneKit and CoreGraphics (or SpriteKit with CGPoint) use. The beauty is in the underlying VectorProtocol. Since many operations, such as working with scalars, normalizing, calculating distance, or testing for equality, are common among all Vector types, the math is pretty much the same. Rather than write enormous extensions for each type, they conform to a protocol with default implementations for each calculation, taking into account how many axes they store. This makes the code very easy to maintain. 

## Vector

Protocol which adds common functionality to any conforming Vector types

``` swift
public protocol Vector: Equatable
```

### Inheritance

`Equatable`

### Properties and Methods

`mutating func addScalar(scale s: BFP) `
Add scale to every axis

`mutating func addScalar(_ s: BFP) `
Add scale to every axis

`func addedScalar(scale s: BFP) -> Self `
Add scale to every axis and return new vector

`func addedScalar(_ s: BFP) -> Self `
Add scale to every axis and return new vector

`mutating func add(_ v: Self) `
Add some vector to this vector

`func added(_ v: Self) -> Self `
Add some vector to this vector and return new vector

`mutating func subScalar(scale s: BFP) `
Subtract scalar from every axis

`mutating func subScalar(_ s: BFP) `
Subtract scalar from every axis

`func subbedScalar(scale s: BFP) -> Self `
Subtract scalar from every axis and return new vector

`func subbedScalar(_ s: BFP) -> Self `
Subtract scalar from every axis and return new vector

`mutating func sub(_ v: Self) `
Subtract some vector from this vector

`func subbed(_ v: Self) -> Self `
Subtract some vector from this vector and return new vector

`mutating func multiplyScalar(scale s: BFP) `
Multiply scalar from every axis

`mutating func multiplyScalar(_ s: BFP) `
Multiply scalar from every axis

`func multipliedScalar(scale s: BFP) -> Self `
Multiply scalar from every axis and return new vector

`func multipliedScalar(_ s: BFP) -> Self `
Multiply scalar from every axis and return new vector

`mutating func multiply(_ v: Self) `
Multiply this vector by some vector

`func multiplied(_ v: Self) -> Self `
Multiply this vector by some vector and return new vector

`mutating func divideScalar(scale s: BFP) `
Divide scalar from every axis

`mutating func divideScalar(_ s: BFP) `
Divide scalar from every axis

`func dividedScalar(scale s: BFP) -> Self `
Divide scalar from every axis and return new vector

`func dividedScalar(_ s: BFP) -> Self `
Divide scalar from every axis and return new vector

`mutating func divide(_ v: Self) `
Divide this vector by some vector

`func divided(_ v: Self) -> Self `
Divide this vector by some vector and return new vector

`mutating func translate(coordinates c: [Axis: BFP]) `
Take a dictionary, where the keys are *Axis* and the values are *BFP*, and translate this Vector's axes by those values

`mutating func translate(_ c: [Axis: BFP]) `
Take a dictionary, where the keys are *Axis* and the values are *BFP*, and translate this Vector's axes by those values

`mutating func translate(_ v: Self) `
Translate this vector by the values of another vector

`func translated(coordinates c: [Axis: BFP]) -> Self `
Take a dictionary, where the keys are *Axis* and the values are *BFP*, translate this Vector's axes by those values, and return new vector

`func translated(_ c: [Axis: BFP]) -> Self `
Take a dictionary, where the keys are *Axis* and the values are *BFP*, and translate this Vector's axes by those values

`func translated(_ v: Self) -> Self `
Translate this vector by the values of another vector and return new vector

`mutating func flip(_ axis: Axis...) `
Variadic function for flipping, or inverting, each axis

`func flipped(_ axis: Axis...) -> Self `
Variadic function for flipping, or inverting, each axis, then returning new vector

`mutating func zero(_ axis: Axis...) `
Zero out selected axes

`func zeroed(_ axis: Axis...) -> Self `
Zero out selected axes and return new vector

`mutating func floor() `
Floor the value of each axis

`func floored() -> Self `
Floor the value of each axis and return new vector

`mutating func ceil() `
Ceil the value of each axis

`func ceiled() -> Self `
Ceil the value of each axis and return new vector

`mutating func round() `
Round each axis using schoolbook rounding (to nearest whole number)

`func rounded() -> Self `
Round each axis using schoolbook rounding (to nearest whole number) and return result

`mutating func round(to: BFP) `
Round each axis to the nearest *BFP*

`func rounded(to: BFP) -> Self `
Round each axis to the nearest *BFP* and return result

`mutating func roundToZero() `
Round each axis towards zero

`func roundedToZero() -> Self `
Round each axis towards zero and return result

`func distanceSquared(_ to: Self) -> BFP `
Get the distance between two vectors

`func distance(_ to: Self) -> BFP `
Get the distance between two vectors ( precise )

`func manhattanDistance(_ to: Self) -> BFP `
Get the distance between two vectors at each whole step, one direction at a time (like traversing city blocks)

`var lengthSquared: BFP `
Get the length

`var length: BFP `
Get the length ( precise )

`var manhattanLength: BFP `
Get the length from Zero at each whole step, one direction at a time

`func dotProduct(_ v: Self) -> BFP `
Get the dot product of two vectors

`func crossProduct(_ v: Self) -> BFP `
Get the cross product of two vectors

`mutating func normalize() `
Normalize the vector

`func normalized() -> Self `
Normalize and return new vector

`static func + (l: Self, r: Self) -> Self`
Add two vectors together and return result

`static func - (l: Self, r: Self) -> Self`
Subtract two vectors from each other and return result

`static func * (l: Self, r: Self) -> Self`
Multiply two vectors together and return result

`static func / (l: Self, r: Self) -> Self`
Divide two vectors and return result

`static func += (l: inout Self, r: Self)`
Add a vector to this vector

`static func -= (l: inout Self, r: Self)`
Subtract a vector from this vector

`static func *= (l: inout Self, r: Self)`
Multiply this vector by another vector

`static func /= (l: inout Self, r: Self)`
Divide this vector by another vector

`static func + (l: Self, r: BFP)`
Add a scalar to this vector and return result

`static func - (l: Self, r: BFP)`
Subtract a scalar from this vector and return result

`static func * (l: Self, r: BFP)`
Multiply this vector by a scalar and return result

`static func / (l: Self, r: BFP)`
Divide this vector by a scalar and return result

`static func += (l: inout Self, r: BFP) { l.addScalar(r) }`
Add a scalar to this vector

`static func -= (l: inout Self, r: BFP) { l.subScalar(r) }`
Subtract a scalar from this vector

`static func *= (l: inout Self, r: BFP) { l.multiplyScalar(r) }`
Multiply this vector by a scalar

`static func /= (l: inout Self, r: BFP) { l.divideScalar(r == 0 ? 1 : r) }`
Divide this vector by a scalar

`static prefix func - (v: Self) -> Self`
Invert all axes of this vector and return result
