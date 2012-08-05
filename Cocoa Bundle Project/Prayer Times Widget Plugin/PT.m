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

#import "PT.h"




@implementation PT

@synthesize version;

@synthesize Lat;
@synthesize Long;
@synthesize TimeZone;
@synthesize AsrMethod;
@synthesize CalcMethod;
@synthesize DhuhrMinutes;
@synthesize HighLatsMethod;

@synthesize CustomParam1FajrAngle;//aka FajrDegree
@synthesize CustomParam2MaghribSelector;
@synthesize CustomParam3MaghribParameter;
@synthesize CustomParam4IshaSelector;
@synthesize CustomParam5IshaParameter;//aka IshaDegree

@synthesize FajrTime;
@synthesize SunriseTime;
@synthesize DhuhrTime;
@synthesize AsrTime;
@synthesize SunsetTime;
@synthesize MaghribTime;
@synthesize IshaTime;

@synthesize Sound;
@synthesize Volume;
@synthesize IsJavaScriptPlaySound;

@synthesize FajrAdj;
@synthesize SunriseAdj;
@synthesize DhuhrAdj;
@synthesize AsrAdj;
@synthesize SunsetAdj;
@synthesize MaghribAdj;
@synthesize IshaAdj;


-(id)init
{
	self = [super init];
    
    [self rest];
    		
	return self;
}

-(id)initWithWebView:(WebView*)w {
	self = [self init];
	
	return self;
}

-(void)dealloc {
    [FajrTime dealloc];
    [SunriseTime dealloc];
    [DhuhrTime dealloc];
    [AsrTime dealloc];
    [SunsetTime dealloc];
    [MaghribTime dealloc];
    [IshaTime dealloc];
    
	[super dealloc];
}

//----------- Widgets Methods

-(void)windowScriptObjectAvailable:(WebScriptObject*)wso 
{
	[wso setValue:self forKey:@"PT"];
}

