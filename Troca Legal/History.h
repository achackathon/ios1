//
//  History.h
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Product.h"

@interface History : NSObject

@property (nonatomic, strong) NSNumber *uuid;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Product *product;

@end
