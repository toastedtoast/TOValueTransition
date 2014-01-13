//
//  TOValueTransition.m
//
//  Created by Marco Köppel on 25.04.13.
//  Copyright (c) 2013 Marco Köppel. All rights reserved.
//

#import "TOValueTransition.h"
#import "TOMath.h"

@interface TOValueTransitionHost : NSObject

+ (void)addTransition:(TOValueTransition *)transition;
+ (void)removeTransition:(TOValueTransition *)transition;

@end

@implementation TOValueTransitionHost

static NSMutableArray *activeTransitions;

+ (void)addTransition:(TOValueTransition *)transition{
    
    if (activeTransitions == nil){
        activeTransitions = [[NSMutableArray alloc] init];
    }
    
    [activeTransitions addObject:transition];
    
}

+ (void)removeTransition:(TOValueTransition *)transition{
    
    if (activeTransitions == nil) return;
    if (![activeTransitions containsObject:transition]) return;
    
    [activeTransitions removeObject:transition];
}

@end

@interface TOValueTransition(){
    
}

@property (nonatomic, assign) CGFloat delay;
@property (nonatomic, assign) CFAbsoluteTime baseTimestamp;
@property (nonatomic, assign) CFAbsoluteTime beginTimestamp;
@property (nonatomic, assign) CFAbsoluteTime progressTimestamp;

@property (nonatomic, strong) NSTimer *heartbeat;
@property (nonatomic, assign) BOOL running;

@property (atomic, copy) TOValueTransitionCancelled cancelledHandler;
@property (atomic, copy) TOValueTransitionCompleted completedHandler;
@property (atomic, copy) TOValueTransitionProgress progressHandler;

+ (CGFloat)easing:(CGFloat)value identifier:(NSString *)easingIdentifier;

- (void)doProgress:(CGFloat)value;
- (void)doCompleted:(CGFloat)value;
- (void)doCancelled:(CGFloat)value;

- (void)handleBeat:(NSTimer *)timer;
- (BOOL)cancelBeats;

@end

@implementation TOValueTransition

+ (TOValueTransition *)interpolateFrom:(CGFloat)baseValue to:(CGFloat)targetValue duration:(NSTimeInterval)duration easing:(NSString *)easingId progress:(TOValueTransitionProgress)progressHandler completed:(TOValueTransitionCompleted)completedHandler cancelled:(TOValueTransitionCancelled)cancelledHandler{
    
    TOValueTransition *vt = [[TOValueTransition alloc] init];
    vt.baseTimestamp = CFAbsoluteTimeGetCurrent();
    
    vt.cancelledHandler = cancelledHandler;
    vt.completedHandler = completedHandler;
    vt.progressHandler = progressHandler;
    
    vt.running = YES;
    
    [TOValueTransitionHost addTransition:vt];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:duration], @"duration", [NSNumber numberWithFloat:baseValue], @"baseValue", [NSNumber numberWithFloat:targetValue], @"targetValue", easingId, @"easing", nil];
    NSTimer *t = [NSTimer timerWithTimeInterval:(NSTimeInterval)kTOValueTransitionBeat target:vt selector:@selector(handleBeat:) userInfo:userInfo repeats:YES];
    
    vt.heartbeat = t;
    [[NSRunLoop currentRunLoop] addTimer:vt.heartbeat forMode:NSRunLoopCommonModes];
    
    return vt;
}

+ (TOValueTransition *)interpolateFrom:(CGFloat)baseValue to:(CGFloat)targetValue duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay easing:(NSString *)easingId progress:(TOValueTransitionProgress)progressHandler completed:(TOValueTransitionCompleted)completedHandler cancelled:(TOValueTransitionCancelled)cancelledHandler{
    
    TOValueTransition *vt = [TOValueTransition interpolateFrom:baseValue to:targetValue duration:duration easing:easingId progress:progressHandler completed:completedHandler cancelled:cancelledHandler];
    vt.delay =  delay;
    
    return vt;
}

- (BOOL)cancel{
    
    if (!self.running) return NO;
    [self doCancelled:self.currentValue];
    
    return YES;
}

#pragma mark - Private

