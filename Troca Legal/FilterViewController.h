//
//  FilterViewController.h
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Filter.h"

@interface FilterViewController : UIViewController

@property (strong, nonatomic) Filter *filter;

@property (copy, nonatomic) void(^completionBlock)(Filter *filter);

@end
