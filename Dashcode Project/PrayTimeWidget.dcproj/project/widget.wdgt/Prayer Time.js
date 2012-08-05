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

////////////////////////////////////////////////
//////////////Dashcode Functions////////////////
////////////////////////////////////////////////

function load()
{	
	setupParts();
    
    //set JPlayer settings
    $(function() {
        $("#jPlayer_holder").jPlayer( {
            ready: function () {
                $(this).jPlayer("setMedia", {
                    wav: "Macca1.wav"
                }); 
            },
            supplied: "wav"
        });
    });
    
	doInFront();
}

function remove()
{
	// your widget has just been removed from the layer
	// remove any preferences as needed
	// widget.setPreferenceForKey(null, createInstancePreferenceKey("your-key"));
}

function hide()
{
	// your widget has just been hidden stop any timers to
	// prevent cpu usage
}

function show()
{	
	// your widget has just been shown.  restart any timers
	// and adjust your interface as needed
    doInFront();
}

function showBack(event)
{
    readFile();
    alert(PT.version);
    if (PT.version == 0)
        PT.version = 2.0;
    
    saveFile();
    
	// your widget needs to show the back
	var front = document.getElementById("front");
	var back = document.getElementById("back");

	if (window.widget)
		widget.prepareForTransition("ToBack");

	front.style.display="none";
	back.style.display="block";
	
	if (window.widget)
		setTimeout('widget.performTransition();', 0);
	
    //set sound checkbox
	if (PT.Sound == 1)
		document.getElementById("AthanSoundCheckBox").checked = true;
	else
		document.getElementById("AthanSoundCheckBox").checked = false;
	
	//set Volume
	document.getElementById("slider").value = PT.Volume;
    
    //set City Name
    document.getElementById("cityName").innerHTML = PT.CityName;
    
    if(PT.CityName == "NOT SET YET")
        findLocation();
}

function showFront(event)
{
    
    //Check for new version
	checkNewVersion();    
	
    //Switch to front view
	var front = document.getElementById("front");
	var back = document.getElementById("back");

	if (window.widget)
		widget.prepareForTransition("ToFront");

	front.style.display="block";
	back.style.display="none";
	
	if (window.widget)
		setTimeout('widget.performTransition();', 0);
	
    //Do some stuff when switched to fromt
	doInFront();
}

if (window.widget)
{
	widget.onremove = remove;
	widget.onhide = hide;
	widget.onshow = show;
}


/*
* //////////////
* END OF SECTION
* //////////////
*/


/////////////////////////////////////////
///////////GLOBLE Varible////////////////
/////////////////////////////////////////
	
	var checkAthanFunctionIsInProgress = 1;
    var soundEnableChecked = 0;

