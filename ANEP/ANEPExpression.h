//
//  ANEPExpression.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANEP.h"

@interface ANEPExpression : NSObject {
	NSMutableArray * subcomponents;
	ANEPNumber * number;
}

// CALL THESE METHODS TO PARSE AN EXPRESSION
+ (ANEPExpression *)expressionFromString:(NSString *)str variables:(NSArray *)vars;
- (ANEPNumber *)numberValue;

// methods not to be called
+ (ANEPExpression *)expressionWithNumber:(ANEPNumber *)_number;

@end
