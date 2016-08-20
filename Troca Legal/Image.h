//
//  Image.h
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"

@class Product;

@interface Image : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSURL *url;
@property (strong, nonatomic) NSString *productID;

- (instancetype)initWithObject:(PFObject *) pfObject;

@end
