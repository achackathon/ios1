//
//  ProductsViewController.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductViewController.h"

#import "ProductCell.h"
#import "MBProgressHUD.h"

#import "Product.h"
#import "Image.h"
#import "Helper.h"
#import <Parse/Parse.h>

static CGFloat const kCellSpacing = 17.f;

@interface ProductsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray<Product *> *products;
@property (strong, nonatomic) NSArray<Image *> *images;

@property (copy, nonatomic) void(^imagesCompletionBlock)();

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
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (!error) {
            self.products = [Helper transformArray:objects ofClass:[Product class]];
            [self.collectionView reloadData];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Erro", @"") message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
    [self refreshImages];
}

- (void)refreshImages
{
    PFQuery *imagesQuery = [PFQuery queryWithClassName:@"Images"];
    [imagesQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (!error) {
            self.images = [Helper transformArray:objects ofClass:[Image class]];
            
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
        } else {
            [self refreshImages];
        }
        
        if (self.imagesCompletionBlock) {
            self.imagesCompletionBlock();
        }
    }];
}

- (void)openFilter
{
    
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        });
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
