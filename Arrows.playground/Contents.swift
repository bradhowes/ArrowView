import UIKit
import PlaygroundSupport
import ArrowView

class MyViewController : UIViewController {

    var arrows = [ArrowView]()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        for entry in ArrowView.Position.allCases {
            for exit in ArrowView.Position.allCases {
                if entry == exit { continue }
                let arrow = ArrowView()
                arrow.entry = entry
                arrow.exit = exit
                arrows.append(arrow)
                view.addSubview(arrow)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width: CGFloat = 140.0
        let height: CGFloat = 80.0
        let spacing: CGFloat = 10.0
        for (index, arrow) in arrows.enumerated() {
            let x = CGFloat(spacing) + (index % 2 == 1 ? 1.0 : 0.0) * (width + spacing)
            let y = CGFloat(spacing + (spacing + height) * CGFloat(index / 2))
            arrow.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
}

PlaygroundPage.current.liveView = MyViewController()