////////////////////////////////////////////////
///////////Submit Back & doInFront/////////////
///////////////////////////////////////////////
//Do some stuff when switched to fromt
function doInFront()
{
    readFile();
	
	if (PT.version == 0 || PT.CityName == "NOT SET YET")
	{
		showBack();
	}
	else
	{
        //set Athan
        $("#jPlayer_holder").jPlayer("volume",PT.Volume/100);
        $("#jPlayer_holder").jPlayer("mute",!PT.Sound);
        
		//set City Name
		document.getElementById("PTPlace").innerHTML = PT.CityName;
		
		//set Prayer Times
		var FajrTime = PT.FajrTime;
		var SunriseTime = PT.SunriseTime;
		var DhuhrTime = PT.DhuhrTime;
		var AsrTime = PT.AsrTime;
		var SunsetTime = PT.SunsetTime;
		var MaghribTime = PT.MaghribTime;
        var IshaTime = PT.IshaTime;
        
		document.getElementById('FajrTime').innerHTML = get12H(FajrTime.hour) + " : " + formatTime(FajrTime.min);
		document.getElementById('ShTime').innerHTML= get12H(SunriseTime.hour) + " : " + formatTime(SunriseTime.min);
		document.getElementById('ZohrTime').innerHTML= get12H(DhuhrTime.hour) + " : " + formatTime(DhuhrTime.min);
		document.getElementById('AsrTime').innerHTML= get12H(AsrTime.hour) + " : " + formatTime(AsrTime.min);
		document.getElementById('MaghribTime').innerHTML= get12H(MaghribTime.hour) + " : " + formatTime(MaghribTime.min);
		document.getElementById('IshaTime').innerHTML= get12H(IshaTime.hour) + " : " + formatTime(IshaTime.min);
	
		
		//set Color to Next Prayer
        var next = PT.nextPrayer();
		
        document.getElementById("Fimg").style.visibility = "hidden";
        document.getElementById("Simg").style.visibility = "hidden";
        document.getElementById("Zimg").style.visibility = "hidden";
        document.getElementById("Aimg").style.visibility = "hidden";
        document.getElementById("Mimg").style.visibility = "hidden";
        document.getElementById("Iimg").style.visibility = "hidden";
    
        document.getElementById("FFimg").style.visibility = "hidden";
        document.getElementById("SSimg").style.visibility = "hidden";
        document.getElementById("ZZimg").style.visibility = "hidden";
        document.getElementById("AAimg").style.visibility = "hidden";
        document.getElementById("MMimg").style.visibility = "hidden";
        document.getElementById("IIimg").style.visibility = "hidden";
    
        if(next.englishPrayName == "Fajr")
        {
            document.getElementById("Fimg").style.visibility = "visible";
        }
        if(next.englishPrayName == "Shuruq")
	    {
	        document.getElementById("Simg").style.visibility = "visible";
	    }
	    if(next.englishPrayName == "Dhuhr")
	    {
	        document.getElementById("Zimg").style.visibility = "visible";
	    }
	    if(next.englishPrayName == "Asr")
	    {
	        document.getElementById("Aimg").style.visibility = "visible";
	    }
	    if(next.englishPrayName == "Maghrib")
	    {
	        document.getElementById("Mimg").style.visibility = "visible";
	    }
	    if(next.englishPrayName == "Isha")
	    {
	        document.getElementById("Iimg").style.visibility = "visible";
	    }
	    
	    var enableSound = PT.Sound;
		if(!soundEnableChecked && enableSound)
		{
			soundEnableChecked = 1;
			setTimeout("checkAthan();", 20*1000);//Check for athan every 20 sec
		}
	}
}


//Do some stuff when press "Done"
function submitBack()
{
	hideCredits()
	showFront();
}


/*
* //////////////
* END OF SECTION
* //////////////
*/


//////////////////////////////////////////////
////////////////File Handling/////////////////
//////////////////////////////////////////////
function saveFile()
{
    PT.writeToXML("PrayerTimeConfig.xml","~/Library/Application Support/PrayerTimeWidget/");
}

function readFile()
{
    PT.readFromXML("PrayerTimeConfig.xml","~/Library/Application Support/PrayerTimeWidget/");
}


/*
* //////////////
* END OF SECTION
* //////////////
*/


//////////////////////////////////////////////
////////////////Events Handling///////////////
//////////////////////////////////////////////
function changeAthanCheckBox()
{
    readFile();
    
    if (document.getElementById("AthanSoundCheckBox").checked)
		PT.Sound = 1;
	else
		PT.Sound = 0;
    
    $("#jPlayer_holder").jPlayer("mute",!PT.Sound);
    
    saveFile();
}

function changeAthanSlider()
{
    readFile();
    
	var SoundValue = document.getElementById("slider").value;
	PT.Volume = SoundValue;
    $("#jPlayer_holder").jPlayer("volume",PT.Volume/100);
    
    saveFile();
}

function resetButton() 
{
    PT.reset();
	saveFile();
    showBack();
    
}

function displayCredits()
{
    
	if (document.getElementById("credits").style.visibility == "visible")
        hideCredits();
	else	
		showCredits();
}

function openLink(event)
{
    if(event.currentTarget.id == "credits_alrokayan")
        widget.openURL("http://alrokayan.com")
    if(event.currentTarget.id == "credits_milyani")
        widget.openURL("http://milyani.com/")
    if(event.currentTarget.id == "credits_bander")
        widget.openURL("http://bandar.raffah.com/wp/")
}

/*
* //////////////
* END OF SECTION
* //////////////
*/


//////////////////////////////////////////////
////////////Athan Sound Handling//////////////
//////////////////////////////////////////////
function playAthanSound()
{
    document.getElementById("StopSoundBut").style.visibility = "visible";
    
    $("#jPlayer_holder").jPlayer("play");
       
    setTimeout("stopSound();",3.5*60*1000);
}


