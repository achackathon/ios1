//
//  Helper.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (NSArray *)transformArray:(NSArray *)array ofClass:(__unsafe_unretained Class)class
{
    NSMutableArray *newArray = [NSMutableArray new];
    
    for (NSDictionary *item in array) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id parsedItem = [[class alloc] performSelector:NSSelectorFromString(@"initWithObject:") withObject:item];
#pragma clang diagnostic pop
        [newArray addObject:parsedItem];
    }
    
    return newArray;
}

+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)img target:(id)target andAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setUserInteractionEnabled:YES];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 6, img.size.width, img.size.height)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
