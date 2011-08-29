//
//  OCUnitListener.m
//  OCUnitToJUnit
//
//  Created by Zbigniew Kominek on 8/23/11.
//  Copyright 2011 zbyhoo. All rights reserved.
//

#import "OCUnitListener.h"
#import "DetailedSenTest.h"

#import <SenTestingKit/SenTest.h>

@interface OCUnitListener (Private)

- (DetailedSenTest*) getDetailedSenTest:(SenTest*)senTest;

@end

@implementation OCUnitListener

@synthesize storageDelegate = _storageDelegate;

- (id) init
{
    self = [super init];
    if (self) 
    {
        [self initializeNotificationListeners];
        _testDetails = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) dealloc
{
    [_testDetails release];
    _testDetails = nil;
    
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
    DetailedSenTest* senTest = [self getDetailedSenTest:[notification test]];
    [senTest startTimer];
    [_storageDelegate testSuiteStarted:senTest];
}

- (void) testSuiteEnded:(NSNotification*)notification
{
    DetailedSenTest* senTest = [self getDetailedSenTest:[notification test]];
    [senTest stopTimer];
    [_storageDelegate testSuiteEnded:senTest];
}

- (void) testCaseStarted:(NSNotification*)notification
{
    DetailedSenTest* senTest = [self getDetailedSenTest:[notification test]];
    [senTest startTimer];
    [_storageDelegate testCaseStarted:senTest];
}

- (void) testCaseEnded:(NSNotification*)notification
{
    DetailedSenTest* senTest = [self getDetailedSenTest:[notification test]];
    [senTest stopTimer];
    [_storageDelegate testCaseEnded:senTest];
}

- (void) testCaseFailed:(NSNotification*)notification
{
    DetailedSenTest* senTest = [self getDetailedSenTest:[notification test]];
    [senTest addFailure];
    NSException* exception = [notification exception];
    [_storageDelegate testCaseFailed:senTest withException:exception];
}

- (DetailedSenTest*) getDetailedSenTest:(SenTest*)senTest
{
    DetailedSenTest* detailedSenTest = [_testDetails objectForKey:senTest.name];
    if (detailedSenTest == nil)
    {
        detailedSenTest = [[DetailedSenTest alloc] initWithSenTest:senTest];
        [_testDetails setObject:detailedSenTest forKey:senTest.name];
    }
    return detailedSenTest;
}

@end
