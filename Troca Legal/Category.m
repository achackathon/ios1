//
//  Category.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "Category.h"

@implementation Category

- (void)initOBject:(PFObject *)pfObject {
    self.uuid = pfObject.objectId;
    self.name = pfObject[@"name"];
}

@end
