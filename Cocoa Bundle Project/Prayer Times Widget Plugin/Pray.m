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

#import "Pray.h"


@implementation Pray

@synthesize englishPrayName;
@synthesize arabicPrayName;
@synthesize hour;
@synthesize min;
@synthesize time12formate;
@synthesize time24formate;
@synthesize timeInDouble;
@synthesize remaining;


-(id)initWithWebView:(WebView*)w {
	self = [self init];
	
	return self;
}


-(void)windowScriptObjectAvailable:(WebScriptObject*)wso {
    //[wso setValue:self forKey:@"Pray"];
}

+(NSString*)webScriptNameForSelector:(SEL)aSel {
    //Getters
	if (aSel == @selector(englishPrayName))
		return @"englishPrayName";
    if (aSel == @selector(arabicPrayName))
		return @"arabicPrayName";
    if (aSel == @selector(hour))
		return @"hour";
    if (aSel == @selector(min))
		return @"min";
    if (aSel == @selector(time12formate))
		return @"time12formate";
    if (aSel == @selector(time24formate))
		return @"time24formate";
    if (aSel == @selector(timeInDouble))
		return @"timeInDouble";
    if (aSel == @selector(remaining))
		return @"remaining";
    
    //Setters
    if (aSel == @selector(setenglishPrayName:))
		return @"setenglishPrayName";
    if (aSel == @selector(setarabicPrayName:))
		return @"setarabicPrayName";
    if (aSel == @selector(sethour:))
		return @"sethour";
    if (aSel == @selector(setmin:))
		return @"setmin";
    if (aSel == @selector(settime12formate:))
		return @"settime12formate";
    if (aSel == @selector(settime24formate:))
		return @"settime24formate";
    if (aSel == @selector(settimeInDouble:))
		return @"settimeInDouble";
    if (aSel == @selector(setremaining:))
		return @"setremaining";
    
    if (aSel == @selector(test))
		return @"test";
    
    return nil;
}

+(BOOL)isSelectorExcludedFromWebScript:(SEL)aSel {	
	return NO;
}

+(BOOL)isKeyExcludedFromWebScript:(const char*)k {
	return NO;
}



-(id)initWith24HourFormateString:(NSString*)time DaylightsavingOffset:(double)daylightSavingOffset EnglishName:(NSString*)enName ArabicName:(NSString*)arName Adj:(int) adj;
{
    self = [super init];
    
    NSArray* hourAndMin = [time componentsSeparatedByString: @":"];
    NSString* hourString = [hourAndMin objectAtIndex:0];
    hour = [hourString intValue]+daylightSavingOffset;
    NSString* minString = [hourAndMin objectAtIndex:1];
    min = [minString intValue];
    
    if(adj>0)
    {
        min = [minString intValue]+adj;
        if(min>60)
        {
            hour++;
            min = min - 60;
            if(hour>24)
                hour = hour - 24;
        }
    }
    if(adj<0)
    {
        min = [minString intValue]+adj;
        if(min<0)
        {
            hour--;
            min = 60 + min;
            if(hour<0)
                hour = 24 + hour;
        }
    }
        
    timeInDouble = (double)hour + (double)min/60;
    time12formate = [self floatToTime12:timeInDouble andnoSuffix:true];
    time24formate = [self floatToTime24:timeInDouble];
    
    englishPrayName = enName;
    arabicPrayName = arName;
    
    remaining = 9999;
    
    return self;

}

-(id)initWithPrayObject:(Pray*) p
{
    self = [super init];
    
    englishPrayName = [[NSString alloc] initWithString:p.englishPrayName];
    arabicPrayName = [[NSString alloc] initWithString:p.arabicPrayName];
    
    hour = p.hour;
    min = p.min;
    
    time12formate =[[NSString alloc] initWithString:p.time12formate];
    time24formate =[[NSString alloc] initWithString:p.time24formate];
    
    timeInDouble = p.timeInDouble;
    
    remaining = p.remaining;
    
    return self;
}

-(id)init
{
    [super init];
    
    hour = 0;
    min = 0;
    time12formate = @"Object has not been initialized";
    time24formate = @"Object has not been initialized";
    timeInDouble = 0;
    
    return self;
}











/*
NOTICE: Bellow is copied from PrayTime.m by Hussain Ali Khan
 */

// range reduce hours to 0..23
-(double) fixhour: (double) a {
	a = a - 24.0 * floor(a / 24.0);
	a = a < 0 ? (a + 24) : a;
	return a;
}

// convert double hours to 24h format
-(NSString*)floatToTime24:(double)time {
	
	NSString *result = nil;
	
	if (isnan(time))
		return @"-----";
	
	time = [self fixhour:(time + 0.5/ 60.0)];  // add 0.5 minutes to round
	int hours = floor(time);
	double minutes = floor((time - hours) * 60.0);
	
	if((hours >=0 && hours<=9) && (minutes >=0 && minutes <=9)){
		result = [NSString stringWithFormat:@"0%d:0%.0f",hours, minutes];
	}
	else if((hours >=0 && hours<=9)){
		result = [NSString stringWithFormat:@"0%d:%.0f",hours, minutes];
	}
	else if((minutes >=0 && minutes <=9)){
		result = [NSString stringWithFormat:@"%d:0%.0f",hours, minutes];
	}
	else{
		result = [NSString stringWithFormat:@"%d:%.0f",hours, minutes];
	}
	return result;
}


// convert double hours to 12h format
-(NSString*)floatToTime12:(double)time andnoSuffix:(BOOL)noSuffix {
	
	if (isnan(time))
		return @"-----";
	
	time =[self fixhour:(time+ 0.5/ 60)];  // add 0.5 minutes to round
	double hours = floor(time); 
	double minutes = floor((time- hours)* 60);
	NSString *suffix, *result=nil;
	if(hours >= 12) {
		suffix = @"pm";
	}
	else{
		suffix = @"am";
	}
	//hours = ((((hours+ 12) -1) % (12))+ 1);
	hours = (hours + 12) - 1;
	int hrs = (int)hours % 12;
	hrs += 1;
	if(noSuffix == NO){
		if((hrs >=0 && hrs<=9) && (minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"0%d:0%.0f %@",hrs, minutes, suffix];
		}
		else if((hrs >=0 && hrs<=9)){
			result = [NSString stringWithFormat:@"0%d:%.0f %@",hrs, minutes, suffix];
		}
		else if((minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"%d:0%.0f %@",hrs, minutes, suffix];
		}
		else{
			result = [NSString stringWithFormat:@"%d:%.0f %@",hrs, minutes, suffix];
		}
		
	}
	else{
		if((hrs >=0 && hrs<=9) && (minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"0%d:0%.0f",hrs, minutes];
		}
		else if((hrs >=0 && hrs<=9)){
			result = [NSString stringWithFormat:@"0%d:%.0f",hrs, minutes];
		}
		else if((minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"%d:0%.0f",hrs, minutes];
		}
		else{
			result = [NSString stringWithFormat:@"%d:%.0f",hrs, minutes];
		}
	}
	return result;
	
}


-(void)dealloc {
    [super dealloc];
}


@end
