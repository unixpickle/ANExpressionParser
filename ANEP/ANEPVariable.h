//
//  ANEPVariable.h
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANEPNumber.h"


@interface ANEPVariable : NSObject {
	char variableName;
	ANEPNumber * number;
}
@property (readwrite) char variableName;
@property (nonatomic, retain) ANEPNumber * number;
@end
