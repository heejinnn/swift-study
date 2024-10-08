//
//  CwlCatchException.swift
//  CwlAssertionTesting
//
//  Created by Matt Gallagher on 2016/01/10.
//  Copyright © 2016 Matt Gallagher ( https://www.cocoawithlove.com ). All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
//  SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
//  IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
//

import Foundation

#if SWIFT_PACKAGE || COCOAPODS
import CwlCatchExceptionSupport
#endif

private func catchReturnTypeConverter<Exception: NSException>(_ type: Exception.Type, block: () -> Void) -> Exception? {
	return catchExceptionOfKind(type, block) as? Exception
}

extension NSException {
	public static func catchException(in block: () -> Void) -> Self? {
		return catchReturnTypeConverter(self, block: block)
	}
}

public func catchExceptionAsError<Output>(in block: (() throws -> Output)) throws -> Output {
	var result: Result<Output, Error>?
	
	let exception = NSException.catchException {
		result = Result(catching: block)
	}
	
	if let exception = exception {
		throw ExceptionError(exception)
	}
	
	return try result!.get()
}

// Adding conformance so that ExceptionError is fully Sendable as part of CustomNSError
#if compiler(<6.0)
extension NSException: @unchecked Sendable { }
#else
// @retroactive not available until Xcode 16 / Swift 6
extension NSException: @unchecked @retroactive Sendable { }
#endif

public struct ExceptionError: CustomNSError {
	public let exception: NSException
	public let domain = "com.cocoawithlove.catch-exception"
	public let errorUserInfo: [String: Any]
	
	public init(_ exception: NSException) {
		self.exception = exception
		
		if let userInfo = exception.userInfo {
			self.errorUserInfo = [String: Any](uniqueKeysWithValues: userInfo.map { pair in
				(pair.key.description, pair.value)
			})
		} else {
			self.errorUserInfo = [:]
		}
	}
}
