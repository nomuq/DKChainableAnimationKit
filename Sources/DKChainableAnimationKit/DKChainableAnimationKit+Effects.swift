//
//  DKChainableAnimationKit+Effects.swift
//  DKChainableAnimationKit
//
//  Created by Draveness on 15/6/12.
//  Copyright (c) 2015年 Draveness. All rights reserved.
//

import UIKit

public extension DKChainableAnimationKit {
    // MARK: - Animation Effects

    var easeIn: DKChainableAnimationKit {
        _ = easeInQuad
        return self
    }

    var easeOut: DKChainableAnimationKit {
        _ = easeOutQuad
        return self
    }

    var easeInOut: DKChainableAnimationKit {
        _ = easeInOutQuad
        return self
    }

    var easeBack: DKChainableAnimationKit {
        _ = easeOutBack
        return self
    }

    var spring: DKChainableAnimationKit {
        _ = easeOutElastic
        return self
    }

    var bounce: DKChainableAnimationKit {
        _ = easeOutBounce
        return self
    }

    var easeInQuad: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInQuad)
        return self
    }

    var easeOutQuad: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutQuad)
        return self
    }

    var easeInOutQuad: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutQuad)
        return self
    }

    var easeInCubic: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInCubic)
        return self
    }

    var easeOutCubic: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutCubic)
        return self
    }

    var easeInOutCubic: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutCubic)
        return self
    }

    var easeInQuart: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInQuart)
        return self
    }

    var easeOutQuart: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutQuart)
        return self
    }

    var easeInOutQuart: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutQuart)
        return self
    }

    var easeInQuint: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInQuint)
        return self
    }

    var easeOutQuint: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutQuint)
        return self
    }

    var easeInOutQuint: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutQuint)
        return self
    }

    var easeInSine: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInSine)
        return self
    }

    var easeOutSine: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutSine)
        return self
    }

    var easeInOutSine: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutSine)
        return self
    }

    var easeInExpo: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInExpo)
        return self
    }

    var easeOutExpo: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutExpo)
        return self
    }

    var easeInOutExpo: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutExpo)
        return self
    }

    var easeInCirc: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInCirc)
        return self
    }

    var easeOutCirc: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutCirc)
        return self
    }

    var easeInOutCirc: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutCirc)
        return self
    }

    var easeInElastic: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInElastic)
        return self
    }

    var easeOutElastic: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutElastic)
        return self
    }

    var easeInOutElastic: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutElastic)
        return self
    }

    var easeInBack: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInBack)
        return self
    }

    var easeOutBack: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutBack)
        return self
    }

    var easeInOutBack: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutBack)
        return self
    }

    var easeInBounce: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInBounce)
        return self
    }

    var easeOutBounce: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseOutBounce)
        return self
    }

    var easeInOutBounce: DKChainableAnimationKit {
        addAnimationKeyframeCalculation(DKKeyframeAnimationFunctionEaseInOutBounce)
        return self
    }
}
