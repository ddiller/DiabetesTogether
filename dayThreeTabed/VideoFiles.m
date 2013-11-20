//
//  VideoFiles.m
//  MedAppJamApp
//
//  Created by App Jam on 11/18/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "VideoFiles.h"

@implementation VideoFiles


-(id)initWithURL:(NSString*)url withTitle:(NSString*)title asURL:(BOOL)isUrl
{
    _url = url;
    _title = title;
    _isItURL = isUrl;
    return self;
}
-(NSArray *)returnData
{
    return ([NSArray arrayWithObjects:_url, _title, nil]);
    
}
-(NSString*)getURL
{
    return _url;
}

-(NSString*)getTitle
{
    return _title;
}
-(Boolean)isURL
{
    return _isItURL;
}
@end
