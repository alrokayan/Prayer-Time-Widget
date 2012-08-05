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


#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#include "Pray.h"
#include "PrayTime.h"

@interface PT : NSObject {
    
    int version;
    
	double Lat;
    double Long;
    double TimeZone;
    int AsrMethod;
    int CalcMethod;
    double DhuhrMinutes;
    int HighLatsMethod;
    
    double CustomParam1FajrAngle;//aka FajrDegree
    int CustomParam2MaghribSelector;
    double CustomParam3MaghribParameter;
    int CustomParam4IshaSelector;
    double CustomParam5IshaParameter;//aka IshaDegree
    
    Pray* FajrTime;
    Pray* SunriseTime;
    Pray* DhuhrTime;
    Pray* AsrTime;
    Pray* SunsetTime;
    Pray* MaghribTime;
    Pray* IshaTime;
    
    NSString* CityName;
    int Sound;
    int Volume;
    int IsJavaScriptPlaySound;
    
    int FajrAdj;
    int SunriseAdj;
    int DhuhrAdj;
    int AsrAdj;
    int SunsetAdj;
    int MaghribAdj;
    int IshaAdj;

}

- (void)rest;
- (void)createXML:(NSString*)fileName setFolderPath:(NSString*)folderPath;
- (void)readFromXML:(NSString*)vFileName setFolderPath:(NSString*)vFolderPath;
- (void)writeToXML:(NSString*)vFileName setFolderPath:(NSString*)vFolderPath;

@property int version;

@property double Lat;
@property double Long;
@property double TimeZone;
@property int AsrMethod;
@property int CalcMethod;
@property double DhuhrMinutes;
@property int HighLatsMethod;

@property double CustomParam1FajrAngle;//aka FajrDegree
@property int CustomParam2MaghribSelector;
@property double CustomParam3MaghribParameter;
@property int CustomParam4IshaSelector;
@property double CustomParam5IshaParameter;//aka IshaDegree

@property (assign) Pray* FajrTime;
@property (assign) Pray* SunriseTime;
@property (assign) Pray* DhuhrTime;
@property (assign) Pray* AsrTime;
@property (assign) Pray* SunsetTime;
@property (assign) Pray* MaghribTime;
@property (assign) Pray* IshaTime;

@property int Sound;
@property int Volume;
@property int IsJavaScriptPlaySound;

@property int FajrAdj;
@property int SunriseAdj;
@property int DhuhrAdj;
@property int AsrAdj;
@property int SunsetAdj;
@property int MaghribAdj;
@property int IshaAdj;


-(NSString*)CityName;
-(void)setCityName:(NSString *)City;

// Calculation Methods
typedef enum CalculationMethod {
    Jafari     = 0,    // Ithna Ashari
    Karachi    = 1,    // University of Islamic Sciences, Karachi
    ISNA       = 2,    // Islamic Society of North America (ISNA)
    MWL        = 3,    // Muslim World League (MWL)
    Makkah     = 4,    // Umm al-Qura, Makkah
    Egypt      = 5,    // Egyptian General Authority of Survey
    Custom     = 7,    // Custom Setting
    Tehran     = 6     // Institute of Geophysics, University of Tehran
    
} CalculationMethod;

// Juristic Methods
typedef enum AsrCalculationMethod {
    Shafii     = 0,    // Shafii (standard)
    Hanafi     = 1     // Hanafi
    
} AsrCalculationMethod;

// Adjusting Methods for Higher Latitudes
typedef enum AdjustingMethodsForHigherLatitudes {
    None       = 0,    // No adjustment
    MidNight   = 1,    // middle of night (defult)
    OneSeventh = 2,    // 1/7th of night
    AngleBased = 3     // angle/60th of night
    
} AdjustingMethodsForHigherLatitudes;


- (void)calculatePrayerTimes;
- (Pray*)nextPrayer;

- (int) test;

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector;
+ (BOOL)isKeyExcludedFromWebScript:(const char *)name;

@end
