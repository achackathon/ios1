//
//  PAImageView.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "PAImageView.h"

@implementation PAImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (void)commonInit
{
    self.layer.cornerRadius = self.frame.size.width / 2.f;
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
    self.layer.shadowOffset = CGSizeMake(.0f, .5f);
    self.layer.shadowRadius = 1.5f;
}

@end
