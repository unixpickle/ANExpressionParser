//
//  ANEPFunction.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANEPNumber.h"


@interface ANEPFunction : NSObject {

}
+ (ANEPNumber *)applyFunction:(NSString *)name toNumber:(ANEPNumber *)num;
@end
