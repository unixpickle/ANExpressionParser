//
//  ANEPFunction.m
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import "ANEPFunction.h"


@implementation ANEPFunction

+ (ANEPNumber *)applyFunction:(NSString *)name toNumber:(ANEPNumber *)num {
	float number = [num floatValue];
	if ([name isEqual:@"sin"]) {
		return [ANEPNumber numberWithDouble:sin([num doubleValue])];
	} else if ([name isEqual:@"cos"]) {
		return [ANEPNumber numberWithDouble:cos([num doubleValue])];
	} else if ([name isEqual:@"tan"]) {
		return [ANEPNumber numberWithDouble:tan([num doubleValue])];
	} else if ([name isEqual:@"log"]) {
		double d = log([num doubleValue]);
		if (!isnan(d) && !isinf(d)) return [ANEPNumber numberWithDouble:d];
		else return [ANEPNumber numberWithDouble:0];
	} else if ([name isEqual:@"sqrt"]) {
		double d = sqrtf([num doubleValue]);
		if ([num doubleValue] < 0) d = 0 - sqrt([num doubleValue] * -1);
		return [ANEPNumber numberWithDouble:d];
	}
	NSException * ex = [[NSException alloc] initWithName:@"ANEPInvalidFunction" reason:[NSString stringWithFormat:@"The function '%@' was not defined.", name] userInfo:nil];
	@throw ex;
	[ex release];
	return nil;
}

@end
