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
#import "PFObject.h"

@interface History : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Product *product;

- (void) initOBject:(PFObject*) pfObject;

@end
