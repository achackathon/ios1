//
//  Image.h
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Image : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) Product *product;

- (void) initOBject:(PFObject*) pfObject;

@end
