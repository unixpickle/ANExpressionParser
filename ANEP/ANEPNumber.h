//
//  ANEPNumber.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ANEPNumber : NSObject {
	double dValue;
}
- (double)doubleValue;
+ (ANEPNumber *)numberWithDouble:(double)d;
@end
