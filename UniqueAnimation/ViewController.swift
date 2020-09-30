//
//  ViewController.swift
//  UniqueAnimation
//
//  Created by Jawad Ali on 12/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var circularView: CircularView = {
  
        let circle = CircularView( centerNode: Node(text: "Play with your ideas",topImage: UIImage(named: "rugby"), color: #colorLiteral(red: 0.2376119494, green: 0.7448641658, blue: 0.6475631595, alpha: 1)),otherNodes: [
        
            Node(text: "Be\ncreative!", color: #colorLiteral(red: 0.8759053349, green: 0.4555660486, blue: 0.219188869, alpha: 1)),
            Node(text: "Add icons and\nnotes",topImage: UIImage(named: "thumbsUp"), color: #colorLiteral(red: 0.2449892163, green: 0.7365675569, blue: 0.6569592357, alpha: 1)),
            Node(text: "Images can be handy too", color: #colorLiteral(red: 0.4036758244, green: 0.8463619351, blue: 0.7754261494, alpha: 1)),
            Node(text: "Organize them ", color: #colorLiteral(red: 0.2343024611, green: 0.557636559, blue: 0.4527699947, alpha: 1)),
        ])
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    
    private lazy var peakingView : PeakView = {
        let peek = PeakView()
        peek.translatesAutoresizingMaskIntoConstraints = false
        return peek
    }()
    
    
    private lazy var connectingLayer : CAShapeLayer = {
        let shapelayer  = CAShapeLayer()
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.strokeColor = #colorLiteral(red: 0.8722453713, green: 0.8623889685, blue: 0.866799891, alpha: 1)
        shapelayer.lineWidth = 2
        return shapelayer
    }()
    
    override func viewDidLoad() {
        
        view.layer.addSublayer(connectingLayer)
        
        view.addSubview(circularView)
        view.addSubview(peakingView)
        
        circularView
            .centerInSuperView()
            .width(with: .width, ofView: view, multiplier:0.9 )
            .height(with: .width, ofView: view, multiplier:0.9)
        
        peakingView
            .alignEdgeWithSuperviewSafeArea(.left)
            .alignEdgeWithSuperviewSafeArea(.top)
            .width(with: .width, ofView: view, multiplier:0.3 )
            .height(with: .width, ofView: view, multiplier:0.3)
        
        
        
        peakingView.clipsToBounds = true
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {

            let circle = CircularView( centerNode: Node(text: "Welcome!", color: #colorLiteral(red: 0.2295689881, green: 0.5538217425, blue: 0.440055728, alpha: 1)),
                                       otherNodes: [
                Node(text: "Be\ncreative!", color: #colorLiteral(red: 0.8759053349, green: 0.4555660486, blue: 0.219188869, alpha: 1)),
                Node(text: "Play with your ideas",topImage: UIImage(named: "rugby"), color: #colorLiteral(red: 0.2376119494, green: 0.7448641658, blue: 0.6475631595, alpha: 1)),
                Node(text: "Images can be handy too", color: #colorLiteral(red: 0.4036758244, green: 0.8463619351, blue: 0.7754261494, alpha: 1)),
                Node(text: "Organize them ", color: #colorLiteral(red: 0.2343024611, green: 0.557636559, blue: 0.4527699947, alpha: 1)),
            ])


            self.peakingView.isHidden = true

            circle.frame = CGRect(origin:.zero, size: CGSize(width: self.view.bounds.maxX * 3, height:  self.view.bounds.maxX * 3))
            circle.clipsToBounds = true
          //  circle.center =  CGPoint(x: -self.peakingView.bounds.midX, y: -self.peakingView.bounds.midX)
            circle.center =  CGPoint(x: 0, y: 0)
             // circle.transform = CGAffineTransform(rotationAngle: -5.degreesToRadians)
            self.view.addSubview(circle)
//            UIView.animate(withDuration: 10, delay: 0.1, options: .curveLinear, animations: {
//
//            }, completion: nil)

            self.connectingLayer.isHidden = true

          //  circle.animateLayer(from: circle.frame, to: self.circularView.frame)
            //circle.layoutIfNeeded()

//            UIView.animate(withDuration: 20, animations: {
//
////                let transform = CGAffineTransform.identity
////
////             //   transform.rotated(by: -20.degreesToRadians)
////                transform.scaledBy(x: 0.33, y: 0.33)
////
////                circle.transform = CGAffineTransform(scaleX: 0.33, y: 0.33)
//                //  circle.animateLayer(from: <#T##CGRect#>, to: <#T##CGRect#>)
//
//              //  circle.transform = CGAffineTransform(rotationAngle: -15.degreesToRadians)
//
////                circle.frame = self.circularView.frame
//
//
//
//              //  self.view.layoutIfNeeded()
//
//
//
//
//
//             //   circle.frame = CGRect(origin: circle.frame.origin, size: CGSize(width: self.view.bounds.width * 0.9, height: self.view.bounds.width * 0.9))
//              //  circle.center = self.view.center
//
//
//                self.circularView.alpha = 0
//            }) { _ in
//              //  self.circularView.removeFromSuperview()
//            }


        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: peakingView.center)
        bezierPath.addLine(to: circularView.center)
        
        connectingLayer.path = bezierPath.cgPath
        
    }

}

