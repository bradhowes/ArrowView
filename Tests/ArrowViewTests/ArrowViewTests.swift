import XCTest
import SnapshotTesting
@testable import ArrowView

final class ArrowViewTests: XCTestCase {

  override func setUp() {
    isRecording = false
    super.setUp()
  }

  func makeName(_ funcName: String) -> String {
    let platform: String
#if os(macOS)
    platform = "macOS"
#elseif os(iOS)
    platform = "iOS"
#else
    platform = "unknown"
#endif
    return funcName + "-" + platform
  }

  func assertSnapshot(matching: ArrowView, file: StaticString = #file, testName: String = #function, line: UInt = #line) throws {
    let env = ProcessInfo.processInfo.environment

    for key in env.keys {
      print("\(key) = \(env[key]!)")
    }

    try XCTSkipIf(ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW"), "GitHub CI")
    SnapshotTesting.assertSnapshot(matching: matching, as: .image, named: makeName(testName), file: file, testName: testName, line: line)
  }

  func testDefault() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    try assertSnapshot(matching: view)
  }

  func testLeftLeft() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .left
    view.exit = .left
    try assertSnapshot(matching: view)
  }

  func testLeftTop() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .left
    view.exit = .top
    try assertSnapshot(matching: view)
  }

  func testLeftRight() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .left
    view.exit = .right
    try assertSnapshot(matching: view)
  }

  func testLeftBottom() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .left
    view.exit = .bottom
    try assertSnapshot(matching: view)
  }

  func testTopTop() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .top
    view.exit = .top
    try assertSnapshot(matching: view)
  }

  func testTopRight() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .top
    view.exit = .right
    try assertSnapshot(matching: view)
  }

  func testTopBottom() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .top
    view.exit = .bottom
    try assertSnapshot(matching: view)
  }

  func testTopLeft() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .top
    view.exit = .left
    try assertSnapshot(matching: view)
  }

  func testRightRight() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .right
    view.exit = .right
    try assertSnapshot(matching: view)
  }

  func testRightBottom() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .right
    view.exit = .bottom
    try assertSnapshot(matching: view)
  }

  func testRightLeft() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .right
    view.exit = .left
    try assertSnapshot(matching: view)
  }

  func testRightTop() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .right
    view.exit = .top
    try assertSnapshot(matching: view)
  }

  func testBottomBottom() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .bottom
    view.exit = .bottom
    try assertSnapshot(matching: view)
  }

  func testBottomLeft() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .bottom
    view.exit = .left
    try assertSnapshot(matching: view)
  }

  func testBottomTop() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .bottom
    view.exit = .top
    try assertSnapshot(matching: view)
  }

  func testBottomRight() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .bottom
    view.exit = .right
    try assertSnapshot(matching: view)
  }

  func testLineWidth() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.lineWidth = 0.5
    try assertSnapshot(matching: view)
  }

  func testLineColor() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.lineColor = .systemBlue
    try assertSnapshot(matching: view)
  }

  func testArrowWidth() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.arrowWidth = 4.25
    try assertSnapshot(matching: view)
  }

  func testArrowLength() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.arrowLength = 5.0
    try assertSnapshot(matching: view)
  }

  func testBendFactor() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.bendFactor = 0.4
    try assertSnapshot(matching: view)
  }

  func testWavyFactor() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    view.entry = .left
    view.exit = .right
    view.wavyFactor = 1.0
    try assertSnapshot(matching: view)
  }

  func testEntryIB() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    XCTAssertEqual(view.entry, ArrowView.Position.left)
    view.entryIB = 1
    XCTAssertEqual(view.entry, ArrowView.Position.top)
    view.entry = .right
    XCTAssertEqual(view.entryIB, ArrowView.Position.right.rawValue)
  }

  func testExitIB() throws {
    let view = ArrowView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    XCTAssertEqual(view.exit, ArrowView.Position.bottom)
    view.exitIB = 1
    XCTAssertEqual(view.exit, ArrowView.Position.top)
    view.exit = .right
    XCTAssertEqual(view.exitIB, ArrowView.Position.right.rawValue)
  }

  static var allTests = [
    ("testDefault", testDefault),
  ]
}
