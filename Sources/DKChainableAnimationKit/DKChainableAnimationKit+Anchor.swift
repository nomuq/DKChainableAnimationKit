//
//  DKChainableAnimationKit+Anchor.swift
//  DKChainableAnimationKit
//
//  Created by Draveness on 15/6/14.
//  Copyright (c) 2015年 Draveness. All rights reserved.
//

import UIKit

public extension DKChainableAnimationKit {
    internal func makeAnchorFrom(x: CGFloat, y: CGFloat) {
        let anchorPoint = CGPoint(x: x, y: y)
        func action(_ view: UIView) {
            if anchorPoint.equalTo(view.layer.anchorPoint) {
                return
            }
            var newPoint = CGPoint(
                x: view.bounds.size.width * anchorPoint.x,
                y: view.bounds.size.height * anchorPoint.y
            )
            var oldPoint = CGPoint(
                x: view.bounds.size.width * view.layer.anchorPoint.x,
                y: view.bounds.size.height * view.layer.anchorPoint.y
            )
            newPoint = newPoint.applying(view.transform)
            oldPoint = oldPoint.applying(view.transform)

            var position = view.layer.position

            position.x -= oldPoint.x
            position.x += newPoint.x

            position.y -= oldPoint.y
            position.y += newPoint.y

            view.layer.position = position
            view.layer.anchorPoint = anchorPoint
        }

        if var lastCalculationActions = animationCalculationActions.last {
            lastCalculationActions.insert(action, at: 0)
            animationCalculationActions.removeLast()
            animationCalculationActions.append(lastCalculationActions)
        }
    }

    @discardableResult func makeAnchor(_ x: CGFloat, _ y: CGFloat) -> DKChainableAnimationKit {
        makeAnchorFrom(x: x, y: y)
        return self
    }

    var anchorDefault: DKChainableAnimationKit {
        return anchorCenter
    }

    var anchorCenter: DKChainableAnimationKit {
        makeAnchorFrom(x: 0.5, y: 0.5)
        return self
    }

    var anchorTopLeft: DKChainableAnimationKit {
        makeAnchorFrom(x: 0.0, y: 0.0)
        return self
    }

    var anchorTopRight: DKChainableAnimationKit {
        makeAnchorFrom(x: 1.0, y: 0.0)
        return self
    }

    var anchorBottomLeft: DKChainableAnimationKit {
        makeAnchorFrom(x: 0.0, y: 1.0)
        return self
    }

    var anchorBottomRight: DKChainableAnimationKit {
        makeAnchorFrom(x: 1.0, y: 1.0)
        return self
    }

    var anchorTop: DKChainableAnimationKit {
        makeAnchorFrom(x: 0.5, y: 0.0)
        return self
    }

    var anchorBottom: DKChainableAnimationKit {
        makeAnchorFrom(x: 0.5, y: 1.0)
        return self
    }

    var anchorLeft: DKChainableAnimationKit {
        makeAnchorFrom(x: 0.0, y: 0.5)
        return self
    }

    var anchorRight: DKChainableAnimationKit {
        makeAnchorFrom(x: 1.0, y: 0.5)
        return self
    }
}
