//
//  History.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "History.h"

@implementation History

- (instancetype)initWithObject:(PFObject *)pfObject {
    self = [super init];
    if (self) {
        self.uuid = pfObject.objectId;
        
        PFObject *userObject  = [pfObject objectForKey:@"user"];
        self.user = [[User alloc] initWithObject:userObject];
        
        PFObject *productObject  = [pfObject objectForKey:@"product"];
        self.product = [[Product alloc] initWithObject:productObject];
    }
    return self;
}

@end