+(NSString*)webScriptNameForSelector:(SEL)aSel 
{
    //Getters
	if (aSel == @selector(Lat))
		return @"Lat";
    if (aSel == @selector(Long))
		return @"Long";
    if (aSel == @selector(TimeZone))
		return @"TimeZone";
    if (aSel == @selector(AsrMethod))
		return @"AsrMethod";
    if (aSel == @selector(CalcMethod))
		return @"CalcMethod";
    if (aSel == @selector(DhuhrMinutes))
		return @"DhuhrMinutes";
    if (aSel == @selector(HighLatsMethod))
		return @"HighLatsMethod";
    
    if (aSel == @selector(CustomParam1FajrAngle))
		return @"CustomParam1FajrAngle";
    if (aSel == @selector(CustomParam2MaghribSelector))
		return @"CustomParam2MaghribSelector";
    if (aSel == @selector(CustomParam3MaghribParameter))
		return @"CustomParam3MaghribParameter";
    if (aSel == @selector(CustomParam4IshaSelector))
		return @"CustomParam4IshaSelector";
    if (aSel == @selector(CustomParam5IshaParameter))
		return @"CustomParam5IshaParameter";
    
    if (aSel == @selector(FajrTime))
		return @"FajrTime";
    if (aSel == @selector(SunriseTime))
		return @"SunriseTime";
    if (aSel == @selector(DhuhrTime))
		return @"DhuhrTime";
    if (aSel == @selector(AsrTime))
		return @"AsrTime";
    if (aSel == @selector(SunsetTime))
		return @"SunsetTime";
    if (aSel == @selector(MaghribTime))
		return @"MaghribTime";
    if (aSel == @selector(IshaTime))
		return @"IshaTime";
    
    if (aSel == @selector(CityName))
		return @"CityName";
    if (aSel == @selector(Sound))
		return @"Sound";
    if (aSel == @selector(Volume))
		return @"Volume";
    if (aSel == @selector(IsJavaScriptPlaySound))
		return @"IsJavaScriptPlaySound";
    
    if (aSel == @selector(FajrAdj))
		return @"FajrAdj";
    if (aSel == @selector(SunriseAdj))
		return @"SunriseAdj";
    if (aSel == @selector(DhuhrAdj))
		return @"DhuhrAdj";
    if (aSel == @selector(AsrAdj))
		return @"AsrAdj";
    if (aSel == @selector(SunsetAdj))
		return @"SunsetAdj";
    if (aSel == @selector(MaghribAdj))
		return @"MaghribAdj";
    if (aSel == @selector(IshaAdj))
		return @"IshaAdj";

    
    
    //Setters
    if (aSel == @selector(setLat:))
		return @"setLat";
    if (aSel == @selector(setLong:))
		return @"setLong";
    if (aSel == @selector(setTimeZone:))
		return @"setTimeZone";
    if (aSel == @selector(setAsrMethod:))
		return @"setAsrMethod";
    if (aSel == @selector(setCalcMethod:))
		return @"setCalcMethod";
    if (aSel == @selector(setDhuhrMinutes:))
		return @"setDhuhrMinutes";
    if (aSel == @selector(setHighLatsMethod:))
		return @"setHighLatsMethod";
    
    if (aSel == @selector(setCustomParam1FajrAngle:))
		return @"setCustomParam1FajrAngle";
    if (aSel == @selector(setCustomParam2MaghribSelector:))
		return @"setCustomParam2MaghribSelector";
    if (aSel == @selector(setCustomParam3MaghribParameter:))
		return @"setCustomParam3MaghribParameter";
    if (aSel == @selector(setCustomParam4IshaSelector:))
		return @"setCustomParam4IshaSelector";
    if (aSel == @selector(setCustomParam5IshaParameter:))
		return @"setCustomParam5IshaParameter";
    
    if (aSel == @selector(setCityName:))
		return @"setCityName";
    if (aSel == @selector(setSound:))
		return @"setSound";
    if (aSel == @selector(setVolume:))
		return @"setVolume";
    if (aSel == @selector(setIsJavaScriptPlaySound:))
		return @"setIsJavaScriptPlaySound";
    
    if (aSel == @selector(setFajrAdj:))
		return @"setFajrAdj";
    if (aSel == @selector(setSunriseAdj:))
		return @"setSunriseAdj";
    if (aSel == @selector(setDhuhrAdj:))
		return @"setDhuhrAdj";
    if (aSel == @selector(setAsrAdj:))
		return @"setAsrAdj";
    if (aSel == @selector(setSunsetAdj:))
		return @"setSunsetAdj";
    if (aSel == @selector(setMaghribAdj:))
		return @"setMaghribAdj";
    if (aSel == @selector(setIshaAdj:))
		return @"setIshaAdj";
    
    if (aSel == @selector(test))
		return @"test";
    
    
    //Methods
    if (aSel == @selector(rest))
		return @"reset";
    if (aSel == @selector(createXML: setFolderPath:))
		return @"createXML";
	if (aSel == @selector(readFromXML: setFolderPath:))
		return @"readFromXML";
	if (aSel == @selector(writeToXML: setFolderPath:))
		return @"writeToXML";
    
    if (aSel == @selector(calculatePrayerTimes))
		return @"calculatePrayerTimes";
    if (aSel == @selector(nextPrayer))
		return @"nextPrayer";
	
	return nil;
}


+(BOOL)isSelectorExcludedFromWebScript:(SEL)aSel {	
	return NO;

}

+(BOOL)isKeyExcludedFromWebScript:(const char*)k {
	return NO;
}

//------

- (void) setLat1:(double) lat
{
    Lat = lat;
}

- (int) test
{
    return 101;
}

//------- Reset

- (void) rest
{
    Lat = -1;
    Long = -1;
    
    PrayTime* p = [[PrayTime alloc] init];
    TimeZone = [p getTimeZone];
    [p dealloc];
    
    AsrMethod = 0;
    CalcMethod = 3;
    DhuhrMinutes = 0;
    HighLatsMethod = 1;
    
    CustomParam1FajrAngle = -1;//aka FajrDegree
    CustomParam2MaghribSelector = 1;
    CustomParam3MaghribParameter = -1;
    CustomParam4IshaSelector = 0;
    CustomParam5IshaParameter = -1;//aka IshaDegree
    
    FajrTime = [Pray alloc];
    SunriseTime = [Pray alloc];
    DhuhrTime = [Pray alloc];
    AsrTime = [Pray alloc];
    SunsetTime = [Pray alloc];
    MaghribTime = [Pray alloc];
    IshaTime = [Pray alloc];
    
    CityName =  @"NOT SET YET";
    Sound = 1;
    Volume = 50;
    IsJavaScriptPlaySound = 1;
    
    FajrAdj = 0;
    SunriseAdj = 0;
    DhuhrAdj = 0;
    AsrAdj = 0;
    SunsetAdj = 0;
    MaghribAdj = 0;
    IshaAdj = 0;

}

