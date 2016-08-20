//
//  PurchaseViewController.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "PurchaseViewController.h"

#import "UIImageView+WebCache.h"

#import "Product.h"

@interface PurchaseViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIView *rentView;
@property (weak, nonatomic) IBOutlet UILabel *rentFrequencyLabel;
@property (weak, nonatomic) IBOutlet UITextField *rentFrequencyTextField;

@property (weak, nonatomic) IBOutlet UILabel *finalPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation PurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.nameLabel.text = self.product.name;
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.decimalSeparator = @",";
    numberFormatter.maximumFractionDigits = 2;
    
    if (self.product.isForSell) {
        self.priceLabel.text = [NSString stringWithFormat:@"R$%@", [numberFormatter stringFromNumber:self.product.price]];
        [self.actionButton setTitle:NSLocalizedString(@"COMPRAR", @"") forState:UIControlStateNormal];
        
        self.rentView.hidden = YES;
    } else if (self.product.isForRent) {
        self.priceLabel.text = [NSString stringWithFormat:@"R$%@ / %@", [numberFormatter stringFromNumber:self.product.price], self.product.rentFrequency];
        [self.actionButton setTitle:NSLocalizedString(@"ALUGAR", @"") forState:UIControlStateNormal];
        
        self.rentFrequencyLabel.text = self.product.rentFrequency;
        [self.rentFrequencyTextField becomeFirstResponder];
    }
    
    if ([self.product.category.name isEqualToString:@"Muletas"]) {
        self.typeImageView.image = [UIImage imageNamed:@"two-crutches"];
    } else if ([self.product.category.name isEqualToString:@"Cadeira de Rodas"]) {
        self.typeImageView.image = [UIImage imageNamed:@"wheelchair"];
    }
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.product.seller.name, self.product.seller.lastName];
    self.locationLabel.text = self.product.seller.location;
    
    [self.userImageView sd_setImageWithURL:self.product.seller.imageURL];
    
    [self updatePrice];
}

- (void)updatePrice
{
    CGFloat price = 0;
    
    if (self.product.isForSell) {
        price = self.product.price.floatValue;
    } else if (self.product.isForRent) {
        price = self.product.price.floatValue * self.rentFrequencyTextField.text.integerValue;
    }
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.decimalSeparator = @",";
    numberFormatter.maximumFractionDigits = 2;
    
    self.finalPriceLabel.text = [NSString stringWithFormat:@"R$ %@", [numberFormatter stringFromNumber:@(price)]];
}

- (IBAction)go:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"OK!", @"") message:@"Compra efetuada com sucesso" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Text Field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.rentFrequencyTextField.text = newString;
    [self updatePrice];
    
    return NO;
}

@end
