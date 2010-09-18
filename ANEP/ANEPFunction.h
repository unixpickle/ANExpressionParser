//
//  ANEPFunction.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANEPNumber.h"


@interface ANEPFunction : NSObject {

}
+ (ANEPNumber *)applyFunction:(NSString *)name toNumber:(ANEPNumber *)num;
@end
