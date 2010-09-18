#import <Foundation/Foundation.h>
#import "ANEP.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	ANEPVariable * xVariable = [[ANEPVariable alloc] init];
	[xVariable setNumber:[ANEPNumber numberWithDouble:100]];
	[xVariable setVariableName:'x'];
	ANEPVariable * yVariable = [[ANEPVariable alloc] init];
	[yVariable setNumber:[ANEPNumber numberWithDouble:2]];
	[yVariable setVariableName:'y'];
	
    //ANEPExpression * expression = [ANEPExpression expressionFromString:@"cos(0)((x + (15 - 5)) - (4(4)))" variables:[NSArray arrayWithObjects:xVariable, yVariable, nil]];
	ANEPExpression * expression = [ANEPExpression expressionFromString:@"cos(y - 0.5 / 0.5 * 2)(x + (15 - 5) * (4(4))" variables:[NSArray arrayWithObjects:xVariable, yVariable, nil]];
	
	if (!expression) {
		NSLog(@"Invalid expression.");
	}
	
	NSLog(@"%f", [[expression numberValue] doubleValue]);
	
    [pool drain];
    return 0;
}