function checkAthan()
{    
	if(checkAthanFunctionIsInProgress)
	{
	    var nextPT = PT.nextPrayer();
	    
	    var nextPT_Remaining = nextPT.remaining.toFixed(2);
	    
	    var nextHr  = Math.floor(nextPT_Remaining);
	    var nextMin = Math.round((nextPT_Remaining - nextHr) * 100);
	    
	    //alert(nextPT_Remaining);
	    //alert(nextHr);
	    //alert(nextMin);
	    
	    if(nextPT.englishPrayName != "Shuruq")
	    {
	
	        if (nextMin <= 3 && nextHr == 0)
	        {	
	            setTimeout('playAthanSound()',nextMin*60*1000); //Play sound afer the number of mins 
	            checkAthanFunctionIsInProgress = 0;
	            return;
	        }
	        else
	        {
	            //check again util we are close to the prayer time
	            setTimeout("checkAthan();", 20*1000); //check every 20 Sec
	            return;
	        }
	    }
	}
    
}


function stopSound()
{
    $("#jPlayer_holder").jPlayer("stop");
	document.getElementById("StopSoundBut").style.visibility = 'hidden';
	
    setTimeout('checkAthanFunctionIsInProgress = 1;',3.5*60*1000); //Don't allow playing Athan after the user stoped the athan immediately
    
    doInFront();
	
}


/*
* //////////////
* END OF SECTION
* //////////////
*/


//////////////////////////////////////////////
/////////Credits Functions////////////////////
//////////////////////////////////////////////
function hideCredits()
{
    document.getElementById("credits_alrokayan").style.visibility = "hidden";
    document.getElementById("credits_milyani").style.visibility = "hidden";
    document.getElementById("credits_bander").style.visibility = "hidden";
    opacity('credits', 100, 0, 500);
}

function showCredits()
{
    document.getElementById("credits_alrokayan").style.visibility = "visible";
    document.getElementById("credits_milyani").style.visibility = "visible";
    document.getElementById("credits_bander").style.visibility = "visible";
    opacity('credits', 0, 100, 500);
}

function opacity(id, opacStart, opacEnd, millisec) {
	//speed for each frame
	var speed = Math.round(millisec / 100);
	var timer = 0;

	//determine the direction for the blending, if start and end are the same nothing happens
	if(opacStart > opacEnd) {
		for(i = opacStart; i >= opacEnd; i--) {
			setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
			timer++;
		}
	} else if(opacStart < opacEnd) {
		for(i = opacStart; i <= opacEnd; i++)
			{
			setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
			timer++;
		}
	}
}

//change the opacity for different browsers 
function changeOpac(opacity, id) { 
    var object = document.getElementById(id).style; 
    object.opacity = (opacity / 100); 
    object.MozOpacity = (opacity / 100); 
    object.KhtmlOpacity = (opacity / 100); 
    object.filter = "alpha(opacity=" + opacity + ")"; 
	if(opacity == 0)
		document.getElementById(id).style.visibility = "hidden";
	else
		document.getElementById(id).style.visibility = "visible";
}


/*
* //////////////
* END OF SECTION
* //////////////
*/


//////////////////////////////////////////////
//////////////Extra Functions/////////////////
//////////////////////////////////////////////
function get12H(H24)
{
	if (H24 > 12 )
		return formatTime(H24 - 12);
	return formatTime(H24);
}

function formatTime(num)
{
    return num<10?"0"+num:num;
}


function checkNewVersion()
{
	//TO Be IMPLMENTED
}

function displayToolTip(my) 
{
    var nextPT = PT.nextPrayer();
	    
    var nextPT_Remaining = nextPT.remaining.toFixed(2);
	    
    var nextHr  = Math.floor(nextPT_Remaining);
    var nextMin = Math.round((nextPT_Remaining - nextHr) * 100);
        
	my.title = nextHr + ":" + nextMin + " to " + nextPT.englishPrayName + " Prayer";
}


function installAdvancePreferances()
{
    widget.system('open "Prayer Times Widget Advance Setting.prefPane"', null);
}



/*
* //////////////
* END OF SECTION
* //////////////
*/
