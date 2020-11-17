//
//  Intermediate.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/11.
//

import Foundation

/// An error that is thrown in `intermediate`.
public enum IntermediateError : LocalizedError {

    case negativeArgument(lhs: Rational, rhs: Rational)

    case leftMustBeSmallerThanRight(lhs: Rational, rhs: Rational)

    case overflow(lhs: Rational, rhs: Rational)

    public var errorDescription: String? {
        switch self {
        case .negativeArgument(let lhs, let rhs):
            return "arguments(lhs: \(lhs), rhs: \(rhs) must be non-negative"

        case .leftMustBeSmallerThanRight(let lhs, let rhs):
            return "left argument(\(lhs)) must be strictly smaller than right(\(rhs))"

        case .overflow(lhs: let lhs, rhs: let rhs):
            return "numerator or denominator of new node exceeds Int32.max, it means overflow. lhs: \(lhs), rhs: \(rhs)"
        }
    }

}

/// Returns a new node from the given left and right nodes.
///
/// This function finds proper fruction for new node like bellow:
///
///     let initialNode = try intermediate(nil, nil)
///     // initialNode.description is 1/1
///
///     let secondNode = try intermediate(initialNode, nil)
///     // secondNode.description is 2/1
///
///     let thirdNode = try intermediate(secondNode, nil)
///     // thirdNode.description is 3/1
///
/// Give the left and right argument if possible.
///
/// - Parameters:
///   - left: The node positioned at left of inserting postion you expected.
///   - right: The node positioned at right of inserting postion you expected.
///
/// - Throws: If you see `.overflow` error, user may walk fibonacci path 47 times. In that situation, re-normalization should be executed.
///
/// - Returns:
public func intermediate(left: Rational?, right: Rational?) throws -> Rational {

    var low = Rational.rootLow
    var high = Rational.rootHigh

    let left = left ?? low
    let right = right ?? high

    if left < low || right < low {
        throw IntermediateError.negativeArgument(lhs: left, rhs: right)
    }

    if left >= right {
        throw IntermediateError.leftMustBeSmallerThanRight(lhs: left, rhs: right)
    }

    var mediant: Rational?
    while true {
        mediant = try Rational.mediant(left: low, right: high)

        if mediant! <= left {
            low = mediant!
        } else if right <= mediant! {
            high = mediant!
        } else {
            break
        }
    }

    return mediant!
}

