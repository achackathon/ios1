//
//  ProductViewController.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ProductViewController.h"

#import "UIImageView+WebCache.h"
#import "ImageCell.h"

#import "Product.h"

@interface ProductViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

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
    
    [self.view layoutIfNeeded];
    
    [self setupUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI
{
//    [self addImageViews];
    
    if (self.product.images.count == 1) {
        self.imagesPageControl.numberOfPages = 0;
    } else {
        self.imagesPageControl.numberOfPages = self.product.images.count;
    }
    
    self.nameLabel.text = self.product.name;
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.decimalSeparator = @",";
    numberFormatter.maximumFractionDigits = 2;
    
    if (self.product.isForSell) {
        self.priceLabel.text = [NSString stringWithFormat:@"R$%@", [numberFormatter stringFromNumber:self.product.price]];
        [self.actionButton setTitle:NSLocalizedString(@"COMPRAR", @"") forState:UIControlStateNormal];
    } else if (self.product.isForRent) {
        self.priceLabel.text = [NSString stringWithFormat:@"R$%@ / dia", [numberFormatter stringFromNumber:self.product.price]];
        [self.actionButton setTitle:NSLocalizedString(@"ALUGAR", @"") forState:UIControlStateNormal];
    }
    
    self.descriptionLabel.text = self.product.productDescription;
    
    if ([self.product.category.name isEqualToString:@"Muletas"]) {
        self.typeImageView.image = [UIImage imageNamed:@"two-crutches"];
    } else if ([self.product.category.name isEqualToString:@"Cadeira de Rodas"]) {
        self.typeImageView.image = [UIImage imageNamed:@"wheelchair"];
    }
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.product.seller.name, self.product.seller.lastName];
    self.locationLabel.text = self.product.seller.location;
    
    [self.userImageView sd_setImageWithURL:self.product.seller.imageURL];
}

- (void)addImageViews
{
    UIImageView *previousImageView;
    
    for (Image *image in self.product.images) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView sd_setImageWithURL:image.url];
        
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
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.imagesScrollView
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.f
                                                                            constant:.0f];
        
        [self.imagesScrollViewContentView addConstraints:@[leftConstraint, topConstraint, bottomConstraint]];
        [self.imagesScrollView addConstraint:widthConstraint];
        
        if (image == self.product.images.lastObject) {
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

#pragma mark - Collection View data source / delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.product.images.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.imageURL = self.product.images[indexPath.row].url;
    
    return cell;
}

#pragma mark - Scroll View delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger page = roundf(scrollView.contentOffset.x / self.view.frame.size.width);
    self.imagesPageControl.currentPage = page;
}

@end
