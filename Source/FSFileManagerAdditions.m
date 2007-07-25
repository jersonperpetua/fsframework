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

#import "FSFileManagerAdditions.h"

@implementation NSFileManager (FSFileManagerAdditions)

+ (NSString *)safePathComponent:(NSString *)string {
	NSMutableString *replace = [NSMutableString stringWithString:string];
	[replace replaceOccurrencesOfString:@"/" withString:@":" options:0 range:NSMakeRange(0, [replace length])];
	[replace replaceOccurrencesOfString:@"." withString:@"_" options:0 range:NSMakeRange(0, 1)];
	return [NSString stringWithString:replace];
}

- (BOOL)createDirectoryAtPath:(NSString *)path attributes:(NSDictionary *)attributes checkExists:(BOOL)check {	
	BOOL exists = FALSE;
	if (check) {
		exists = [self fileExistsAtPath:path isDirectory:&exists] && exists;
	}
	if (!exists) { return [self createDirectoryAtPath:path attributes:attributes]; }
	else { return TRUE; }
}

- (BOOL)trashFileAtPath:(NSString *)sourcePath {
    NSParameterAssert(sourcePath != nil && [sourcePath length] != 0);
	if ([self fileExistsAtPath:sourcePath]) {
        [[NSWorkspace sharedWorkspace] performFileOperation:NSWorkspaceRecycleOperation
                                                     source:[sourcePath stringByDeletingLastPathComponent]
                                                destination:@""
                                                      files:[NSArray arrayWithObject:[sourcePath lastPathComponent]]
                                                        tag:NULL];
	}
	return TRUE;
}

- (NSString *)uniquePathForPath:(NSString *)path {
	NSString *uniquePath = path;
	NSString *basePath = nil;
	NSString *extension = nil;
	unsigned appendNumber = 0;
	
	while ([self fileExistsAtPath:uniquePath] && ++appendNumber) {
		if (!basePath) {
			basePath = [path stringByDeletingPathExtension];
			extension = [path pathExtension];
			if (![extension length]) extension = nil; // If there's no extension, pathExtension returns @""
		}		
		uniquePath = [NSString stringWithFormat:@"%@ %i", basePath, appendNumber];
		if (extension) { uniquePath = [uniquePath stringByAppendingPathExtension:extension]; }
	}
	
	return uniquePath;
}

@end
