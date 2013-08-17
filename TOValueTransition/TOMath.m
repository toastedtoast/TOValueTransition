//
//  GQMath.m
//  GetQrious
//
//  Created by Marco Köppel on 19.02.13.
//  Copyright (c) 2013 Marcus Naumann, Thomas Putnings, Marco Köppel GbR. All rights reserved.
//

#import "TOMath.h"

@implementation TOMath

+ (CGFloat)intermediate:(CGFloat)value min:(CGFloat)min max:(CGFloat)max{
    
    if (value <= min) return min;
    if (value >= max) return max;
    
    return value;
}

@end
