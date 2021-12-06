// Copyright © 2021 Brad Howes. All rights reserved.

import UIKit

/**
 Custom UIView that draws an arrow between an entry and an exit point on the border of the view.
 */
@IBDesignable open class ArrowView: UIView {

  /**
   Supported locations for an entry or an exit
   */
  public enum Position: Int, CaseIterable {
    case left
    case top
    case right
    case bottom
  }

  /// Entry point for the arrow in this view
  open var entry: Position = .left { didSet { createPath() } }
  @IBInspectable open var entryIB: Int {
    get { entry.rawValue }
    set { entry = Position(rawValue: newValue) ?? .left }
  }

  /// Exit point for the arrow in this view
  open var exit: Position = .bottom { didSet { createPath() } }
  @IBInspectable open var exitIB: Int {
    get { exit.rawValue }
    set { exit = Position(rawValue: newValue) ?? .bottom }
  }

  /// Line width of the line
  @IBInspectable open var lineWidth: CGFloat = 2.0 { didSet { pathLayer.lineWidth = lineWidth } }

  /// Width of the arrow head flaring (gap across the top of the "V")
  @IBInspectable open var arrowWidth: CGFloat = 8.0 { didSet { createPath() } }

  /// Color of the lines
  @IBInspectable open var lineColor: UIColor = .systemOrange { didSet { pathLayer.strokeColor = lineColor.cgColor } }

  /// Length of the arrow head
  @IBInspectable open var arrowLength: CGFloat = 10.0 { didSet { createPath() } }

  /// Amount of bending given to a curve. This is multiplied with the dimension of the of the view and added to the
  /// dimension mid-point to obtain an X or Y coordinate for a control point.
  @IBInspectable open var bendFactor: CGFloat = 0.20 { didSet { createPath() } }

  /// Amount of waviness in horizontal/vertical lines. This is multiplied with the dimension of the of the view and
  /// added to the dimension mid-point to obtain an X or Y coordinate for a control point.
  @IBInspectable open var wavyFactor: CGFloat = 0.10 { didSet { createPath() } }

  private let pathLayer = CAShapeLayer()

  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  override open func layoutSubviews() {
    super.layoutSubviews()
    let layerBounds = bounds.offsetBy(dx: -bounds.midX, dy: -bounds.midY)
    let layerCenter = CGPoint(x: bounds.midX, y: bounds.midY)
    pathLayer.bounds = layerBounds
    pathLayer.position = layerCenter
    createPath()
  }
}

extension ArrowView {

  private func initialize() {
    layer.addSublayer(pathLayer)
    pathLayer.fillColor = UIColor.clear.cgColor
    pathLayer.strokeColor = lineColor.cgColor
    pathLayer.lineWidth = lineWidth
    createPath()
  }

  private func createPath() {
    let controls = controlOffsets()
    let path = UIBezierPath()
    path.move(to: positionPoint(entry))
    path.addCurve(to: linePathEnd(), controlPoint1: controls.0, controlPoint2: controls.1)
    addArrow(path)
    pathLayer.path = path.cgPath
  }

  private func positionPoint(_ position: Position) -> CGPoint {
    let bounds = pathLayer.bounds
    switch position {
    case .left:   return .init(x: bounds.minX, y: bounds.midY)
    case .top:    return .init(x: bounds.midX, y: bounds.minY)
    case .right:  return .init(x: bounds.maxX, y: bounds.midY)
    case .bottom: return .init(x: bounds.midX, y: bounds.maxY)
    }
  }

  private func linePathEnd() -> CGPoint {
    let bounds = pathLayer.bounds
    switch exit {
    case .left:   return .init(x: bounds.minX + arrowWidth, y: bounds.midY              )
    case .top:    return .init(x: bounds.midX             , y: bounds.minY + arrowLength)
    case .right:  return .init(x: bounds.maxX - arrowWidth, y: bounds.midY              )
    case .bottom: return .init(x: bounds.midX,              y: bounds.maxY - arrowLength)
    }
  }

  private func controlOffsets() -> (CGPoint, CGPoint) {
    let bounds = pathLayer.bounds
    switch (entry, exit) {
    case (.left, .left):   return controlPoints(width: 0.0, height:  bounds.height * wavyFactor)
    case (.left, .top):    return controlPoints(width: 0.0, height: -bounds.height * bendFactor)
    case (.left, .right):  return controlPoints(width: 0.0, height:  bounds.height * wavyFactor)
    case (.left, .bottom): return controlPoints(width: 0.0, height:  bounds.height * bendFactor)

    case (.top, .top):    return controlPoints(width:  bounds.width * wavyFactor, height: 0.0)
    case (.top, .right):  return controlPoints(width:  bounds.width * bendFactor, height: 0.0)
    case (.top, .bottom): return controlPoints(width:  bounds.width * wavyFactor, height: 0.0)
    case (.top, .left):   return controlPoints(width: -bounds.width * bendFactor, height: 0.0)

    case (.right, .right):  return controlPoints(width: 0.0, height:  bounds.height * wavyFactor)
    case (.right, .bottom): return controlPoints(width: 0.0, height:  bounds.height * bendFactor)
    case (.right, .left):   return controlPoints(width: 0.0, height:  bounds.height * wavyFactor)
    case (.right, .top):    return controlPoints(width: 0.0, height: -bounds.height * bendFactor)

    case (.bottom, .bottom): return controlPoints(width:  bounds.width * wavyFactor, height: 0.0)
    case (.bottom, .left):   return controlPoints(width: -bounds.width * bendFactor, height: 0.0)
    case (.bottom, .top):    return controlPoints(width:  bounds.width * wavyFactor, height: 0.0)
    case (.bottom, .right):  return controlPoints(width:  bounds.width * bendFactor, height: 0.0)
    }
  }

  private func controlPoints(width: CGFloat, height: CGFloat) -> (CGPoint, CGPoint) {
    let bounds = pathLayer.bounds
    return (
      .init(x: bounds.midX - width / 2, y: bounds.midY - height / 2),
      .init(x: bounds.midX + width / 2, y: bounds.midY + height / 2)
    )
  }

  private func addArrow(_ path: UIBezierPath) {
    let point = positionPoint(exit)
    path.addLine(to: point)
    let arrowWidth2 = arrowWidth / 2.0
    switch exit {
    case .left:
      path.addArrow(point, v0: .init(dx:  arrowLength, dy: -arrowWidth2), v1: .init(dx:  arrowLength, dy:  arrowWidth2))
    case .right:
      path.addArrow(point, v0: .init(dx: -arrowLength, dy: -arrowWidth2), v1: .init(dx: -arrowLength, dy:  arrowWidth2))
    case .bottom:
      path.addArrow(point, v0: .init(dx: -arrowWidth2, dy: -arrowLength), v1: .init(dx:  arrowWidth2, dy: -arrowLength))
    case .top:
      path.addArrow(point, v0: .init(dx: -arrowWidth2, dy:  arrowLength), v1: .init(dx:  arrowWidth2, dy:  arrowLength))
    }
  }
}

extension UIBezierPath {
  func addArrow(_ point: CGPoint, v0: CGVector, v1: CGVector) {
    addLine(to: point + v0)
    move(to: point)
    addLine(to: point + v1)
  }
}

extension CGPoint {
  @inlinable
  static func + (lhs: CGPoint, rhs: CGVector) -> CGPoint { .init(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy) }
}
