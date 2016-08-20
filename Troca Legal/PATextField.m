//
//  PATextField.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "PATextField.h"

@implementation PATextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, 12.f, .0f)];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.borderColor = [UIColor colorWithRed:220/255.f green:222/255.f blue:228/255.f alpha:1.f].CGColor;
    self.layer.borderWidth = 1.f;
}

@end
