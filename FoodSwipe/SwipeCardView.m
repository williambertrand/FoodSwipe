//
//  SwipeCardView.m
//  FoodSwipe
//
//  Created by William Bertrand on 1/4/15.
//  Copyright (c) 2015 William Bertrand. All rights reserved.
//

#import "SwipeCardView.h"
#import "SwipeBackgroundViewController.h"

@implementation SwipeCardView


-(id)init{
    self = [super init];
    if (!self)return nil;
    
    self.backgroundColor =[UIColor lightGrayColor];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    [self loadImageAndStyle];
    self.overlayView = [[CardOverlayView alloc] initWithFrame:self.bounds];
    CGPoint p = self.overlayView.center;
    self.overlayView.center = p;
    self.overlayView.alpha = 0.0;
    [self addSubview:self.overlayView];
    
    return self;
}


-(void)loadImageAndStyle {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frown.png"]];
    imageView.frame = self.bounds;
    NSLog(@"Bounds of image: ");
    NSLog(@"x:%f y:%f w:%f h:%f",self.bounds.origin.x,self.bounds.origin.y,self.bounds.size.width,self.bounds.size.height);
    [self addSubview:imageView];
    self.layer.cornerRadius = 8;
    self.layer.shadowOffset = CGSizeMake(7, 7);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = .5;
    
}

-(void)dragged:(UIPanGestureRecognizer *)gestureRecognizer{
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;
    
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
            
        case UIGestureRecognizerStateChanged:{
            CGFloat rotaitionStength = MIN(xDistance / 320, 1);
            CGFloat rotationAngle = (CGFloat)(2 * M_PI * rotaitionStength / 16);
            CGFloat scaleStrength = 1 - fabsf(rotaitionStength) / 4;
            CGFloat scale = MAX(scaleStrength, 0.93);
            
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngle);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaleTransform;
            NSLog(@"x:%f, y:%f",xDistance,yDistance);
            [self updateOverlay:xDistance];
            
            break;
        };
            
        case UIGestureRecognizerStateEnded:{
            if(fabs(xDistance) > 70)
            {
                [self swipePerformed:xDistance];
            }
            else
            {
                [self resetViewPositionAndTransforms];
            }
            break;
        };
            
        case UIGestureRecognizerStateCancelled: break;
        case UIGestureRecognizerStateFailed: break;
        case UIGestureRecognizerStatePossible: break;
            
            
        default:
            break;
    }
    
    
}

-(void)updateOverlay:(CGFloat)distance{
    if(distance > 0)
    {
        self.overlayView.mode = CardOverlayViewModeRight;
    }
    else if (distance < 0)
    {
        self.overlayView.mode = CardOverlayViewModeRight;
    }
    CGFloat overlayStrength = MIN(fabs(distance) / 100, .4);
    self.overlayView.alpha = overlayStrength;
}

-(void)resetViewPositionAndTransforms {
    [UIView animateWithDuration:0.2 animations:^{
        self.center = self.originalPoint;
        self.transform = CGAffineTransformMakeRotation(0);
        self.overlayView.alpha = 0.0;
    }];
}

-(void)swipePerformed:(CGFloat)distance{
    /* Upon swiping: if right, add object to accepted array, if no, discard
     *               add new "In the whole" swipecard below the on-deck swipecard
     *
     */
    CGPoint exitPoint = CGPointMake(0, -400);
    
    if (distance < 0) {
        //Swipe performed left
        exitPoint.x = - 400;
    }
    else{
        //swipe performed right
        exitPoint.x = 1000;
    }
    NSLog(@"swipe: %f",distance);
    [UIView animateWithDuration:0.2 animations:^{
        self.center = exitPoint;
        self.overlayView.alpha = 1.0;
    }];
    [self removeFromSuperview];
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
