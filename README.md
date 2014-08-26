# Disclaimer

I have a more recent expression parser called [Expressions](https://github.com/unixpickle/Expressions).

This is way out of date. I have not worked on this in a long while, and I probably wasn't the best programmer when I made it. It uses exceptions out the wazoo which is completely inappropriate for applications that use Automatic Reference Counting. Speaking of which, this is pre-ARC.

# Overview

This is a string based expression parser for Objective-C.  Simply give it a string (that is a valid mathematical expression), and it evaluates it.

This is the syntax that it can take:

    (3(42^3 + sin(2*3 + 7/5)) / 200) - 2^(0.5)

You can also set the value of one letter variables.  This is useful for graphing, since you can plug in different values of x.  Here is the usage:

	ANEPExpression * expression = nil;
	@try {
		expression = [ANEPExpression expressionFromString:@"3 + 3^2 + sin(x * 3)"
		                                        variables:nil];
	} @catch (NSException * ex) {
		[pool drain];
		return NAN;
	}
	double answer = [[expression numberValue] floatValue];

There are many more features that you can use, and an NSString category for even simpler, one line syntax.  Also note that ANExpression will throw exceptions, so be prepared to catch anything that is thrown your way!

# License

If you should be crazy enough to use this utter monstrosity instead of [Expressions](https://github.com/unixpickle/Expressions), it's licensed under the BSD 2-clause license:

```
Copyright (c) 2014, Alex Nichol.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```