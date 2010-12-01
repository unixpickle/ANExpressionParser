#import <Foundation/Foundation.h>
#import "ANEP.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	ANEPVariable * xVariable = [[ANEPVariable alloc] init];
	[xVariable setNumber:[ANEPNumber numberWithDouble:3]];
	[xVariable setVariableName:'x'];
	ANEPVariable * yVariable = [[ANEPVariable alloc] init];
	[yVariable setNumber:[ANEPNumber numberWithDouble:100]];
	[yVariable setVariableName:'y'];
	
	NSArray * vArray = [NSArray arrayWithObjects:xVariable, yVariable, nil];
	
    //ANEPExpression * expression = [ANEPExpression expressionFromString:@"cos(0)((x + (15 - 5)) - (4(4)))" variables:[NSArray arrayWithObjects:xVariable, yVariable, nil]];
	ANEPExpression * expression = [ANEPExpression expressionFromString:@"cos(y - 0.5 / 0.5 * 2)(x + (15 - 5) * (4(4))" variables:vArray];
	ANEPExpression * expression2 = [ANEPExpression expressionFromString:@"-2x^2 + 3x + 2" variables:vArray];
	
	if (!expression) {
		NSLog(@"Invalid expression.");
	}
	
	NSLog(@" *** Function testing ***");
	
	NSLog(@"%f", [[expression numberValue] doubleValue]);
	NSLog(@"%f", [[expression2 numberValue] doubleValue]);
	NSLog(@"3+2 = %f", [@"3+2" parsedExpression]);
	
	[xVariable release];
	[yVariable release];
	
	NSLog(@" *** Exception Testing ***");
	@try {
		// uncomment any of the following error types
		// to test my exception handling
		ANEPExpression * ex = nil;
		// unknown variable
		//  ex = [ANEPExpression expressionFromString:@"3+x" variables:nil];
		// () error
		//  ex = [ANEPExpression expressionFromString:@"3+3)" variables:nil];
		// unknown function error
		//  ex = [ANEPExpression expressionFromString:@"test(3)" variables:nil];
		// random string testing
		//  ex = [ANEPExpression expressionFromString:@"adsklfj#&S2)()x" variables:nil];
		NSLog(@"Number: %f", [[ex numberValue] floatValue]);
	} @catch (NSException * error) {
		NSLog(@"Got exception: %@", error);
	}
	
    [pool drain];
    return 0;
}
