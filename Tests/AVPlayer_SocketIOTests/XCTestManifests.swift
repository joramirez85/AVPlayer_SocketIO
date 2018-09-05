import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AVPlayer_SocketIOTests.allTests),
    ]
}
#endif