+ (CGFloat)easing:(CGFloat)value identifier:(NSString *)easingIdentifier{
    
    if ([easingIdentifier isEqualToString:TOEasingLinear]) return [TOEasing linear:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingBackEaseIn]) return [TOEasing backEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingBackEaseOut]) return [TOEasing backEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingBackEaseInOut]) return [TOEasing backEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingBounceEaseIn]) return [TOEasing bounceEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingBounceEaseOut]) return [TOEasing bounceEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingBounceEaseInOut]) return [TOEasing bounceEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingCircEaseIn]) return [TOEasing circEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingCircEaseOut]) return [TOEasing circEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingCircEaseInOut]) return [TOEasing circEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingCubicEaseIn]) return [TOEasing cubicEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingCubicEaseOut]) return [TOEasing cubicEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingCubicEaseInOut]) return [TOEasing cubicEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingElasticEaseIn]) return [TOEasing elasticEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingElasticEaseOut]) return [TOEasing elasticEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingElasticEaseInOut]) return [TOEasing elasticEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingExpoEaseIn]) return [TOEasing expoEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingExpoEaseOut]) return [TOEasing expoEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingExpoEaseInOut]) return [TOEasing expoEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingQuadEaseIn]) return [TOEasing quadEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingQuadEaseOut]) return [TOEasing quadEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingQuadEaseInOut]) return [TOEasing quadEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingQuartEaseIn]) return [TOEasing quartEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingQuartEaseOut]) return [TOEasing quartEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingQuartEaseInOut]) return [TOEasing quartEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingQuintEaseIn]) return [TOEasing quintEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingQuintEaseOut]) return [TOEasing quintEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingQuintEaseInOut]) return [TOEasing quintEaseInOut:value];
    
    else if ([easingIdentifier isEqualToString:TOEasingSineEaseIn]) return [TOEasing sineEaseIn:value];
    else if ([easingIdentifier isEqualToString:TOEasingSineEaseOut]) return [TOEasing sineEaseOut:value];
    else if ([easingIdentifier isEqualToString:TOEasingSineEaseInOut]) return [TOEasing sineEaseInOut:value];
    
    return value;
}

- (void)doProgress:(CGFloat)value{
    
    self.currentValue = value;
    if (self.progressHandler != nil) self.progressHandler(self.currentValue);
}

- (void)doCompleted:(CGFloat)value{
    
    self.currentValue = value;
    if (self.completedHandler != nil) self.completedHandler(value);
    
    [self cancelBeats];
    [TOValueTransitionHost removeTransition:self];
}

- (void)doCancelled:(CGFloat)value{
    
    if (self.cancelledHandler != nil) self.cancelledHandler(value);
    
    [self cancelBeats];
    [TOValueTransitionHost removeTransition:self];
}

- (void)handleBeat:(NSTimer *)timer{
    
    if (self.baseTimestamp + self.delay > CFAbsoluteTimeGetCurrent()) return;
    
    if (self.beginTimestamp == 0.0) self.beginTimestamp = CFAbsoluteTimeGetCurrent();
    if (self.progressTimestamp == 0.0) self.progressTimestamp = CFAbsoluteTimeGetCurrent();
    
    NSTimeInterval duration = [[timer.userInfo objectForKey:@"duration"] doubleValue];
    CGFloat baseValue = [[timer.userInfo objectForKey:@"baseValue"] floatValue];
    CGFloat targetValue = [[timer.userInfo objectForKey:@"targetValue"] floatValue];
    NSString *easing = [timer.userInfo objectForKey:@"easing"];
    
    CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
    NSTimeInterval diff = fabs(now - self.beginTimestamp);
    
    CGFloat ratio = (diff / duration);
    ratio = [TOMath intermediate:ratio min:0.0 max:1.0];
    ratio = [TOValueTransition easing:ratio identifier:easing];
    
    CGFloat v = baseValue + ((targetValue - baseValue) * ratio);
    
    [self doProgress:v];
    
    if (diff > duration){
        
        [self doCompleted:targetValue];
    }
    
    self.progressTimestamp = now;
    
}

- (BOOL)cancelBeats{
    
    if (!self.running) return NO;
    
    self.beginTimestamp = 0.0;
    if (self.heartbeat != nil){
        
        @try {
            
            [self.heartbeat invalidate];
            _heartbeat = nil;
        }
        @catch (NSException *exception) {
        }
    }
    
    self.running = NO;
    
    return YES;
}

@end
