//
//  ViewController.swift
//  DraggableFloatingActionView
//
//  Created by Shagara F Nasution on 02/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let draggableActionViewSize: CGFloat = 100
    private let barBottomHeight: CGFloat = 80
    
    private lazy var draggableActionView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(draggableActionView)
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
    }
    
    private func layoutViews() {
        draggableActionView.frame = CGRect(
            x: view.frame.width - draggableActionViewSize,
            y: view.frame.height - draggableActionViewSize - 200,
            width: draggableActionViewSize,
            height: draggableActionViewSize
        )
    }
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        draggableActionView.addGestureRecognizer(panGesture)
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIGestureRecognizer) {
        let location = gesture.location(in: view)
        let gesturedView = gesture.view
        if location.y >= self.view.safeAreaInsets.top
            && location.y <= self.view.frame.height - self.view.safeAreaInsets.bottom - barBottomHeight {
            gesturedView?.center = location
        }
        
        if gesture.state == .ended {
            if self.draggableActionView.frame.midX >= self.view.frame.width / 2 {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self = self else { return }
                    self.draggableActionView.center.x = self.view.frame.width - (self.draggableActionViewSize/2)
                }
            } else {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self = self else { return }
                    self.draggableActionView.center.x = self.draggableActionViewSize/2
                }
            }
        }
    }
    
}

