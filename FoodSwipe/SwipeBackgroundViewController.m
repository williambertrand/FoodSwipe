//
//  SwipeBackgroundViewController.m
//  FoodSwipe
//
//  Created by William Bertrand on 1/4/15.
//  Copyright (c) 2015 William Bertrand. All rights reserved.
//

#import "SwipeBackgroundViewController.h"
#import "SwipeCardView.h"
@interface SwipeBackgroundViewController ()

@property (nonatomic, strong) SwipeCardView *swipeCardView;
@property (nonatomic, strong) SwipeCardView *onDeckSwipeView;
@property (nonatomic, strong) SwipeCardView *swipeCardViewNew;

@end

@implementation SwipeBackgroundViewController {
    NSMutableArray *loadedFoodObjects;
    NSMutableArray *acceptedObjects;
    NSMutableArray *deniedObjects;
}

@synthesize loadingView;


- (void)viewDidLoad {
    
    if([self init]){
        loadingView.image = [UIImage imageNamed:@"Loading.png"];
        loadingView.frame = CGRectMake(0, 0, 400, 400);
        loadingView.hidden = NO;
        loadedFoodObjects = [[NSMutableArray alloc] init];
        
        //Get the foodObjects off Parse
        [self fillParseObjectAray];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(id)init {
    self = [super init];
    if(!self) return nil;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSwipeCards];
    
    
    acceptedObjects = [[NSMutableArray alloc] init];
    deniedObjects = [[NSMutableArray alloc] init];
    
    return self;
    
}

-(void)initSwipeCards {
    self.onDeckSwipeView = [[SwipeCardView alloc]init];
    self.swipeCardViewNew = [[SwipeCardView alloc] init];
    
    [self.view addSubview:self.onDeckSwipeView];
    
    self.swipeCardView = [[SwipeCardView alloc] init];
    [self.view addSubview: self.swipeCardView];
    [self layoutSubViews];
}

-(void)layoutSubViews{
    CGSize windowSize = self.view.frame.size;
    self.swipeCardView.frame = CGRectMake(0,0,windowSize.width * .8, windowSize.height * .6);
    self.onDeckSwipeView.frame = CGRectMake(0,0,windowSize.width * .8, windowSize.height * .6);
    CGPoint p = self.view.center;
    p.y -= windowSize.height / 8;
    self.swipeCardView.center = p;
    self.onDeckSwipeView.center = p;
    
}


-(void)fillParseObjectAray {
    PFQuery *query = [PFQuery queryWithClassName:@"FoodObject"];
    
    //Get a copy of the first 100 FoodObjects
    loadedFoodObjects = [[query findObjects] copy];
    NSLog(@"SIZE: %lu",(unsigned long)[loadedFoodObjects count]);
    
    loadingView.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
