//
//  ANEPVariable.m
//  ExpressionParser
//
//  Created by Alex Nichol on 9/17/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import "ANEPVariable.h"


@implementation ANEPVariable

@synthesize variableName, number;

- (void)dealloc {
	self.variableName = 0;
	self.number = nil;
	[super dealloc];
}

@end
