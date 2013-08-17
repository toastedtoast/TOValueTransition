//
//  TOEasing.h
//
//  Created by Marco Köppel on 19.02.13.
//  Copyright (c) 2013 Marco Köppel. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TOEasingLinear @"TOEasingLinear"

#define TOEasingBackEaseIn @"TOEasingBackEaseIn"
#define TOEasingBackEaseOut @"TOEasingBackEaseOut"
#define TOEasingBackEaseInOut @"TOEasingBackEaseInOut"

#define TOEasingBounceEaseIn @"TOEasingBounceEaseIn"
#define TOEasingBounceEaseOut @"TOEasingBounceEaseOut"
#define TOEasingBounceEaseInOut @"TOEasingBounceEaseInOut"

#define TOEasingCircEaseIn @"TOEasingCircEaseIn"
#define TOEasingCircEaseOut @"TOEasingCircEaseOut"
#define TOEasingCircEaseInOut @"TOEasingCircEaseInOut"

#define TOEasingCubicEaseIn @"TOEasingCubicEaseIn"
#define TOEasingCubicEaseOut @"TOEasingCubicEaseOut"
#define TOEasingCubicEaseInOut @"TOEasingCubicEaseInOut"

#define TOEasingElasticEaseIn @"TOEasingElasticEaseIn"
#define TOEasingElasticEaseOut @"TOEasingElasticEaseOut"
#define TOEasingElasticEaseInOut @"TOEasingElasticEaseInOut"

#define TOEasingExpoEaseIn @"TOEasingExpoEaseIn"
#define TOEasingExpoEaseOut @"TOEasingExpoEaseOut"
#define TOEasingExpoEaseInOut @"TOEasingExpoEaseInOut"

#define TOEasingQuadEaseIn @"TOEasingQuadEaseIn"
#define TOEasingQuadEaseOut @"TOEasingQuadEaseOut"
#define TOEasingQuadEaseInOut @"TOEasingQuadEaseInOut"

#define TOEasingQuartEaseIn @"TOEasingQuartEaseIn"
#define TOEasingQuartEaseOut @"TOEasingQuartEaseOut"
#define TOEasingQuartEaseInOut @"TOEasingQuartEaseInOut"

#define TOEasingQuintEaseIn @"TOEasingQuintEaseIn"
#define TOEasingQuintEaseOut @"TOEasingQuintEaseOut"
#define TOEasingQuintEaseInOut @"TOEasingQuintEaseInOut"

#define TOEasingSineEaseIn @"TOEasingSineEaseIn"
#define TOEasingSineEaseOut @"TOEasingSineEaseOut"
#define TOEasingSineEaseInOut @"TOEasingSineEaseInOut"

@interface TOEasing : NSObject

+ (CGFloat) linear:(CGFloat)value;

+ (CGFloat) backEaseIn:(CGFloat)value;
+ (CGFloat) backEaseOut:(CGFloat)value;
+ (CGFloat) backEaseInOut:(CGFloat)value;

+ (CGFloat) bounceEaseIn:(CGFloat)value;
+ (CGFloat) bounceEaseOut:(CGFloat)value;
+ (CGFloat) bounceEaseInOut:(CGFloat)value;

+ (CGFloat) circEaseIn:(CGFloat)value;
+ (CGFloat) circEaseOut:(CGFloat)value;
+ (CGFloat) circEaseInOut:(CGFloat)value;

+ (CGFloat) cubicEaseIn:(CGFloat)value;
+ (CGFloat) cubicEaseOut:(CGFloat)value;
+ (CGFloat) cubicEaseInOut:(CGFloat)value;

+ (CGFloat) elasticEaseIn:(CGFloat)value;
+ (CGFloat) elasticEaseOut:(CGFloat)value;
+ (CGFloat) elasticEaseInOut:(CGFloat)value;

+ (CGFloat) expoEaseIn:(CGFloat)value;
+ (CGFloat) expoEaseOut:(CGFloat)value;
+ (CGFloat) expoEaseInOut:(CGFloat)value;

+ (CGFloat) quadEaseIn:(CGFloat)value;
+ (CGFloat) quadEaseOut:(CGFloat)value;
+ (CGFloat) quadEaseInOut:(CGFloat)value;

+ (CGFloat) quartEaseIn:(CGFloat)value;
+ (CGFloat) quartEaseOut:(CGFloat)value;
+ (CGFloat) quartEaseInOut:(CGFloat)value;

+ (CGFloat) quintEaseIn:(CGFloat)value;
+ (CGFloat) quintEaseOut:(CGFloat)value;
+ (CGFloat) quintEaseInOut:(CGFloat)value;

+ (CGFloat) sineEaseIn:(CGFloat)value;
+ (CGFloat) sineEaseOut:(CGFloat)value;
+ (CGFloat) sineEaseInOut:(CGFloat)value;

@end
