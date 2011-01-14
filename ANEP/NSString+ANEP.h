//
//  NSString+ANEP.h
//  ExpressionParser
//
//  Created by Alex Nichol on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ANEPExpression.h"

@interface NSString (ANEP) 

// these methods use ANEPExpression to parse expressions.
// they catch exceptions for you, and drain the autorelease pool.

- (float)parsedExpression;
- (float)parsedExpressionWithVariables:(NSArray *)variables;

@end