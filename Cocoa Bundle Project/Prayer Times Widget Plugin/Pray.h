/*
    Copyright 2007 - 2012 Mohammed Alrokayan
    http://alrokayan.com

    This file is part of Prayer Time Widget.

    Prayer Time Widget is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Prayer Time Widget is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Prayer Time Widget.  If not, see <http://www.gnu.org/licenses/>.
    
    Other licenses have beed used, please read README for more information.
*/

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface Pray : NSObject {
    NSString* englishPrayName;
    NSString* arabicPrayName;
    
    int hour;
    int min;
    
    NSString* time12formate;
    NSString* time24formate;
    
    double timeInDouble;
    
    double remaining;
}

-(id)initWith24HourFormateString:(NSString*)time DaylightsavingOffset:(double)daylightSavingOffset EnglishName:(NSString*)enName ArabicName:(NSString*)arName Adj:(int) adj;
-(id)initWithPrayObject:(Pray*) p;

@property (assign) NSString* englishPrayName;
@property (assign) NSString* arabicPrayName;
@property int hour;
@property int min;
@property (assign) NSString* time12formate;
@property (assign) NSString* time24formate;
@property double timeInDouble;
@property double remaining;

-(double) fixhour: (double) a;
-(NSString*)floatToTime12:(double)time andnoSuffix:(BOOL)noSuffix;

@end
