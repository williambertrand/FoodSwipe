//
//  CardOverlayView.m
//  FoodSwipe
//
//  Created by William Bertrand on 1/23/15.
//  Copyright (c) 2015 William Bertrand. All rights reserved.
//

#import "CardOverlayView.h"

@interface CardOverlayView()

@property UIImageView *imageView;

@end


@implementation CardOverlayView



-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self)return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testImage"]];
    [self addSubview:self.imageView];
    
    return self;
    
}



/*Switch out images here with xCasset images*/
-(void)setMode:(CardOverlayViewMode *)mode {
    if(_mode == mode)
        return;
    
    _mode = mode;
    
    if(mode == CardOverlayViewModeLeft){
        self.imageView.image = [UIImage imageNamed:@"frown.png"];
    }
    else {
        self.imageView.image = [UIImage imageNamed:@"smile.png"];
    }
    
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(50, 50, 100, 100);
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