//------ PrayerTimes Methods

- (void)createXML:(NSString*)fileName setFolderPath:(NSString*)folderPath
{
	NSString *filePath = [[folderPath stringByAppendingString:fileName] stringByExpandingTildeInPath];
	
	NSFileManager *fm = [[NSFileManager alloc] init];
	
	if (![fm fileExistsAtPath:[filePath stringByExpandingTildeInPath]])
	{
		[fm createDirectoryAtPath:[folderPath stringByExpandingTildeInPath] withIntermediateDirectories:TRUE attributes:NULL error:NULL];
		
		NSXMLElement *root = 
			(NSXMLElement *)[NSXMLNode elementWithName:@"Settings"]; 
		NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] initWithRootElement:root]; 
		[xmlDoc setVersion:@"1.0"]; 
		[xmlDoc setCharacterEncoding:@"UTF-8"];
        
        [root addChild:[NSXMLNode elementWithName:@"version" stringValue:[NSString stringWithFormat:@"%i",version]]];
        [root addChild:[NSXMLNode elementWithName:@"Lat" stringValue:[NSString stringWithFormat:@"%f",Lat]]];
		[root addChild:[NSXMLNode elementWithName:@"Long" stringValue:[NSString stringWithFormat:@"%f",Long]]];
		[root addChild:[NSXMLNode elementWithName:@"TimeZone" stringValue:[NSString stringWithFormat:@"%f",TimeZone]]];
        [root addChild:[NSXMLNode elementWithName:@"AsrMethod" stringValue:[NSString stringWithFormat:@"%i",AsrMethod]]];
		[root addChild:[NSXMLNode elementWithName:@"CalcMethod" stringValue:[NSString stringWithFormat:@"%i",CalcMethod]]];
        [root addChild:[NSXMLNode elementWithName:@"DhuhrMinutes" stringValue:[NSString stringWithFormat:@"%f",DhuhrMinutes]]];
		[root addChild:[NSXMLNode elementWithName:@"HighLatsMethod" stringValue:[NSString stringWithFormat:@"%i",HighLatsMethod]]];
        
        [root addChild:[NSXMLNode elementWithName:@"CustomParam1FajrAngle" stringValue:[NSString stringWithFormat:@"%f",CustomParam1FajrAngle]]];
        [root addChild:[NSXMLNode elementWithName:@"CustomParam2MaghribSelector" stringValue:[NSString stringWithFormat:@"%i",CustomParam2MaghribSelector]]];
        [root addChild:[NSXMLNode elementWithName:@"CustomParam3MaghribParameter" stringValue:[NSString stringWithFormat:@"%f",CustomParam3MaghribParameter]]];
        [root addChild:[NSXMLNode elementWithName:@"CustomParam4IshaSelector" stringValue:[NSString stringWithFormat:@"%i",CustomParam4IshaSelector]]];
        [root addChild:[NSXMLNode elementWithName:@"CustomParam5IshaParameter" stringValue:[NSString stringWithFormat:@"%f",CustomParam5IshaParameter]]];
        
        [root addChild:[NSXMLNode elementWithName:@"CityName" stringValue:CityName]];
        [root addChild:[NSXMLNode elementWithName:@"Sound" stringValue:[NSString stringWithFormat:@"%i",Sound]]];
		[root addChild:[NSXMLNode elementWithName:@"Volume" stringValue:[NSString stringWithFormat:@"%i",Volume]]];
		[root addChild:[NSXMLNode elementWithName:@"IsJavaScriptPlaySound" stringValue:[NSString stringWithFormat:@"%i",IsJavaScriptPlaySound]]];
        
        [root addChild:[NSXMLNode elementWithName:@"FajrAdj" stringValue:[NSString stringWithFormat:@"%i",FajrAdj]]];
        [root addChild:[NSXMLNode elementWithName:@"SunriseAdj" stringValue:[NSString stringWithFormat:@"%i",SunriseAdj]]];
        [root addChild:[NSXMLNode elementWithName:@"DhuhrAdj" stringValue:[NSString stringWithFormat:@"%i",DhuhrAdj]]];
        [root addChild:[NSXMLNode elementWithName:@"AsrAdj" stringValue:[NSString stringWithFormat:@"%i",AsrAdj]]];
        [root addChild:[NSXMLNode elementWithName:@"SunsetAdj" stringValue:[NSString stringWithFormat:@"%i",SunsetAdj]]];
        [root addChild:[NSXMLNode elementWithName:@"MaghribAdj" stringValue:[NSString stringWithFormat:@"%i",MaghribAdj]]];
        [root addChild:[NSXMLNode elementWithName:@"IshaAdj" stringValue:[NSString stringWithFormat:@"%i",IshaAdj]]];
        
		
		NSData *xmlData = [xmlDoc XMLDataWithOptions:NSXMLNodePrettyPrint]; 
		if (![xmlData writeToFile:filePath atomically:YES]) { 
			NSLog(@"Could not write document out..."); 
		}
        
        [xmlDoc dealloc];
        [fm dealloc];
	}
	
}

