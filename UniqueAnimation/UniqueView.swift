//
//  UniqueView.swift
//  testi
//
//  Created by Jawad Ali on 12/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import UIKit

public struct Node {
    let text: String
    let topImage: UIImage?
    let bottomImage: UIImage?
    let color: UIColor
    
    
    init(text:String, topImage:UIImage? = nil, bottomImage: UIImage? = nil, color:UIColor) {
        self.text = text
        self.topImage = topImage
        self.bottomImage = bottomImage
        self.color = color
    }
}

@IBDesignable public class PlusCircle: UIView {
    
    //MARK:- Properties
   
    public var circleColor: UIColor = #colorLiteral(red: 0.6879951358, green: 0.6779844165, blue: 0.6868155003, alpha: 1)
    public var plusColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    //MARK:- Views
    private lazy var circularShape : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.fillColor = circleColor.cgColor
        return shape
    }()
    
    private lazy var plusShape : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = plusColor.cgColor
        shape.lineWidth = 2
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }()
    
    
    //MARK:- Initializers
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           controlDidLoad()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           controlDidLoad()
       }
       
       
       private func controlDidLoad() {
           layer.addSublayer(circularShape)
            layer.addSublayer(plusShape)
           
       }
    
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = min(bounds.midX,bounds.midY)
        
        circularShape.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius:radius , startAngle: 0, endAngle: 2 * .pi, clockwise: true).cgPath
        
        plusShape.path = drawPlus(with: bounds.insetBy(dx: bounds.maxX * 0.2, dy: bounds.maxX * 0.2))
    }
    
    
    private func drawPlus(with irect:CGRect)-> CGPath {
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: irect.midX, y: irect.origin.y))
        bezierPath.addLine(to: CGPoint(x: irect.midX, y: irect.maxY))
        bezierPath.move(to: CGPoint(x: irect.origin.x, y: irect.midY))
        bezierPath.addLine(to: CGPoint(x: irect.maxX, y: irect.midY))
        
        return bezierPath.cgPath
        
    }
    
}


public class CircularView: UIView {
    
    private var circularNodesView : CircularNodesView!
    private var centerNodeView:NodeView!
    //MARK:- Initializers

      
    init(centerNode:Node,  otherNodes:[Node] ) {
        super.init(frame: .zero)
        
        circularNodesView = CircularNodesView(nodes: otherNodes, animated: false)
        circularNodesView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circularNodesView)
        
        
         centerNodeView = NodeView(node: centerNode)
        addSubview(centerNodeView)
    }
    
    
   required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        
        circularNodesView
        .alignAllEdgesWithSuperview()
        
        centerNodeView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.maxX * 0.25 , height: bounds.maxX * 0.25  ))
        
        print(circularNodesView.center)
        
        centerNodeView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        
        
    }
    
}

public class CircleView: UIView {
     public var circleColor: UIColor = #colorLiteral(red: 0.8488207459, green: 0.8386972547, blue: 0.8518897891, alpha: 1)
    private lazy var circularShape : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = circleColor.cgColor
        shape.fillColor = UIColor.clear.cgColor
       // shape.isAnimated = animateable
        return shape
    }()
    public var width:CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func controlDidLoad() {
           layer.addSublayer(circularShape)
         circularShape.lineWidth = width
        
        DispatchQueue.main.async {
            let radius = min(self.bounds.midX,self.bounds.midY) - self.width/2 - self.bounds.maxX * 0.1
            let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            self.circularShape.path = UIBezierPath(arcCenter: center, radius:radius , startAngle: 0, endAngle: 2 * .pi, clockwise: true).cgPath
        }
        
    }
    
//    public override func layoutSubviews() {
//    super.layoutSubviews()
//
//
//    }
    
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
      
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        
        print(bounds)
    }
    
}

@IBDesignable public class CircularNodesView: UIView {
    
      //MARK:- Properties
   
    private var numberOfPlusSign = 4
    public var otherNodes:[Node]
    public var animateable:Bool = false {
        didSet {
          //  circularShape.isAnimated = animateable
        }
    }
   // private var centerNodeView:NodeView!
        private lazy var otherNodesViews = [NodeView]()
    
    private lazy var circle = CircleView()
    
    
    
    //MARK:- Views
    private lazy var plusView = [PlusCircle]()
  
    
       
    
    //MARK:- Initializers

    init(nodes:[Node], animated:Bool = true ) {
        
       
        self.otherNodes = nodes
        super.init(frame:.zero)
        
        animateable = animated
        
     // centerNodeView = NodeView(node: centerNode)
     //   addSubview(centerNodeView)

        
        addSubview(circle)
        
        
        
        addNodesToView()
        
        

    }
    
