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
+ (ANEPExpression *)expressionWithNumber:(ANEPNumber *)_number;
+ (ANEPExpression *)expressionFromString:(NSString *)str variables:(NSArray *)vars;
- (ANEPNumber *)numberValue;
@end
