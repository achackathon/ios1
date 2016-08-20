//
//  ProfileViewController.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "User.h"
#import "UIImageView+WebCache.h"
#import "PAImageView.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet PAImageView *imagePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) User *user;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self refresh];
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    PFUser *currentUser = [PFUser currentUser];
    self.user = [[User alloc] initWithObject: currentUser];
}

- (void) updateView {
    self.name.text = [NSString stringWithFormat:@"%@ %@", self.user.name, self.user.lastName];
    self.email.text = self.user.email;
    self.location.text = self.user.location;
    
    [self.imagePicture sd_setImageWithURL:self.user.imageURL];
}

@end
