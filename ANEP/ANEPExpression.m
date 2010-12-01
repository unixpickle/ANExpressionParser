//
//  ANEPExpression.m
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import "ANEPExpression.h"


@implementation ANEPExpression
- (void)runOperations:(char)op alt:(char)alt {
	for (int i = 0; i < [subcomponents count]; i += 2) {
		// generate number
		if (i + 2 < [subcomponents count]) {
			ANEPNumber * number1 = [subcomponents objectAtIndex:i];
			ANEPOperator * operator = [subcomponents objectAtIndex:i+1];
			ANEPNumber * number2 = [subcomponents objectAtIndex:i+2];
			if ([number2 respondsToSelector:@selector(doubleValue)] && [number1 respondsToSelector:@selector(doubleValue)]) {
				if ([operator respondsToSelector:@selector(applyNumber:toNumber:)]) {
					if ([operator character] == op || [operator character] == alt) {
						ANEPNumber * num = [operator applyNumber:number2 toNumber:number1];
						[subcomponents removeObjectAtIndex:i+2];
						[subcomponents removeObjectAtIndex:i+1];
						[subcomponents removeObjectAtIndex:i];
						[subcomponents insertObject:num atIndex:i];
						i -= 2;
					}
				}
			}
		}
	}
}
- (ANEPNumber *)numberValue {
	// calculate number
	if (!subcomponents || [subcomponents count] <= 0) {
		NSException * ex = [[NSException alloc] initWithName:@"ANEPParseError" reason:@"Error parsing subcomponents of expression" userInfo:nil];
		@throw ex;
		[ex release];
		return [ANEPNumber numberWithDouble:0];
	}
	[self runOperations:'^' alt:'^'];
	[self runOperations:'*' alt:'/'];
	[self runOperations:'+' alt:'-'];
	
	return [subcomponents objectAtIndex:0];
}
- (ANEPOperator *)operatorForChar:(char)c {
	return [ANEPOperator operatorWithCharacter:c];
}
+ (ANEPExpression *)readExpression:(NSString *)str fromIndex:(int *)j variables:(NSArray *)vars {
	// process sub-expression
	//NSMutableString * substr = [[[NSMutableString alloc] init] autorelease];
	NSMutableData * d = [[NSMutableData alloc] init];
	int count = 1;
	for (j[0] = j[0] + 1; j[0] < [str length]; j[0] = j[0] + 1) {
		char c1 = [str characterAtIndex:j[0]];
		if (c1 == '(') count++;
		if (c1 == ')') count--;
		if (count <= 0) break;
		[d appendBytes:&c1 length:1];
		//[substr appendFormat:@"%c", c1];
	}
	NSString * substr = [[[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding] autorelease];
	[d release];
	ANEPExpression * subexpr = [ANEPExpression expressionFromString:substr variables:vars];
	return subexpr;
}
+ (ANEPNumber *)readNumber:(NSString *)str fromIndex:(int *)j {
	//NSMutableString * digitString = [NSMutableString new];
	NSMutableData * myDigitString = [[NSMutableData alloc] init];
	int length = [str length];
	const char * chars = [str UTF8String];
	for (j = j; j[0] < length; j[0] = j[0] + 1) {
		char t = chars[j[0]];
		if (!isdigit(t) && t != '.') {
			break;
		} else {
			[myDigitString appendBytes:&t length:1];
			//[digitString appendFormat:@"%c", t];
		}
	}
	NSString * digitString = [[NSString alloc] initWithData:myDigitString encoding:NSUTF8StringEncoding];
	[myDigitString release];
	j[0] -= 1;
	return [ANEPNumber numberWithDouble:[[digitString autorelease] doubleValue]];
}
+ (ANEPVariable *)variableOfName:(char)name fromArray:(NSArray *)vars {
	ANEPVariable * ret = nil;
	for (int j = 0; j < [vars count]; j++) {
		ANEPVariable * var = [vars objectAtIndex:j];
		if ([var variableName] == name) {
			ret = var;
			break;
		}
	}
	return ret;
}
- (id)initWithExpression:(NSString *)str variables:(NSArray *)vars {
	if (self = [super init]) {
		BOOL negative = NO;
		subcomponents = [[NSMutableArray alloc] init];
		// loop through keywords
		BOOL lastWasNumber = NO;
		for (int i = 0; i < [str length]; i++) {
			char c = [str characterAtIndex:i];
			ANEPOperator * operator = [self operatorForChar:c]; 
			if (!isblank((int)c)) {
				if (c == '(') {
					// process sub-expression
					
					ANEPExpression * subexpr = [ANEPExpression readExpression:str fromIndex:&i variables:vars];
					if (lastWasNumber) {
						// assume multiplication
						[subcomponents addObject:[ANEPOperator operatorWithCharacter:'*']];
					}
					if (subexpr) [subcomponents addObject:[[subexpr numberValue] makeNegative:negative]];
					negative = NO;
					if (subexpr) lastWasNumber = YES;
					
				} else if (c == ')') {
					NSException * ex = [[NSException alloc] initWithName:@"ANEPParenthesesError" reason:@"There were too many ')' in the expression provided" userInfo:nil];
					@throw ex;
					[ex release];
					return nil;
				} else if (isdigit(c)) {
					ANEPNumber * _number = [ANEPExpression readNumber:(NSString *)str fromIndex:&i];
					if (lastWasNumber) {
						// assume multiplication
						[subcomponents addObject:[ANEPOperator operatorWithCharacter:'*']];
					}
					if (_number) [subcomponents addObject:[_number makeNegative:negative]];
					negative = NO;
					lastWasNumber = YES;
				} else if (operator != nil) {
					negative = NO;
					if (c == '-') {
						if (!lastWasNumber) {
							negative = YES;
						}
					}
					if (!negative) {
						[subcomponents addObject:operator];
					}
					lastWasNumber = NO;
				} else if (isalnum(c)) {
					// either a variable or a function mame
					NSMutableString * functionName = [[NSMutableString new] autorelease];
					for (i = i; i < [str length]; i++) {
						if (!isalnum([str characterAtIndex:i]) || isblank([str characterAtIndex:i]) || isdigit([str characterAtIndex:i])) {
							i--;
							break;
						} else [functionName appendFormat:@"%c", [str characterAtIndex:i]];
					}
					if ([functionName length] == 1) {
						// it's a variable
						ANEPVariable * variable = nil;
						if (vars) {
							variable = [ANEPExpression variableOfName:[functionName characterAtIndex:0] fromArray:vars];
						}
						//lastWasNumber = NO;
						if (variable) {
							if (lastWasNumber) {
								// assume multiplication
								[subcomponents addObject:[ANEPOperator operatorWithCharacter:'*']];
							}
							[subcomponents addObject:[[variable number] makeNegative:(!lastWasNumber && negative)]];
							negative = NO;
							lastWasNumber = YES;
						} else {
							NSException * ex = [[NSException alloc] initWithName:@"ANEPUnknownVariable"
																		  reason:[NSString stringWithFormat:@"Could not find variable of the name '%@'.", functionName] userInfo:nil];
							@throw ex;
							[ex release];
							return nil;
						}
					} else {
						i ++;
						ANEPExpression * expr = [ANEPExpression readExpression:str fromIndex:&i variables:vars];
						ANEPNumber * numbr = [ANEPFunction applyFunction:functionName toNumber:[expr numberValue]];
						if (numbr) [subcomponents addObject:[numbr makeNegative:negative]];
						else return nil;
						negative = NO;
						lastWasNumber = YES;
					}
				}
			}
		}
	}
	return self;
}
- (id)initWithNumber:(ANEPNumber *)_number {
	if (self = [super init]) {
		number = [_number retain];
	}
	return self;
}
+ (ANEPExpression *)expressionWithNumber:(ANEPNumber *)_number {
	return [[[ANEPExpression alloc] initWithNumber:_number] autorelease];
}
+ (ANEPExpression *)expressionFromString:(NSString *)str variables:(NSArray *)vars {
	return [[[ANEPExpression alloc] initWithExpression:str variables:vars] autorelease];
}
- (id)description {
	NSMutableString * str = [NSMutableString new];
	for (int i = 0; i < [subcomponents count]; i++) {
		[str appendFormat:@"%@ ", [[subcomponents objectAtIndex:i] description]];
	}
	return [str autorelease];
}
- (void)dealloc {
	[subcomponents release];
	[number release];
	[super dealloc];
}
@end
