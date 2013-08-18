//
//  TOValueTransition.h
//
//  Created by Marco Köppel on 25.04.13.
//  Copyright (c) 2013 Marco Köppel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOEasing.h"

#define kTOValueTransitionBeat 1.0 / 60.0

typedef void(^TOValueTransitionProgress)(CGFloat currentValue);
typedef void(^TOValueTransitionCompleted)(CGFloat endValue);
typedef void(^TOValueTransitionCancelled)(CGFloat cancelledValue);

/**
 A class to "animate" the interpolation of CGFloat Values. One instance is for single use only. You cannot reuse the same instance. Just create a new one.
 */
@interface TOValueTransition : NSObject

@property (nonatomic, assign) CGFloat currentValue;

/**
 Creates a new instance of TOValueTransition and starts the Transition.
 @param baseValue Value to start from.
 @param targetValue Endvalue.
 @param duration Duration of the transition.
 @param easingId Identifier for the easing. Use one of the Identifier declared in TOEasing.h.
 @param progressHandler Block for progressUpdates.
 @param completedHandler Block for completed.
 @param cancelledHandler Block for cancelled.
 @see TOEasing.h
 @return The transitioning instance.
 */
+ (TOValueTransition *)interpolateFrom:(CGFloat)baseValue to:(CGFloat)targetValue duration:(NSTimeInterval)duration easing:(NSString *)easingId progress:(TOValueTransitionProgress)progressHandler completed:(TOValueTransitionCompleted)completedHandler cancelled:(TOValueTransitionCancelled)cancelledHandler;

/**
 Cancels the currently running interpolation.
 @return Indicator if the instance really was cancelled. If this method returns NO, the transition was not running anylonger.
 */
- (BOOL)cancel;

@end
