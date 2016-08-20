//
//  Product.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "Product.h"
#import "PFFile.h"

@implementation Product

- (instancetype)initWithObject:(PFObject *)pfObject {
    self = [super init];
    if (self) {
        self.uuid = pfObject.objectId;
        self.name = pfObject[@"model"];
        self.productDescription = pfObject[@"productDescription"];
        self.price = @([[pfObject objectForKey:@"price"] doubleValue]);
        self.forSell = [[pfObject objectForKey:@"isForBuy"] boolValue];
        self.forRent = [[pfObject objectForKey:@"isForRent"] boolValue];
        self.rentFrequency = pfObject[@"rentFrequency"];
        
        PFObject *categoryObject = [pfObject objectForKey:@"category"];
        self.category = [[ProductCategory alloc] initWithObject:categoryObject];
        
        PFObject *brandObject = [pfObject objectForKey:@"brand"];
        self.brand = [[Brand alloc] initWithObject:brandObject];
        
        PFObject *sellerObject  = [pfObject objectForKey:@"seller"];
        self.seller = [[User alloc] initWithObject:sellerObject];
        
        PFObject *imageObject = [pfObject objectForKey:@"featuredImage"];
        self.featuredImage = [[Image alloc] initWithObject:imageObject];
    }
    return self;
}

@end
