//
//  SwipeCardView.h
//  FoodSwipe
//
//  Created by William Bertrand on 1/4/15.
//  Copyright (c) 2015 William Bertrand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardOverlayView.h"
@interface SwipeCardView : UIView

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CardOverlayView *overlayView;
@property (nonatomic) CGPoint originalPoint;

@end
