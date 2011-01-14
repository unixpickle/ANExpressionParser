//
//  NSString+ANEP.m
//  ExpressionParser
//
//  Created by Alex Nichol on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+ANEP.h"


@implementation NSString (ANEP)

- (float)parsedExpression {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	ANEPExpression * expression = nil;
	@try {
		expression = [ANEPExpression expressionFromString:self
													 variables:nil];
	} @catch (NSException * ex) {
		[pool drain];
		return NAN;
	}
	
	float ret = NAN;
	
	if (expression) {
		ret = [[expression numberValue] floatValue];
	}
	
	[pool drain];
	return ret;
}
- (float)parsedExpressionWithVariables:(NSArray *)variables {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	ANEPExpression * expression = nil;
	@try {
		expression = [ANEPExpression expressionFromString:self
																 variables:variables];
	} @catch (NSException * ex) {
		[pool drain];
		return NAN;
	}
	
	float ret = NAN;
	
	if (expression) {
		ret = [[expression numberValue] floatValue];
	}
	
	[pool drain];
	return ret;
}

@end
