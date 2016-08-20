//
//  User.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>

@implementation User

- (instancetype)initWithObject:(PFObject *)pfObject {
    self = [super init];
    if (self) {
        self.uuid = pfObject.objectId;
        self.name = pfObject[@"name"];
        self.lastName = pfObject[@"lastname"];
        self.email = pfObject[@"email"];
        self.location = pfObject[@"location"];
        
        PFFile *imageFile = [pfObject objectForKey:@"picture"];
        self.imageURL = [NSURL URLWithString:imageFile.url];
    }
    return self;
}

@end
