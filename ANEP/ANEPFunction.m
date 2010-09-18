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
	if ([name isEqual:@"sin"]) {
		return [ANEPNumber numberWithDouble:sin([num doubleValue])];
	} else if ([name isEqual:@"cos"]) {
		return [ANEPNumber numberWithDouble:cos([num doubleValue])];
	} else if ([name isEqual:@"tan"]) {
		return [ANEPNumber numberWithDouble:tan([num doubleValue])];
	}
	return nil;
}

@end
