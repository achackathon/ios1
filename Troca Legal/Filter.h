//
//  Filter.h
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSNumber *priceFrom;
@property (strong, nonatomic) NSNumber *priceTo;

@end
