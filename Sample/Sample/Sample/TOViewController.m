//
//  TOViewController.m
//  Sample
//
//  Created by Marco Köppel on 17.08.13.
//  Copyright (c) 2013 Marco Köppel. All rights reserved.
//

#import "TOViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "TOValueTransition.h"

@interface TOViewController ()
@property (nonatomic, retain) CALayer *dot;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;

@property (nonatomic, retain) TOValueTransition *runningTransition;

@end

@implementation TOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CALayer *dotLayer = [CALayer layer];
    
    dotLayer.bounds = CGRectMake(0.0, 0.0, 20.0, 20.0);
    dotLayer.cornerRadius = 10.0;
    
    dotLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    
    dotLayer.position = CGPointMake(160.0, 240.0);
    
    dotLayer.opacity = 0.0;
    dotLayer.transform = CATransform3DMakeScale(1.3, 1.3, 0.0);
    
    [[self.view layer] addSublayer:dotLayer];
    self.dot = dotLayer;
    
    [TOValueTransition interpolateFrom:0.0 to:1.0 duration:1.9 easing:TOEasingSineEaseOut progress:^(CGFloat currentValue) {
        
        self.dot.opacity = currentValue;
        
        CGFloat scale = 1.3 - currentValue * 0.3;
        self.dot.transform = CATransform3DMakeScale(scale, scale, 0.0);
        
    } completed:^(CGFloat endValue) {
        
        self.dot.opacity = endValue;
        
        CGFloat scale = 1.3 - endValue * 0.3;
        self.dot.transform = CATransform3DMakeScale(scale, scale, 0.0);
        
    } cancelled:^(CGFloat cancelledValue) {
        
    }];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTap:(UITapGestureRecognizer *) sender{
    
    CGPoint target = [sender locationInView:self.view];
    CGPoint current = self.dot.position;
    
    if (self.runningTransition != nil) {
        
        [self.runningTransition cancel];
        self.runningTransition = nil;
    }
    
        self.runningTransition = [TOValueTransition interpolateFrom:0.0 to:1.0 duration:1.9 easing:TOEasingSineEaseOut progress:^(CGFloat currentValue) {
        
        self.dot.position = CGPointMake(current.x + ((target.x - current.x) *currentValue), current.y + ((target.y - current.y) *currentValue));
        
    } completed:^(CGFloat endValue) {        
        
        self.runningTransition = nil;
        
    } cancelled:^(CGFloat cancelledValue) {
    
    }];
}

@end
