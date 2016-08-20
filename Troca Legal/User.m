//
//  User.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "User.h"

@implementation User

- (void)initOBject:(PFObject *)pfObject {
    self.uuid = pfObject.objectId;
    self.name = pfObject[@"name"];
    self.lastName = pfObject[@"lastName"];
    self.email = pfObject[@"email"];
}

@end
