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

- (void)initOBject:(PFObject *)pfObject {
    self.uuid = pfObject.objectId;
    self.name = pfObject[@"name"];
    self.productDescription = pfObject[@"productDescription"];
    self.price = @([[pfObject objectForKey:@"price"] doubleValue]);
    self.forCell = @([[pfObject objectForKey:@"isForCell"] boolValue]);
    self.forRent = @([[pfObject objectForKey:@"isForRent"] boolValue]);
    
    PFObject *categoryObject = [pfObject objectForKey:@"category"];
    [self.category initOBject:categoryObject];
    
    PFObject *brandObject = [pfObject objectForKey:@"brand"];
    [self.brand initOBject:brandObject];
    
    PFObject *sellerObject  = [pfObject objectForKey:@"seller"];
    [self.seller initOBject:sellerObject];
    
    NSMutableArray *imagesArray = [pfObject  mutableArrayValueForKey:@"seller"];
    
    for (PFFile *item in imagesArray) {
        [self.url addObject: [NSURL URLWithString:item.url]];
    }
}

@end
