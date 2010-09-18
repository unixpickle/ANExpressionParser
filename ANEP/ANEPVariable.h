//
//  ANEPVariable.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANEPNumber.h"


@interface ANEPVariable : NSObject {
	char variableName;
	ANEPNumber * number;
}
@property (readwrite) char variableName;
@property (nonatomic, retain) ANEPNumber * number;
@end
