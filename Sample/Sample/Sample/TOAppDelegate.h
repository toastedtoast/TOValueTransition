//
//  TOAppDelegate.h
//  Sample
//
//  Created by Marco Köppel on 17.08.13.
//  Copyright (c) 2013 Marco Köppel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOViewController;

@interface TOAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TOViewController *viewController;

@end
