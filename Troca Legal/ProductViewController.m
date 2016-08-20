//
//  ProductViewController.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ProductViewController.h"

#import "UIImageView+WebCache.h"

#import "Product.h"

@interface ProductViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *imagesScrollView;
@property (weak, nonatomic) IBOutlet UIView *imagesScrollViewContentView;
@property (weak, nonatomic) IBOutlet UIPageControl *imagesPageControl;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupUI
{
    [self addImageViews];
    self.imagesPageControl.numberOfPages = self.product.url.count;
    
    self.nameLabel.text = self.product.name;
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.decimalSeparator = @",";
    numberFormatter.maximumFractionDigits = 2;
}

- (void)addImageViews
{
    UIImageView *previousImageView;
    
    for (NSURL *imageURL in self.product.url) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [imageView sd_setImageWithURL:imageURL];
        
        [self.imagesScrollViewContentView addSubview:imageView];
        
        NSLayoutConstraint *leftConstraint;
        if (!previousImageView) {
            leftConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.imagesScrollViewContentView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:.0f];
        } else {
            leftConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:previousImageView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:.0f];
        }
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.imagesScrollViewContentView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.f
                                                                          constant:.0f];
    
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.imagesScrollViewContentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.f
                                                                             constant:.0f];
        
        [self.imagesScrollViewContentView addConstraints:@[leftConstraint, topConstraint, bottomConstraint]];
        
        if (imageURL == self.product.url.lastObject) {
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.imagesScrollViewContentView
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.f
                                                                                constant:.0f];
            
            [self.imagesScrollViewContentView addConstraint:rightConstraint];
        }
        
        previousImageView = imageView;
    }
}

@end
