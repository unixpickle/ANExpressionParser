//
//  ANEPNumber.m
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ANEPNumber.h"


@implementation ANEPNumber

- (id)description {
	return [NSMutableString stringWithFormat:@"%f", (float)dValue];
}

- (id)initWithDouble:(double)d {
	if (self = [super init]) {
		dValue = d;
	}
	return self;
}
- (double)doubleValue {
	return dValue;
}
+ (ANEPNumber *)numberWithDouble:(double)d {
	return [[[ANEPNumber alloc] initWithDouble:d] autorelease];
}

@end
