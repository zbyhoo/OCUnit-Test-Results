//
//  OCUnitListener.m
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import "OCUnitListener.h"
#import <SenTestingKit/SenTest.h>

@implementation OCUnitListener

@synthesize storageDelegate = _storageDelegate;

- (id) init
{
    self = [super init];
    if (self) 
    {
        [self initializeNotificationListeners];
    }
    
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.storageDelegate = nil;

    [super dealloc];
}

- (void) initializeNotificationListeners
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(testSuiteStarted:) name:SenTestSuiteDidStartNotification object:nil];
    [center addObserver:self selector:@selector(testSuiteEnded:) name:SenTestSuiteDidStopNotification object:nil];
    [center addObserver:self selector:@selector(testCaseStarted:) name:SenTestCaseDidStartNotification object:nil];
    [center addObserver:self selector:@selector(testCaseEnded:) name:SenTestCaseDidStopNotification object:nil];
    [center addObserver:self selector:@selector(testCaseFailed:) name:SenTestCaseDidFailNotification object:nil];
}

- (void) testSuiteStarted:(NSNotification*)notification
{
    SenTest* senTest = [notification test];
    [_storageDelegate testSuiteStarted:senTest];
}

- (void) testSuiteEnded:(NSNotification*)notification
{
    SenTest* senTest = [notification test];
    [_storageDelegate testSuiteEnded:senTest];
}

- (void) testCaseStarted:(NSNotification*)notification
{
    SenTest* senTest = [notification test];
    [_storageDelegate testCaseStarted:senTest];
}

- (void) testCaseEnded:(NSNotification*)notification
{
    SenTest* senTest = [notification test];
    [_storageDelegate testCaseEnded:senTest];
}

- (void) testCaseFailed:(NSNotification*)notification
{
    SenTest* senTest = [notification test];
    NSException* exception = [notification exception];
    [_storageDelegate testCaseFailed:senTest withException:exception];
}

@end