- (void)readFromXML:(NSString*)fileName setFolderPath:(NSString*)folderPath
{
	[self createXML:fileName setFolderPath:folderPath];
	
	NSString *filePath = [[folderPath stringByAppendingString:fileName] stringByExpandingTildeInPath];
	
	NSURL *furl = [NSURL fileURLWithPath:filePath];
	NSXMLDocument* readXML = [[NSXMLDocument alloc] initWithContentsOfURL:furl options:NSXMLDocumentTidyXML error:NULL];
	
	NSXMLElement *root = [readXML rootElement];
    
    version = [[[[root elementsForName:@"version"] objectAtIndex:0] stringValue] intValue];
    
	Lat = [[[[root elementsForName:@"Lat"] objectAtIndex:0] stringValue] doubleValue];
    Long = [[[[root elementsForName:@"Long"] objectAtIndex:0] stringValue] doubleValue];
    TimeZone = [[[[root elementsForName:@"TimeZone"] objectAtIndex:0] stringValue] doubleValue];
    AsrMethod = [[[[root elementsForName:@"AsrMethod"] objectAtIndex:0] stringValue] intValue];
    CalcMethod = [[[[root elementsForName:@"CalcMethod"] objectAtIndex:0] stringValue] intValue];
    DhuhrMinutes = [[[[root elementsForName:@"DhuhrMinutes"] objectAtIndex:0] stringValue] doubleValue];
    HighLatsMethod = [[[[root elementsForName:@"HighLatsMethod"] objectAtIndex:0] stringValue] intValue];
    
    CustomParam1FajrAngle = [[[[root elementsForName:@"CustomParam1FajrAngle"] objectAtIndex:0] stringValue] doubleValue];
    CustomParam2MaghribSelector = [[[[root elementsForName:@"CustomParam2MaghribSelector"] objectAtIndex:0] stringValue] intValue];
    CustomParam3MaghribParameter = [[[[root elementsForName:@"CustomParam3MaghribParameter"] objectAtIndex:0] stringValue] doubleValue];
    CustomParam4IshaSelector = [[[[root elementsForName:@"CustomParam4IshaSelector"] objectAtIndex:0] stringValue] intValue];
    CustomParam5IshaParameter = [[[[root elementsForName:@"CustomParam5IshaParameter"] objectAtIndex:0] stringValue] doubleValue];
        
    CityName = [[NSString alloc] initWithString:[[[root elementsForName:@"CityName"] objectAtIndex:0] stringValue]];
    
    Sound = [[[[root elementsForName:@"Sound"] objectAtIndex:0] stringValue] intValue];
    Volume = [[[[root elementsForName:@"Volume"] objectAtIndex:0] stringValue] intValue];
    IsJavaScriptPlaySound = [[[[root elementsForName:@"IsJavaScriptPlaySound"] objectAtIndex:0] stringValue] intValue];
    
    FajrAdj = [[[[root elementsForName:@"FajrAdj"] objectAtIndex:0] stringValue] intValue];
    SunriseAdj = [[[[root elementsForName:@"SunriseAdj"] objectAtIndex:0] stringValue] intValue];
    DhuhrAdj = [[[[root elementsForName:@"DhuhrAdj"] objectAtIndex:0] stringValue] intValue];
    AsrAdj = [[[[root elementsForName:@"AsrAdj"] objectAtIndex:0] stringValue] intValue];
    SunsetAdj = [[[[root elementsForName:@"SunsetAdj"] objectAtIndex:0] stringValue] intValue];
    MaghribAdj = [[[[root elementsForName:@"MaghribAdj"] objectAtIndex:0] stringValue] intValue];
    IshaAdj = [[[[root elementsForName:@"IshaAdj"] objectAtIndex:0] stringValue] intValue];
    
	
    [readXML dealloc];
    
	[self calculatePrayerTimes];
}

