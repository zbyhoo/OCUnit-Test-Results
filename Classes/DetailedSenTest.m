//
//  DetailedSenTest.m
//  OCUnit Test Results
//
//  Created by Zbigniew Kominek on 8/29/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import "DetailedSenTest.h"
#import <SenTestingKit/SenTest.h>

@implementation DetailedSenTest

@synthesize senTest = _senTest;
@synthesize name = _name;
@synthesize duration = _duration;
@synthesize failures = _failures;
@synthesize testCount = _testCount;

- (id)initWithSenTest:(SenTest*)test
{
    self = [super init];
    if (self) {
        _senTest = [test retain];
        _name = [_senTest.name retain];
        _duration = 0;
        _failures = 0;
        _testCount = 0;
    }
    return self;
}

- (void) dealloc
{
    [_name release];
    _name = nil;
    
    [_senTest release];
    _senTest = nil;
    
    [super dealloc];
}

- (void) startTimer
{
    _duration = [[NSDate date] timeIntervalSince1970];
}

- (void) stopTimer
{
    _duration = [[NSDate date] timeIntervalSince1970] - _duration;
}

- (void) addFailure
{
    ++_failures;
}

- (void) addTest
{
    ++_testCount;
}

- (NSString*) durationInSec
{
    return [NSString stringWithFormat:@"%.6f", _duration / 1000.0];
}

@end
