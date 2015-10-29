//
//  AddDishViewController.m
//  FoodSwipe
//
//  Created by William Bertrand on 1/26/15.
//  Copyright (c) 2015 William Bertrand. All rights reserved.
//

#import "AddDishViewController.h"

@interface AddDishViewController ()

@end

@implementation AddDishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CameraPressed:(id)sender {
    //check for camera
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        //camera is available
        UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
        
    }
    
    else {
        //camera is unavailable
        NSLog(@"Camera Unavailable");
    }
    
}

- (void)uploadImage:(NSData *)imageData {
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    //save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error) {
            
            PFObject *foodObject =[PFObject objectWithClassName:@"FoodObject"];
            [foodObject setObject:imageFile forKey:@"image"];
            
            foodObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            [foodObject setValue:@"TestFood" forKey:@"Name"];
            [foodObject setValue:@"Jamming Crepes" forKey:@"RestaurantName"];
            
            PFUser *user = [PFUser currentUser];
            [foodObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(!error) {
                    NSLog(@"Image Saved");
                }
                else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
        }
        else {
            NSLog(@"Error: %@ %@",error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        //update progress spinner here
    }];
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
