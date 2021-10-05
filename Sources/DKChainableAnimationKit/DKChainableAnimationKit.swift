//
//  DKChainableAnimationKit.swift
//  DKChainableAnimationKit
//
//  Created by Draveness on 15/5/13.
//  Copyright (c) 2015年 Draveness. All rights reserved.
//

import UIKit

open class DKChainableAnimationKit {
    weak var view: UIView!

    typealias AnimationCalculationAction = (UIView) -> Void
    typealias AnimationCompletionAction = (UIView) -> Void

    internal var animationCalculationActions: [[AnimationCalculationAction]]!
    internal var animationCompletionActions: [[AnimationCompletionAction]]!
    internal var animationGroups: NSMutableArray!
    internal var animations: [[DKKeyFrameAnimation]]!
    open var animationCompletion: (() -> Void)?

    // MARK: - Initialize

    init() {
        setup()
    }

    fileprivate func setup() {
        animations = [[]]
        animationGroups = [basicAnimationGroup()]
        animationCompletionActions = [[]]
        animationCalculationActions = [[]]
    }

    fileprivate func clear() {
        animations.removeAll()
        animationGroups.removeAllObjects()
        animationCompletionActions.removeAll()
        animationCalculationActions.removeAll()
        animations.append([])
        animationCompletionActions.append([AnimationCalculationAction]())
        animationCalculationActions.append([AnimationCompletionAction]())
        animationGroups.add(basicAnimationGroup())
    }

    // MARK: - Animation Time

    open func delay(_ delay: TimeInterval) -> DKChainableAnimationKit {
        var delay = delay
        for group in animationGroups {
            let duration = (group as AnyObject).duration as TimeInterval
            delay += duration
        }
        if let group = animationGroups.lastObject as? CAAnimationGroup {
            group.beginTime = CACurrentMediaTime() + delay
        }
        return self
    }

    open func delay(_ time: CGFloat) -> DKChainableAnimationKit {
        return delay(TimeInterval(time))
    }

    open var seconds: DKChainableAnimationKit {
        return self
    }

    open func wait(_ delay: TimeInterval) -> DKChainableAnimationKit {
        return self.delay(delay)
    }

    @discardableResult open func animate(_ duration: TimeInterval) -> DKChainableAnimationKit {
        if let group = animationGroups.lastObject as? CAAnimationGroup {
            group.duration = duration
            animateChain()
        }
        return self
    }

    @discardableResult open func animate(_ duration: CGFloat) -> DKChainableAnimationKit {
        return animate(TimeInterval(duration))
    }

//    public func animateWithRepeat(duration: NSTimeInterval) -> DKChainableAnimationKit {
//        if let group = self.animationGroups.lastObject as? CAAnimationGroup {
//            group.duration = duration
//            saveAnimations()
//            animationCompletion = {
//                self.restoreAnimations()
//                self.animateChain()
//            }
//            self.animateChain()
//        }
//        return self
//    }
//
//    internal var tempAnimationCalculationActions: [[AnimationCalculationAction]]!
//    internal var tempAnimationCompletionActions: [[AnimationCompletionAction]]!
//    internal var tempAnimationGroups: NSMutableArray!
//    internal var tempAnimations: [[DKKeyFrameAnimation]]!
//
//    internal func saveAnimations() {
//        self.tempAnimationCalculationActions = self.animationCalculationActions
//        self.tempAnimationCompletionActions = self.animationCompletionActions
//        self.tempAnimationGroups = self.animationGroups.mutableCopy() as! NSMutableArray
//        self.tempAnimations = self.animations
//    }
//
//    internal func restoreAnimations() {
//        self.animationCalculationActions = self.tempAnimationCalculationActions
//        self.animationCompletionActions = self.tempAnimationCompletionActions
//        self.animationGroups = self.tempAnimationGroups.mutableCopy() as! NSMutableArray
//        self.animations = self.tempAnimations
//    }

    open func thenAfter(_ after: TimeInterval) -> DKChainableAnimationKit {
        if let group = animationGroups.lastObject as? CAAnimationGroup {
            group.duration = after
            let newGroup = basicAnimationGroup()
            animationGroups.add(newGroup)
            animations.append([])
            animationCalculationActions.append([])
            animationCompletionActions.append([])
        }
        return self
    }

    open func thenAfter(_ after: CGFloat) -> DKChainableAnimationKit {
        return thenAfter(TimeInterval(after))
    }

    @discardableResult open func animateWithCompletion(_ duration: TimeInterval, _ completion: @escaping () -> Void) -> DKChainableAnimationKit {
        if let group = animationGroups.lastObject as? CAAnimationGroup {
            group.duration = duration
            animationCompletion = completion
            animateChain()
        }
        return self
    }

