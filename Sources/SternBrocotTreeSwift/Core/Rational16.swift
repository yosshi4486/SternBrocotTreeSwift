//
//  Rational16.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

/// A rational type for value semantics.
public struct Rational16 : MutableSignedRational {

    public typealias Number = Int16

    /// The numerator of the rational number.
    public var numerator: Int16

    /// The denominator of the rational number.
    public var denominator: Int16

    public init(numerator: Int16, denominator: Int16) {
        self.numerator = numerator
        self.denominator = denominator
    }

    public init(_ stringValue: String) {
        let splited = stringValue.split(separator: "/")

        let numerator = Int16(splited[0])!
        let denominator = Int16(splited[1])!

        self.init(numerator: numerator, denominator: denominator)
    }

    // Ignore zero denominator error
    private init(_ numerator: Int16, _ denominator: Int16) {
        self.numerator = numerator
        self.denominator = denominator
    }

}

extension Rational16 : SBTreeNode {

    public var rationalRepresentation: Rational {
        return Rational(numerator: Int(numerator), denominator: Int(denominator))
    }

}
