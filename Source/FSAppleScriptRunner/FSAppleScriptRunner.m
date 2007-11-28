/* 
 * The Fadingred.org Shared Framework (FSFramework) is the legal property of its developers, whose names
 * are listed in the copyright file included with this source distribution.
 * 
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU
 * General Public License as published by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
 * Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

/*
 * This code is orinally from Adium.
 * Visit http://www.adiumx.com/ for more information.
 */

#import <Foundation/Foundation.h>

/*!
 * @brief Daemon to run applescripts, optionally with a function name and arguments, and respond over NSDistributedNotificationCenter
 */

//After SECONDS_INACTIVITY_BEFORE_AUTOMATIC_QUIT seconds without any activity, the daemon will quit itself
#define SECONDS_INACTIVITY_BEFORE_AUTOMATIC_QUIT 600 /* 10 minutes */

@interface AIApplescriptRunner : NSObject {}
- (void)applescriptRunnerIsReady;
- (void)resetAutomaticQuitTimer;
@end

@implementation AIApplescriptRunner
- (id)init
{
	if ((self = [super init])) {
		NSDistributedNotificationCenter *distributedNotificationCenter = [NSDistributedNotificationCenter defaultCenter];
		[distributedNotificationCenter addObserver:self
										  selector:@selector(respondIfReady:)
											  name:@"FSApplescriptRunner_RespondIfReady"
											object:nil];

		[distributedNotificationCenter addObserver:self
										  selector:@selector(executeScript:)
											  name:@"FSApplescriptRunner_ExecuteScript"
											object:nil];

		[distributedNotificationCenter addObserver:self
										  selector:@selector(quit:)
											  name:@"FSApplescriptRunner_Quit"
											object:nil];

		[self applescriptRunnerIsReady];
		
		[self resetAutomaticQuitTimer];
	}

	return self;
}

/*!
 * @brief Inform observers on the NSDistributedNotificationCenter that the applesript runner is ready
 */
- (void)applescriptRunnerIsReady
{
	//Check for an existing FSApplescriptRunner; if there is one, it will respond with FSApplescriptRunnerIsReady
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"FSApplescriptRunner_IsReady"
																   object:nil
																 userInfo:nil
													   deliverImmediately:NO];
}

/*!
 * @brief Observer method which responds to the @"FSApplescriptRunner_RespondIfReady" distributed notification
 *
 * This allows simple two-way communicatino from the host application to the daemon without setting up proxy or ports
 */
- (void)respondIfReady:(NSNotification *)inNotification
{
	[self applescriptRunnerIsReady];
}

/*!
 * @brief Execute an applescript
 *
 * @param inNotification An NSNotificatoin whose userInfo NSDictionary has @"funtion", @"arguments", @"path", and @"uniqueID" keys
 */
- (void)executeScript:(NSNotification *)inNotification
{
	NSAutoreleasePool		*pool = [[NSAutoreleasePool alloc] init];

	NSDictionary			*userInfo = [inNotification userInfo];

	NSAppleScript			*appleScript;
	NSAppleEventDescriptor	*thisApplication, *containerEvent;
	NSString				*functionName = [userInfo objectForKey:@"function"];
	NSArray					*scriptArgumentArray = [userInfo objectForKey:@"arguments"];
	NSURL					*pathURL = [NSURL fileURLWithPath:[userInfo objectForKey:@"path"]];
	NSString				*resultString = nil;
	
	appleScript = [[NSAppleScript alloc] initWithContentsOfURL:pathURL
														 error:NULL];
	
	if (appleScript) {
		if (functionName && [functionName length]) {
			/* If we have a functionName (and potentially arguments), we build
			* an NSAppleEvent to execute the script. */
			
			//Get a descriptor for ourself
			int pid = [[NSProcessInfo processInfo] processIdentifier];
			thisApplication = [NSAppleEventDescriptor descriptorWithDescriptorType:typeKernelProcessID
																			 bytes:&pid
																			length:sizeof(pid)];
			
			//Create the container event
			
			//We need these constants from the Carbon OpenScripting framework, but we don't actually need Carbon.framework...
#define kASAppleScriptSuite	'ascr'
#define kASSubroutineEvent	'psbr'
#define keyASSubroutineName 'snam'
			containerEvent = [NSAppleEventDescriptor appleEventWithEventClass:kASAppleScriptSuite
																	  eventID:kASSubroutineEvent
															 targetDescriptor:thisApplication
																	 returnID:kAutoGenerateReturnID
																transactionID:kAnyTransactionID];
			
			//Set the target function
			[containerEvent setParamDescriptor:[NSAppleEventDescriptor descriptorWithString:functionName]
									forKeyword:keyASSubroutineName];
			
			//Pass arguments - arguments is expecting an NSArray with only NSString objects
			if ([scriptArgumentArray count]) {
				NSAppleEventDescriptor  *arguments = [[NSAppleEventDescriptor alloc] initListDescriptor];
				NSEnumerator			*enumerator;
				NSString				*object;
				
				enumerator = [scriptArgumentArray objectEnumerator];
				while ((object = [enumerator nextObject])) {
					[arguments insertDescriptor:[NSAppleEventDescriptor descriptorWithString:object]
										atIndex:([arguments numberOfItems] + 1)]; //This +1 seems wrong... but it's not
				}

				[containerEvent setParamDescriptor:arguments forKeyword:keyDirectObject];
				[arguments release];
			}
			
			//Execute the event
			resultString = [[appleScript executeAppleEvent:containerEvent error:NULL] stringValue];
			
		} else {
			resultString = [[appleScript executeAndReturnError:NULL] stringValue];
		}
	}

	//Notify of the script's completion and the result
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"FSApplescript_DidRun"
																   object:nil
																 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
																	 [userInfo objectForKey:@"uniqueID"], @"uniqueID",
																	 (resultString ? resultString : @""), @"resultString",
																	 nil]
													   deliverImmediately:NO];
	[appleScript release];

	//Reset the automatic quit timer
	[self resetAutomaticQuitTimer];

	[pool release];
}

/*!
 * @brief Quit, notifying via the NSDistributedNotificationCenter that we're quitting
 */
- (void)quit:(NSNotification *)inNotification
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];

	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"FSApplescriptRunner_DidQuit"
																   object:nil
																 userInfo:nil
													   deliverImmediately:YES];

	[[NSDistributedNotificationCenter defaultCenter] removeObserver:self];

	exit(0);
}				

/*!
 * @brief Reset the automatic quit timer, which will exit this program after SECONDS_INACTIVITY_BEFORE_AUTOMATIC_QUIT
 */
- (void)resetAutomaticQuitTimer
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self
											 selector:@selector(quit:)
											   object:nil];
	[self performSelector:@selector(quit:)
			   withObject:nil
			   afterDelay:SECONDS_INACTIVITY_BEFORE_AUTOMATIC_QUIT];
}

@end

int main(int argc, const char *argv[])
{
    NSAutoreleasePool		*pool = [[NSAutoreleasePool alloc] init];
	AIApplescriptRunner		*applescriptRunner;
	
	applescriptRunner = [[AIApplescriptRunner alloc] init];

	[[NSRunLoop currentRunLoop] run];
	
	[applescriptRunner quit:nil];
	[applescriptRunner release];

	[pool release];
}
