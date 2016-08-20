//
//  ProductCell.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ProductCell.h"

#import "UIImageView+WebCache.h"

#import "Product.h"

@interface ProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@end

@implementation ProductCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5.f;
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
    self.layer.shadowOffset = CGSizeMake(.0f, .5f);
    self.layer.shadowRadius = 1.5f;
}

- (void)setProduct:(Product *)product
{
    _product = product;
    
    [self.imageView sd_setImageWithURL:product.featuredImage.url];
    
    self.nameLabel.text = product.name;
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.decimalSeparator = @",";
    numberFormatter.maximumFractionDigits = 2;
    
    self.priceLabel.text = [NSString stringWithFormat:@"R$%@", [numberFormatter stringFromNumber:product.price]];
}

@end