- (void)writeToXML:(NSString*)fileName setFolderPath:(NSString*)folderPath
{
	NSString *filePath = [[folderPath stringByAppendingString:fileName] stringByExpandingTildeInPath];
    
    NSFileManager* fm = [[NSFileManager alloc] init];
    
	[fm createDirectoryAtPath:[folderPath stringByExpandingTildeInPath] withIntermediateDirectories:TRUE attributes:NULL error:NULL];
	
	
	NSXMLElement *root = 
		(NSXMLElement *)[NSXMLNode elementWithName:@"Settings"]; 
	NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] initWithRootElement:root]; 
	[xmlDoc setVersion:@"1.0"]; 
	[xmlDoc setCharacterEncoding:@"UTF-8"];
    [root addChild:[NSXMLNode elementWithName:@"version" stringValue:[NSString stringWithFormat:@"%i",version]]];
    [root addChild:[NSXMLNode elementWithName:@"Lat" stringValue:[NSString stringWithFormat:@"%f",Lat]]];
    [root addChild:[NSXMLNode elementWithName:@"Long" stringValue:[NSString stringWithFormat:@"%f",Long]]];
    [root addChild:[NSXMLNode elementWithName:@"TimeZone" stringValue:[NSString stringWithFormat:@"%f",TimeZone]]];
    [root addChild:[NSXMLNode elementWithName:@"AsrMethod" stringValue:[NSString stringWithFormat:@"%i",AsrMethod]]];
    [root addChild:[NSXMLNode elementWithName:@"CalcMethod" stringValue:[NSString stringWithFormat:@"%i",CalcMethod]]];
    [root addChild:[NSXMLNode elementWithName:@"DhuhrMinutes" stringValue:[NSString stringWithFormat:@"%f",DhuhrMinutes]]];
    [root addChild:[NSXMLNode elementWithName:@"HighLatsMethod" stringValue:[NSString stringWithFormat:@"%i",HighLatsMethod]]];
    
    [root addChild:[NSXMLNode elementWithName:@"CustomParam1FajrAngle" stringValue:[NSString stringWithFormat:@"%f",CustomParam1FajrAngle]]];
    [root addChild:[NSXMLNode elementWithName:@"CustomParam2MaghribSelector" stringValue:[NSString stringWithFormat:@"%i",CustomParam2MaghribSelector]]];
    [root addChild:[NSXMLNode elementWithName:@"CustomParam3MaghribParameter" stringValue:[NSString stringWithFormat:@"%f",CustomParam3MaghribParameter]]];
    [root addChild:[NSXMLNode elementWithName:@"CustomParam4IshaSelector" stringValue:[NSString stringWithFormat:@"%i",CustomParam4IshaSelector]]];
    [root addChild:[NSXMLNode elementWithName:@"CustomParam5IshaParameter" stringValue:[NSString stringWithFormat:@"%f",CustomParam5IshaParameter]]];
    
    [root addChild:[NSXMLNode elementWithName:@"CityName" stringValue:CityName]];
    [root addChild:[NSXMLNode elementWithName:@"Sound" stringValue:[NSString stringWithFormat:@"%i",Sound]]];
    [root addChild:[NSXMLNode elementWithName:@"Volume" stringValue:[NSString stringWithFormat:@"%i",Volume]]];
    [root addChild:[NSXMLNode elementWithName:@"IsJavaScriptPlaySound" stringValue:[NSString stringWithFormat:@"%i",IsJavaScriptPlaySound]]];
    
    [root addChild:[NSXMLNode elementWithName:@"FajrAdj" stringValue:[NSString stringWithFormat:@"%i",FajrAdj]]];
    [root addChild:[NSXMLNode elementWithName:@"SunriseAdj" stringValue:[NSString stringWithFormat:@"%i",SunriseAdj]]];
    [root addChild:[NSXMLNode elementWithName:@"DhuhrAdj" stringValue:[NSString stringWithFormat:@"%i",DhuhrAdj]]];
    [root addChild:[NSXMLNode elementWithName:@"AsrAdj" stringValue:[NSString stringWithFormat:@"%i",AsrAdj]]];
    [root addChild:[NSXMLNode elementWithName:@"SunsetAdj" stringValue:[NSString stringWithFormat:@"%i",SunsetAdj]]];
    [root addChild:[NSXMLNode elementWithName:@"MaghribAdj" stringValue:[NSString stringWithFormat:@"%i",MaghribAdj]]];
    [root addChild:[NSXMLNode elementWithName:@"IshaAdj" stringValue:[NSString stringWithFormat:@"%i",IshaAdj]]];
	
	NSData *xmlData = [xmlDoc XMLDataWithOptions:NSXMLNodePrettyPrint]; 
	if (![xmlData writeToFile:filePath atomically:YES]) { 
		NSLog(@"Could not write document out...");
	}
    
    [xmlDoc dealloc];
    [fm dealloc];
}



