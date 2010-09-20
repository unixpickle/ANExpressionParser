//
//  ANEPNumber.m
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import "ANEPNumber.h"


@implementation ANEPNumber

- (id)makeNegative:(BOOL)really {
	if (really) {
		dValue *= -1;
	}
	return self;
}

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
