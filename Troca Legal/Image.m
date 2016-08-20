//
//  Image.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "Image.h"
#import "Product.h"
#import "PFObject.h"
#import "PFFile.h"

@implementation Image

- (instancetype)initWithObject:(PFObject *)pfObject {
    self = [super init];
    if (self) {
        self.uuid = pfObject.objectId;
        
        PFFile *imageFile  = [pfObject objectForKey:@"image"];
        self.url = [NSURL URLWithString:imageFile.url];
        
        PFObject *productObject  = [pfObject objectForKey:@"product"];
        self.productID = productObject.objectId;
    }
    return self;
}

@end
