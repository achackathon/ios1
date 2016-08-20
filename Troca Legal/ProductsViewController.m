//
//  ProductsViewController.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ProductsViewController.h"

#import "ProductCell.h"
#import "MBProgressHUD.h"

#import "Product.h"
#import "Helper.h"
#import <Parse/Parse.h>

static CGFloat const kCellSpacing = 17.f;

@interface ProductsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray<Product *> *products;

@end

@implementation ProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view layoutIfNeeded];
    
    self.navigationItem.rightBarButtonItem = [Helper barButtonWithImage:[UIImage imageNamed:@"filter-results-button"] target:self andAction:@selector(openFilter)];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self refresh];
}

- (void)refresh
{
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
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
}

- (void)openFilter
{
    
}

#pragma mark - Collection View data source / delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat size = self.view.frame.size.width - (kCellSpacing * 3);
    
    return CGSizeMake(size, size);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    cell.product = self.products[indexPath.row];
    
    return cell;
}

@end
