//
//  FlipDismissanimationController.swift
//  CustomTransition
//
//  Created by Damir L on 13.06.2021.
//

import UIKit

class FlipDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let endFrame: CGRect
    let interactionController: SwipeInteractionController?
    
    init(destinationFrame: CGRect, interactionController: SwipeInteractionController?) {
        self.endFrame = destinationFrame
        self.interactionController = interactionController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let fromVCSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true),
              let toVCSnapshot = toVC.view.snapshotView(afterScreenUpdates: true) else {return}
        
        let containerView = transitionContext.containerView
        
        fromVCSnapshot.layer.masksToBounds = true
        
        containerView.insertSubview(toVCSnapshot, at: 0)
        containerView.addSubview(fromVCSnapshot)
        
        fromVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransform(for: containerView)
        toVCSnapshot.layer.transform = AnimationHelper.yRotation(-.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    fromVCSnapshot.frame = self.endFrame
                    fromVCSnapshot.layer.cornerRadius = CardViewController.cardCornerRadius
                }
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                    fromVCSnapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
                }
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                    toVCSnapshot.layer.transform = AnimationHelper.yRotation(0.0)
                }
            },
            completion: { _ in
                if transitionContext.transitionWasCancelled {
                    fromVCSnapshot.removeFromSuperview()
                    toVCSnapshot.removeFromSuperview()
                    fromVC.view.isHidden = false
                } else {
                    toVC.view.isHidden = false
                    toVCSnapshot.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }
}
