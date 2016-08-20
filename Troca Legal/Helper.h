//
//  Helper.h
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Helper : NSObject

+ (NSArray *)transformArray:(NSArray *)array ofClass:(__unsafe_unretained Class)class;
+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)img target:(id)target andAction:(SEL)action;

@end