- (void)calculatePrayerTimes
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy"];
    int year = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    int month = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"dd"];
    int day = [[formatter stringFromDate:date] intValue];

    PrayTime* PrayTimeMath = [[PrayTime alloc] init];
    
    [PrayTimeMath setAsrMethod:AsrMethod];
    [PrayTimeMath setCalcMethod:CalcMethod];
    [PrayTimeMath setDhuhrMinutes:DhuhrMinutes];
    [PrayTimeMath setHighLatsMethod:HighLatsMethod];
    
    NSMutableArray *customParams = [[[NSMutableArray alloc] init] autorelease];
    [customParams addObject:[NSNumber numberWithDouble:CustomParam1FajrAngle]];
    [customParams addObject:[NSNumber numberWithDouble:CustomParam2MaghribSelector]];
    [customParams addObject:[NSNumber numberWithDouble:CustomParam3MaghribParameter]];
    [customParams addObject:[NSNumber numberWithDouble:CustomParam4IshaSelector]];
    [customParams addObject:[NSNumber numberWithDouble:CustomParam5IshaParameter]];
    [PrayTimeMath setCustomParams:customParams];
        
    NSMutableArray* PTs = [PrayTimeMath getDatePrayerTimes:year andMonth:month andDay:day andLatitude:Lat andLongitude:Long andtimeZone:TimeZone];
    
    FajrTime = [[Pray alloc] initWith24HourFormateString:[PTs objectAtIndex:0] DaylightsavingOffset:[PrayTimeMath detectDaylightSaving] EnglishName:@"Fajr" ArabicName:@"فجر" Adj:FajrAdj];
    SunriseTime = [[Pray alloc] initWith24HourFormateString:[PTs objectAtIndex:1] DaylightsavingOffset:[PrayTimeMath detectDaylightSaving] EnglishName:@"Shuruq" ArabicName:@"الشروق" Adj:SunriseAdj];
    DhuhrTime = [[Pray alloc] initWith24HourFormateString:[PTs objectAtIndex:2] DaylightsavingOffset:[PrayTimeMath detectDaylightSaving] EnglishName:@"Dhuhr" ArabicName:@"الظهر" Adj:DhuhrAdj];
    AsrTime = [[Pray alloc] initWith24HourFormateString:[PTs objectAtIndex:3] DaylightsavingOffset:[PrayTimeMath detectDaylightSaving] EnglishName:@"Asr" ArabicName:@"العصر" Adj:AsrAdj];
    SunsetTime = [[Pray alloc] initWith24HourFormateString:[PTs objectAtIndex:4] DaylightsavingOffset:[PrayTimeMath detectDaylightSaving] EnglishName:@"Sunset" ArabicName:@"الغروب" Adj:SunsetAdj];
    MaghribTime = [[Pray alloc] initWith24HourFormateString:[PTs objectAtIndex:5] DaylightsavingOffset:[PrayTimeMath detectDaylightSaving] EnglishName:@"Maghrib" ArabicName:@"المغرب" Adj:MaghribAdj];
    IshaTime = [[Pray alloc] initWith24HourFormateString:[PTs objectAtIndex:6] DaylightsavingOffset:[PrayTimeMath detectDaylightSaving] EnglishName:@"Isha" ArabicName:@"العشاء" Adj:IshaAdj];
    
    [PrayTimeMath dealloc];
    
    // Just for test //
    NSLog(@"%@ 12Hr: %@ 24Hr %@",FajrTime.englishPrayName,FajrTime.time12formate,FajrTime.time24formate);
    NSLog(@"%@ 12Hr: %@ 24Hr %@",SunriseTime.englishPrayName,SunriseTime.time12formate,SunriseTime.time24formate);
    NSLog(@"%@ 12Hr: %@ 24Hr %@",DhuhrTime.englishPrayName,DhuhrTime.time12formate,DhuhrTime.time24formate);
    NSLog(@"%@ 12Hr: %@ 24Hr %@",AsrTime.englishPrayName,AsrTime.time12formate,AsrTime.time24formate);
    NSLog(@"%@ 12Hr: %@ 24Hr %@",SunsetTime.englishPrayName,SunsetTime.time12formate,SunsetTime.time24formate);
    NSLog(@"%@ 12Hr: %@ 24Hr %@",MaghribTime.englishPrayName,MaghribTime.time12formate,MaghribTime.time24formate);
    NSLog(@"%@ 12Hr: %@ 24Hr %@",IshaTime.englishPrayName,IshaTime.time12formate,IshaTime.time24formate);
}


