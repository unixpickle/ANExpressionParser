//
//  ANEPOperator.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANEPNumber.h"

@interface ANEPOperator : NSObject {
	char op;
}
- (char)character;
- (id)initWithCharacter:(char)_op;
+ (ANEPOperator *)operatorWithCharacter:(char)c;
- (ANEPNumber *)applyNumber:(ANEPNumber *)num toNumber:(ANEPNumber *)num1;
@end
