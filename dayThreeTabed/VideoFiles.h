//
//  VideoFiles.h
//  MedAppJamApp
//
//  Created by App Jam on 11/18/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoFiles : NSObject
@property (weak) NSString* url;
@property (weak) NSString* title;
@property (assign) bool isItURL;
-(id)initWithURL:(NSString*)url withTitle:(NSString*)title asURL:(BOOL)isUrl;
-(NSArray*)returnData;
-(NSString*)getURL;
-(NSString*)getTitle;
-(Boolean)isURL;
@end
