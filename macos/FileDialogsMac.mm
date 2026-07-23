#include <utils/FileDialogs.h>

#import <Cocoa/Cocoa.h>


static NSString* stringFromUTF8(const std::string& value)
{
	if(value.empty())
		return nil;

	return [NSString stringWithUTF8String:value.c_str()];
}


static NSArray<NSString*>* allowedExtensions(const FileDialogs::Options& options)
{
	NSMutableArray<NSString*>* extensions = [NSMutableArray array];
	for(size_t i=0; i<options.file_types.size(); ++i)
	{
		NSString* extension = stringFromUTF8(options.file_types[i].extension);
		if(extension != nil && [extension length] > 0)
			[extensions addObject:extension];
	}
	return extensions;
}


static std::string pathFromURL(NSURL* url)
{
	if(url == nil)
		return "";

	const char* path = [url fileSystemRepresentation];
	return path == NULL ? std::string() : std::string(path);
}


std::string FileDialogs::showOpenFileDialog(const Options& options)
{
	@autoreleasepool
	{
		NSOpenPanel* panel = [NSOpenPanel openPanel];
		[panel setCanChooseFiles:YES];
		[panel setCanChooseDirectories:NO];
		[panel setAllowsMultipleSelection:NO];

		NSString* title = stringFromUTF8(options.dialog_title);
		if(title != nil)
			[panel setTitle:title];

		NSArray<NSString*>* extensions = allowedExtensions(options);
		if([extensions count] > 0)
			[panel setAllowedFileTypes:extensions];

		if([panel runModal] != NSModalResponseOK)
			return "";

		return pathFromURL([panel URL]);
	}
}


std::string FileDialogs::showSaveFileDialog(const Options& options)
{
	@autoreleasepool
	{
		NSSavePanel* panel = [NSSavePanel savePanel];
		[panel setCanCreateDirectories:YES];

		NSString* title = stringFromUTF8(options.dialog_title);
		if(title != nil)
			[panel setTitle:title];

		NSArray<NSString*>* extensions = allowedExtensions(options);
		if([extensions count] > 0)
		{
			[panel setAllowedFileTypes:extensions];
			[panel setAllowsOtherFileTypes:NO];
		}

		if([panel runModal] != NSModalResponseOK)
			return "";

		return pathFromURL([panel URL]);
	}
}
