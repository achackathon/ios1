//
//  ProductCategory.h
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"

@interface ProductCategory : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithObject:(PFObject *)pfObject;

@end
