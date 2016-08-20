//
//  Product.h
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Brand.h"
#import "Category.h"
#import "User.h"
#import "PFObject.h"

@interface Product : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) Brand *brand;
@property (nonatomic, strong) Category *category;
@property (nonatomic, strong) NSMutableArray *url;
@property (nonatomic, strong) User *seller;
@property (nonatomic, assign, getter=isForCell) BOOL forCell;
@property (nonatomic, assign, getter=isForRent) BOOL forRent;

- (void) initOBject:(PFObject*) pfObject;

@end
