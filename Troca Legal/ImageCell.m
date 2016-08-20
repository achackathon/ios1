//
//  ImageCell.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "ImageCell.h"
#import "UIImageView+WebCache.h"

@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCell

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    
    [self.imageView sd_setImageWithURL:imageURL];
}

@end
