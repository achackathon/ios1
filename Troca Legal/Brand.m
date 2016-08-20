//
//  Brand.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "Brand.h"

@implementation Brand

- (instancetype)initWithObject:(PFObject *)pfObject {
    self = [super init];
    if (self) {
        self.uuid = pfObject.objectId;
        self.name = pfObject[@"name"];
    }
    return self;
}

@end