    @discardableResult open func animateWithCompletion(_ duration: CGFloat, _ completion: @escaping () -> Void) -> DKChainableAnimationKit {
        return animateWithCompletion(TimeInterval(duration), completion)
    }

    internal func degreesToRadians(_ degree: Double) -> Double {
        return (degree / 180.0) * Double.pi
    }

    fileprivate func animateChain() {
        sanityCheck()
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            self.view?.layer.removeAnimation(forKey: "AnimationChain")
            self.chainLinkDidFinishAnimating()
        }
        animateChainLink()
        CATransaction.commit()

        executeCompletionActions()
    }

    fileprivate func animateChainLink() {
        makeAnchor(0.5, 0.5)
        if let animationCluster = animationCalculationActions.first, let _ = view {
            for action in animationCluster {
                action(view)
            }
        }
        if let group: CAAnimationGroup = animationGroups.firstObject as? CAAnimationGroup,
           let animationCluster: [DKKeyFrameAnimation] = animations.first
        {
            for animation in animationCluster {
                animation.duration = group.duration
                animation.calculte()
            }
            group.animations = animationCluster
            view?.layer.add(group, forKey: "AnimationChain")
        }
    }

    fileprivate func executeCompletionActions() {
        if let group = animationGroups.firstObject as? CAAnimationGroup {
            let delay = max(group.beginTime - CACurrentMediaTime(), 0.0)
            let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                if let
                    actionCluster: [AnimationCompletionAction] = self.animationCompletionActions.first,
                    let view = self.view
                {
                    for action in actionCluster {
                        action(view)
                    }
                }
            }
        }
    }

    fileprivate func chainLinkDidFinishAnimating() {
        animationCompletionActions.remove(at: 0)
        animationCalculationActions.remove(at: 0)
        animations.remove(at: 0)
        animationGroups.removeObject(at: 0)

        if animationGroups.count == 0 {
            clear()
            if let completion = animationCompletion {
                animationCompletion = nil
                completion()
            }
        } else {
            animateChain()
        }
    }

    fileprivate func sanityCheck() {
        assert(animations.count == animationGroups.count, "FATAL ERROR: ANIMATION GROUPS AND ANIMATIONS ARE OUT OF SYNC")
        assert(animationCalculationActions.count == animationCompletionActions.count, "FATAL ERROR: ANIMATION CALCULATION OBJECTS AND ANIMATION COMPLETION OBJECTS ARE OUT OF SYNC")
        assert(animations.count == animationCompletionActions.count, "FATAL ERROR: ANIMATIONS AND ANIMATION COMPLETION OBJECTS ARE OUT OF SYNC")
    }

    // MARK: - Animation Action

    internal func addAnimationKeyframeCalculation(_ functionBlock: @escaping DKKeyframeAnimationFunctionBlock) {
        addAnimationCalculationAction { (_: UIView) -> Void in
            let animationCluster = self.animations.first
            if let animation = animationCluster?.last {
                animation.functionBlock = functionBlock
            }
        }
    }

    internal func addAnimationCalculationAction(_ action: @escaping AnimationCalculationAction) {
        if var actions = animationCalculationActions.last as [AnimationCalculationAction]? {
            actions.append(action)
            animationCalculationActions.removeLast()
            animationCalculationActions.append(actions)
        }
    }

    internal func addAnimationCompletionAction(_ action: @escaping AnimationCompletionAction) {
        if var actions = animationCompletionActions.last as [AnimationCompletionAction]? {
            actions.append(action)
            animationCompletionActions.removeLast()
            animationCompletionActions.append(actions)
        }
    }

    internal func addAnimationFromCalculationBlock(_ animation: DKKeyFrameAnimation) {
        if var animationCluster = animations.first {
            animationCluster.append(animation)
            animations.remove(at: 0)
            animations.insert(animationCluster, at: 0)
        }
    }

    // MARK: - Basic Animation Helper

    internal func basicAnimationGroup() -> CAAnimationGroup {
        return CAAnimationGroup()
    }

    internal func basicAnimationForKeyPath(_ keyPath: String) -> DKKeyFrameAnimation {
        let animation = DKKeyFrameAnimation(keyPath: keyPath)
        animation.repeatCount = 0
        animation.autoreverses = false
        return animation
    }

    internal func newPositionFrom(newOrigin: CGPoint) -> CGPoint {
        let anchor = view.layer.anchorPoint
        let size = view.bounds.size
        let newPosition = CGPoint(x: newOrigin.x + anchor.x * size.width, y: newOrigin.y + anchor.y * size.height)
        return newPosition
    }

    internal func newPositionFrom(newCenter: CGPoint) -> CGPoint {
        let anchor = view.layer.anchorPoint
        let size = view.bounds.size
        let newPosition = CGPoint(x: newCenter.x + (anchor.x - 0.5) * size.width, y: newCenter.y + (anchor.y - 0.5) * size.height)
        return newPosition
    }
}
