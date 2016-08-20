//
//  Image.m
//  Troca Legal
//
//  Created by Avenue Code Brazil on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "Image.h"
#import "PFObject.h"
#import "PFFile.h"

@implementation Image

- (void)initOBject:(PFObject *)pfObject {
    self.uuid = pfObject.objectId;
    
    PFFile *imageFile  = [pfObject objectForKey:@"image"];
    self.url = [NSURL URLWithString:imageFile.url];
    
    PFObject *productObject  = [pfObject objectForKey:@"product"];
    [self.product initOBject:productObject];
}

@end
