//
//  LoginViewController.m
//  Troca Legal
//
//  Created by Matheus C. Candido on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailAddress;

@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* border */
    
    UIColor *borderColor = [UIColor colorWithRed:189.0 / 255.0 green:193.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
    
    _emailAddress.layer.borderColor = borderColor.CGColor;
    _emailAddress.layer.borderWidth = 0.5f;
    
    _password.layer.borderColor = borderColor.CGColor;
    _password.layer.borderWidth = 0.5f;
    
    /* padding */
    
    UIView *emailAddressPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];

    _emailAddress.leftView = emailAddressPadding;
    _emailAddress.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passwordPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];

    _password.leftView = passwordPadding;
    _password.leftViewMode = UITextFieldViewModeAlways;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
