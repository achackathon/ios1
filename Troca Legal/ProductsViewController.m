//
//  ProductsViewController.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductViewController.h"
#import "FilterViewController.h"

#import "ProductCell.h"
#import "MBProgressHUD.h"

#import "Product.h"
#import "Image.h"
#import "Helper.h"
#import "Filter.h"
#import <Parse/Parse.h>

static CGFloat const kCellSpacing = 17.f;

@interface ProductsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *noResultsLabel;

@property (strong, nonatomic) NSArray<Product *> *products;
@property (strong, nonatomic) NSArray<Image *> *images;

@property (copy, nonatomic) void(^imagesCompletionBlock)();
@property (strong, nonatomic) Filter *filter;

@end

@implementation ProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view layoutIfNeeded];
    
    self.navigationItem.rightBarButtonItem = [Helper barButtonWithImage:[UIImage imageNamed:@"filter-results-button"] target:self andAction:@selector(openFilter)];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self refresh];
    [self refreshImages];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)refresh
{
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query includeKey:@"category"];
    [query includeKey:@"brand"];
    [query includeKey:@"seller"];
    [query includeKey:@"featuredImage"];
    
    if (self.filter) {
        if (self.filter.category) {
            [query whereKey:@"category" equalTo:[PFObject objectWithoutDataWithClassName:@"Category" objectId:self.filter.category]];
        }
        
        if (self.filter.brand) {
            [query whereKey:@"brand" equalTo:[PFObject objectWithoutDataWithClassName:@"Brand" objectId:self.filter.brand]];
        }
        
        if (self.filter.priceFrom && self.filter.priceTo) {
            [query whereKey:@"price" greaterThanOrEqualTo:self.filter.priceFrom];
            [query whereKey:@"price" lessThanOrEqualTo:self.filter.priceTo];
        }
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (!error) {
            self.products = [Helper transformArray:objects ofClass:[Product class]];
            [self.collectionView reloadData];
            
            if (self.products.count == 0) {
                self.noResultsLabel.hidden = NO;
            } else {
                self.noResultsLabel.hidden = YES;
            }
            
            [self collectImages];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Erro", @"") message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (void)refreshImages
{
    PFQuery *imagesQuery = [PFQuery queryWithClassName:@"Images"];
    [imagesQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (!error) {
            self.images = [Helper transformArray:objects ofClass:[Image class]];
            
            [self collectImages];
        } else {
            [self refreshImages];
        }
        
        if (self.imagesCompletionBlock) {
            self.imagesCompletionBlock();
        }
    }];
}

- (void)collectImages
{
    for (Image *image in self.images) {
        for (Product *product in self.products) {
            if ([product.uuid isEqualToString:image.productID]) {
                if (!product.images) {
                    product.images = @[].mutableCopy;
                }
                
                [product.images addObject:image];
            }
        }
    }
}

- (void)openFilter
{
    [self performSegueWithIdentifier:@"filter" sender:nil];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"details"]) {
        if (self.images) {
            return YES;
        } else {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            __weak typeof(self) weakSelf = self;
            self.imagesCompletionBlock = ^{
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                [weakSelf performSegueWithIdentifier:identifier sender:sender];
            };
            
            return NO;
        }
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"details"]) {
        ProductCell *cell = sender;
        
        ProductViewController *productViewController = segue.destinationViewController;
        productViewController.product = cell.product;
    } else if ([segue.identifier isEqualToString:@"filter"]) {
        FilterViewController *filterViewController = segue.destinationViewController;
        filterViewController.completionBlock = ^(Filter *filter) {
            self.filter = filter;
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self refresh];
        };
    }
}

#pragma mark - Collection View data source / delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat size = (self.view.frame.size.width - (kCellSpacing * 3)) / 2.f;
    
    return CGSizeMake(size, size);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    cell.product = self.products[indexPath.row];
    
    return cell;
}

@end
