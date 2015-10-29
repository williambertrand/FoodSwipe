//
//  CardOverlayView.h
//  FoodSwipe
//
//  Created by William Bertrand on 1/23/15.
//  Copyright (c) 2015 William Bertrand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CardOverlayViewMode){
    CardOverlayViewModeRight,
    CardOverlayViewModeLeft
};

@interface CardOverlayView : UIView

@property (nonatomic) CardOverlayViewMode *mode;

@end
