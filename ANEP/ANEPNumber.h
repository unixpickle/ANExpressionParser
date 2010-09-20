//
//  ANEPNumber.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ANEPNumber : NSObject {
	double dValue;
}
- (id)makeNegative:(BOOL)really;
- (double)doubleValue;
+ (ANEPNumber *)numberWithDouble:(double)d;
@end
