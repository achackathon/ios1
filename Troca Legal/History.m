//
//  History.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "History.h"

@implementation History

- (void)initOBject:(PFObject *)pfObject {
    self.uuid = pfObject.objectId;
    
    PFObject *userObject  = [pfObject objectForKey:@"user"];
    [self.user initOBject:userObject];
    
    PFObject *productObject  = [pfObject objectForKey:@"product"];
    [self.product initOBject:productObject];
}

@end
