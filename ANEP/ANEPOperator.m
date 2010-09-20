//
//  ANEPOperator.m
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import "ANEPOperator.h"


@implementation ANEPOperator
- (id)initWithCharacter:(char)_op {
	if (self = [super init]) {
		op = _op;
	}
	return self;
}
+ (ANEPOperator *)operatorWithCharacter:(char)c {
	switch (c) {
		case '+':
			return [[[ANEPOperator alloc] initWithCharacter:c] autorelease];
			break;
		case '-':
			return [[[ANEPOperator alloc] initWithCharacter:c] autorelease];
			break;
		case '/':
			return [[[ANEPOperator alloc] initWithCharacter:c] autorelease];
			break;
		case '*':
			return [[[ANEPOperator alloc] initWithCharacter:c] autorelease];
			break;
		case '^':
			return [[[ANEPOperator alloc] initWithCharacter:c] autorelease];
			break;
		default:
			return nil;
			break;
	}
	return nil;
}
- (char)character {
	return op;
}
- (ANEPNumber *)applyNumber:(ANEPNumber *)num toNumber:(ANEPNumber *)num1 {
	switch (op) {
		case '+':
			return [ANEPNumber numberWithDouble:([num doubleValue] + [num1 doubleValue])];
			break;
		case '-':
			return [ANEPNumber numberWithDouble:([num1 doubleValue] - [num doubleValue])];
			break;
		case '/':
			return [ANEPNumber numberWithDouble:([num1 doubleValue] / [num doubleValue])];
			break;
		case '*':
			return [ANEPNumber numberWithDouble:([num1 doubleValue] * [num doubleValue])];
			break;
		case '^':
			return [ANEPNumber numberWithDouble:(pow([num1 doubleValue], [num doubleValue]))];
			break;
		default:
			return nil;
			break;
	}
	return nil;
}
- (id)description {
	return [NSMutableString stringWithFormat:@"%c", op];
}
@end
