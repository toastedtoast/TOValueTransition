//
//  TOEasing.m
//
//  Created by Marco Köppel on 19.02.13.
//  Copyright (c) 2013 Marco Köppel. All rights reserved.
//
//  Based on AHEasing - https://github.com/warrenm/AHEasing  
//

#import "TOEasing.h"

@implementation TOEasing

#pragma mark - Linear

+ (CGFloat) linear:(CGFloat)v
{
	return v;
}

#pragma mark - Back

+ (CGFloat) backEaseIn:(CGFloat)v
{
	return v * v * v - v/2 * sin(v * M_PI);
}

+ (CGFloat) backEaseOut:(CGFloat)v
{
	CGFloat f = (1 - v);
    return 1 - (f * f * f - f/2 * sin(f * M_PI));
}

+ (CGFloat) backEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		CGFloat f = 2 * v;
		return 0.5 * (f * f * f - f/2 * sin(f * M_PI));
	}
	else
	{
		CGFloat f = (1 - (2*v - 1));
		return 0.5 * (1 - (f * f * f - f/2 * sin(f * M_PI))) + 0.5;
	}
}

#pragma mark - Bounce

+ (CGFloat) bounceEaseIn:(CGFloat)v
{
	return 1 - [TOEasing bounceEaseOut:1 - v];
}

+ (CGFloat) bounceEaseOut:(CGFloat)v
{
	if(v < 4/11.0)
	{
		return (121 * v * v)/16.0;
	}
	else if(v < 8/11.0)
	{
		return (363/40.0 * v * v) - (99/10.0 * v) + 17/5.0;
	}
	else if(v < 9/10.0)
	{
		return (4356/361.0 * v * v) - (35442/1805.0 * v) + 16061/1805.0;
	}
	else
	{
		return (54/5.0 * v * v) - (513/25.0 * v) + 268/25.0;
	}
}

+ (CGFloat) bounceEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		return 0.5 * [TOEasing bounceEaseIn:v*2];
	}
	else
	{
		return 0.5 * [TOEasing bounceEaseOut:v * 2 - 1] + 0.5;
	}
}

#pragma mark - Circular

+ (CGFloat) circEaseIn:(CGFloat)v
{
	return 1 - sqrt(1 - (v * v));
}

+ (CGFloat) circEaseOut:(CGFloat)v
{
	return sqrt((2 - v) * v);
}

+ (CGFloat) circEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		return 0.5 * (1 - sqrt(1 - 4 * (v * v)));
	}
	else
	{
		return 0.5 * (sqrt(-((2 * v) - 3) * ((2 * v) - 1)) + 1);
	}
}

#pragma mark - Cubic

+ (CGFloat) cubicEaseIn:(CGFloat)v
{
	return v * v * v;
}

+ (CGFloat) cubicEaseOut:(CGFloat)v
{
	CGFloat f = (v - 1);
	return f * f * f + 1;
}

+ (CGFloat) cubicEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		return 4 * v * v * v;
	}
	else
	{
		CGFloat f = ((2 * v) - 2);
		return 0.5 * f * f * f + 1;
	}
}

#pragma mark - Elastic

+ (CGFloat) elasticEaseIn:(CGFloat)v
{
	return sin(13 * M_PI_2 * v) * pow(2, 10 * (v - 1));
}

+ (CGFloat) elasticEaseOut:(CGFloat)v
{
	return sin(-13 * M_PI_2 * (v + 1)) * pow(2, -10 * v) + 1;
}

+ (CGFloat) elasticEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		return 0.5 * sin(13 * M_PI_2 * (2 * v)) * pow(2, 10 * ((2 * v) - 1));
	}
	else
	{
		return 0.5 * (sin(-13 * M_PI_2 * ((2 * v - 1) + 1)) * pow(2, -10 * (2 * v - 1)) + 2);
	}
}

#pragma mark - Exponential

+ (CGFloat) expoEaseIn:(CGFloat)v
{
	return (v == 0.0) ? v : pow(2, 10 * (v - 1));
}

+ (CGFloat) expoEaseOut:(CGFloat)v
{
	return (v == 1.0) ? v : 1 - pow(2, -10 * v);
}

+ (CGFloat) expoEaseInOut:(CGFloat)v
{
	if(v == 0.0 || v == 1.0) return v;
    
	if(v < 0.5)
	{
		return 0.5 * pow(2, (20 * v) - 10);
	}
	else
	{
		return -0.5 * pow(2, (-20 * v) + 10) + 1;
	}
}

#pragma mark - Quadratic

+ (CGFloat) quadEaseIn:(CGFloat)v
{
	return v * v;
}

+ (CGFloat) quadEaseOut:(CGFloat)v
{
	return -(v * (v - 2));
}

+ (CGFloat) quadEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		return 2 * v * v;
	}
	else
	{
		return (-2 * v * v) + (4 * v) - 1;
	}
}

#pragma mark - Quartic

+ (CGFloat) quartEaseIn:(CGFloat)v
{
	return v * v * v * v;
}

+ (CGFloat) quartEaseOut:(CGFloat)v
{
	CGFloat f = (v - 1);
	return f * f * f * (1 - v) + 1;
}

+ (CGFloat) quartEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		return 8 * v * v * v * v;
	}
	else
	{
		CGFloat f = (v - 1);
		return -8 * f * f * f * f + 1;
	}
}

#pragma mark - Quintic

+ (CGFloat) quintEaseIn:(CGFloat)v
{
	return v * v * v * v * v;
}

+ (CGFloat) quintEaseOut:(CGFloat)v
{
	CGFloat f = (v - 1);
	return f * f * f * f * f + 1;
}

+ (CGFloat) quintEaseInOut:(CGFloat)v
{
	if(v < 0.5)
	{
		return 16 * v * v * v * v * v;
	}
	else
	{
		CGFloat f = ((2 * v) - 2);
		return  0.5 * f * f * f * f * f + 1;
	}
}

#pragma mark - Sine

+ (CGFloat) sineEaseIn:(CGFloat)v
{
	return sin((v - 1) * M_PI_2) + 1;
}

+ (CGFloat) sineEaseOut:(CGFloat)v
{
	return sin(v * M_PI_2);
}

+ (CGFloat) sineEaseInOut:(CGFloat)v
{
	return 0.5 * (1 - cos(v * M_PI));
}

@end
