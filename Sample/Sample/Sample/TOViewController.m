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
@property (nonatomic, retain) UIView *dotContainer;

@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;

@property (nonatomic, retain) TOValueTransition *runningTransition;

- (void)setupDot;
- (void)displayDot;

- (void)applyPosition:(CGPoint)position;
- (void)updatePositionLabel:(CGPoint)position;

@end

@implementation TOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setupDot];
    [self displayDot];
    
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
    CGPoint current = CGPointMake(self.dotContainer.frame.origin.x + self.dot.frame.size.width / 2, self.dotContainer.frame.origin.y + self.dot.frame.size.height / 2);
    
    if (self.runningTransition != nil) {
        
        [self.runningTransition cancel];
        self.runningTransition = nil;
    }
        self.runningTransition = [TOValueTransition interpolateFrom:0.0 to:1.0 duration:1.9 easing:TOEasingElasticEaseOut    progress:^(CGFloat currentValue) {
          
            [self applyPosition:CGPointMake(current.x + ((target.x - current.x) *currentValue), current.y + ((target.y - current.y) *currentValue))];
            
    } completed:^(CGFloat endValue) {        
        
        self.runningTransition = nil;
        
    } cancelled:^(CGFloat cancelledValue) {
    
        self.runningTransition = nil;
    }];
}

#pragma mark Private

- (void)setupDot{
    
    UIView *dotContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    
    CALayer *dotLayer = [CALayer layer];
    
    dotLayer.bounds = dotContainer.bounds;
    dotLayer.cornerRadius = 10.0;
    
    dotLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    dotLayer.position = CGPointMake(10.0, 10.0);
    
    [[dotContainer layer] addSublayer:dotLayer];
    self.dot = dotLayer;
    
    self.dotContainer = dotContainer;
}

- (void)displayDot{
    
    self.dotContainer.transform = CGAffineTransformMakeScale(2.0, 2.0);
    self.dotContainer.alpha = 0.0;
    
    [self.view addSubview:self.dotContainer];
    [self applyPosition:CGPointMake(160.0, 280.0)];
    
    [TOValueTransition interpolateFrom:0.0 to:1.0 duration:3.4 easing:TOEasingElasticEaseOut progress:^(CGFloat currentValue) {
        
        self.dotContainer.alpha = currentValue;
        
        CGFloat scale = 2.0 - currentValue * (2.0 - 1.0);
        self.dotContainer.transform = CGAffineTransformMakeScale(scale, scale);
        
    } completed:^(CGFloat endValue) {
        
        self.dotContainer.alpha = endValue;
        
        CGFloat scale = 2.0 - endValue * (2.0 - 1.0);
        self.dotContainer.transform = CGAffineTransformMakeScale(scale, scale);
        
    } cancelled:^(CGFloat cancelledValue) {
        
    }];
}

- (void)applyPosition:(CGPoint)position{
    
    CGPoint adjustedPosition = CGPointMake(position.x - self.dotContainer.frame.size.width / 2, position.y - self.dotContainer.frame.size.height / 2);
    self.dotContainer.frame = CGRectMake(adjustedPosition.x, adjustedPosition.y, self.dotContainer.frame.size.width, self.dotContainer.frame.size.height);
    
    [self updatePositionLabel:adjustedPosition];
}

- (void)updatePositionLabel:(CGPoint)position{
    
    [self.positionLabel setText:[NSString stringWithFormat:@"(%d :: %d)", (int)position.x, (int)position.y]];
}

@end