- (Pray*)nextPrayer
{
    
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];    
    [formatter setDateFormat:@"HH"];
    double hr = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"mm"];
    double min = [[formatter stringFromDate:date] intValue];
	
    double timeNowInDouble = (double)hr + (double)min/60;
    
    if ( timeNowInDouble < FajrTime.timeInDouble )
	{
        FajrTime.remaining =  FajrTime.timeInDouble - timeNowInDouble;
		return FajrTime;
	}
    
    if ( timeNowInDouble < SunriseTime.timeInDouble )
	{
        SunriseTime.remaining =  SunriseTime.timeInDouble - timeNowInDouble;
		return SunriseTime;
	}
    
    if ( timeNowInDouble < DhuhrTime.timeInDouble )
	{
        DhuhrTime.remaining =  DhuhrTime.timeInDouble - timeNowInDouble;
		return DhuhrTime;
	}
    
    if ( timeNowInDouble < AsrTime.timeInDouble )
	{
        AsrTime.remaining =  AsrTime.timeInDouble - timeNowInDouble;
		return AsrTime;
	}
    
    if ( timeNowInDouble < MaghribTime.timeInDouble )
	{
        MaghribTime.remaining =  MaghribTime.timeInDouble - timeNowInDouble;
		return MaghribTime;
	}
    
    if ( timeNowInDouble < IshaTime.timeInDouble )
	{
        IshaTime.remaining =  IshaTime.timeInDouble - timeNowInDouble;
		return IshaTime;
	}
    
    FajrTime.remaining =  24 - timeNowInDouble + FajrTime.timeInDouble;
    return FajrTime;
    
}

-(NSString*)CityName {
    return CityName;
}

-(void)setCityName:(NSString *)City {
    CityName = [[NSString alloc] initWithString:City];
}

@end
