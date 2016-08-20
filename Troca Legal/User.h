//
//  User.h
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;

- (void) initOBject:(PFObject*) pfObject;

@end