    private func addNodesToView() {
        controlDidLoad()
        
        otherNodes.forEach { (node) in
                 let nodeView =  NodeView(node: node)
                  otherNodesViews.append(nodeView)
                  
                  addSubview(nodeView)
              }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func controlDidLoad() {

        for _ in 0..<numberOfPlusSign {
            let plus = PlusCircle(frame:CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
            plusView.append(plus)
            addSubview(plus)
        }
        
        
    }
    
    public func animateLayer(from : CGSize , to: CGSize){
       
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.duration = 10
    
        animation.fromValue = from
        animation.toValue = to
        layer.add(animation, forKey: nil)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
       
        circle.frame = bounds
        let radius = min(bounds.midX,bounds.midY) - bounds.maxX * 0.1
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
      
        
        var initialAngel = -60
        
        let gap = 360/numberOfPlusSign
        
        plusView.forEach { (shape) in
            let  x = center.x  + (radius ) *  cos(initialAngel.degreesToRadians)
            let  y = center.y  + (radius  ) *  sin(initialAngel.degreesToRadians)
            
            initialAngel += gap
            
            shape.center = CGPoint(x: x, y: y)
        }
        
        layoutNodes()
 
    }
    
    
    
}

private extension CircularNodesView {
    func layoutNodes() {
        
        var initialAngel = -20
        let gap = 360/otherNodes.count
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let size = 80
         let radius = min(bounds.midX,bounds.midY) - bounds.maxX * 0.1
        
        
//        centerNodeView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.maxX * 0.25 , height: bounds.maxX * 0.25  ))
//        centerNodeView.center = center
        
        
        otherNodesViews.forEach { (node) in
            
                let  x = center.x  + (radius ) *  cos(initialAngel.degreesToRadians)
                let  y = center.y  + (radius  ) *  sin(initialAngel.degreesToRadians)
            
           
            node.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
            node.center = CGPoint(x: x, y: y)
            node.layer.cornerRadius = node.frame.midY
            initialAngel += gap
            
            
        }
    }
}

@IBDesignable public class NodeView: UIView {
    
    //MARK:- Views
    private lazy var stackView = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillProportionally,spacing: 5)
    
    private lazy var topImageView = UIImageViewFactory.createImageView(mode: .scaleAspectFit)
    
    private lazy var bottomImageView = UIImageViewFactory.createImageView(mode: .scaleAspectFit)
    
    private lazy var labelView = UILabelFactory.createUILabel(with: .white, font: .systemFont(ofSize: 12), alignment: .center, numberOfLines: 0, lineBreakMode: .byWordWrapping)
    //MARK:- Initializers
    
    
    private let node: Node

 
    
    init(node:Node) {
        
        self.node = node
        
        super.init(frame:.zero)
        controlDidLoad()
        
        if let top = node.topImage {
            topImageView.image = top
            stackView.addArrangedSubview(topImageView)
            
            topImageView
                .height(.lessThanOrEqualTo, constant: 30)
        }
        
        labelView.text = node.text
        
        stackView.addArrangedSubview(labelView)
        
        if let bottom = node.bottomImage {
                  bottomImageView.image = bottom
                  stackView.addArrangedSubview(bottomImageView)
                  
                  bottomImageView
                    .height(.lessThanOrEqualTo, constant: 30)
              }
        
        labelView.minimumScaleFactor = 0.5
        
        backgroundColor = node.color
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func controlDidLoad() {
     //    translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
//
//             stackView
//                .alignAllEdgesWithSuperview()
        
       stackView
        .alignEdgesWithSuperview([.left, .right, .top, .bottom], constant:10)
        
        
      
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.midY
//        stackView
//                   .alignAllEdgesWithSuperview()
    }
}


@IBDesignable public class PeakView: UIView {
    

    //MARK:- Properties
      
       public var circleColor: UIColor = #colorLiteral(red: 0.2295689881, green: 0.5538217425, blue: 0.440055728, alpha: 1)
      
       
       //MARK:- Views
       private lazy var circularShape : CAShapeLayer = {
           let shape = CAShapeLayer()
           shape.fillColor = circleColor.cgColor
           return shape
       }()
    
    private lazy var labelView = UILabelFactory.createUILabel(with: .white, font: .systemFont(ofSize: 12), alignment: .center, numberOfLines: 0, lineBreakMode: .byWordWrapping,text: "Welcome")

       //MARK:- Initializers
          
          override init(frame: CGRect) {
              super.init(frame: frame)
              controlDidLoad()
          }
          
          required init?(coder aDecoder: NSCoder) {
              super.init(coder: aDecoder)
              controlDidLoad()
          }
          
          
          private func controlDidLoad() {
              layer.addSublayer(circularShape)
              addSubview(labelView)
            
            labelView
                .alignEdgesWithSuperview([.left, .top], constant: 10)
            
          }
       
       
       
       public override func layoutSubviews() {
           super.layoutSubviews()
           
         //  let radius = min(bounds.midX,bounds.midY)
           
        let path = UIBezierPath(arcCenter: CGPoint(x: -bounds.midX, y: -bounds.midX), radius: bounds.maxX + bounds.midX  , startAngle: 0, endAngle: 90.degreesToRadians, clockwise: true)
        
        path.addLine(to: CGPoint(x: -bounds.midX, y: -bounds.midX))
        
        path.close()
        
        circularShape.path = path.cgPath
           
          
       }
       
       
//       private func drawPlus(with irect:CGRect)-> CGPath {
//
//        let bezierPath =
//
//
//       }
}

//let kAnimationDuration: TimeInterval = 20.0
//
//class AnimatablePathShape: CAShapeLayer {
////public var isAnimated = true
//    override func action(forKey event: String) -> CAAction? {
//
//        if event == "path"  {
//            let value = self.presentation()?.value(forKey: event) ?? self.value(forKey: event)
//
//            let anim = CABasicAnimation(keyPath: event)
//            anim.duration = kAnimationDuration
//            anim.fromValue = value
//            anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//
//            return anim
//        }
//
//        return super.action(forKey: event)
//    }
//
//    override class func needsDisplay(forKey key: String) -> Bool {
//        if key == "path" {
//            return true
//        }
//        return super.needsDisplay(forKey: key)
//    }
//}
