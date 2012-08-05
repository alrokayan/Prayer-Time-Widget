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

function findLocation()
{
    document.getElementById("cityName").style.visibility = "hidden";
    document.getElementById("loader").style.visibility = "visible";
    
    var url = "http://www.geoplugin.net/javascript.gp";
    
    
    
    $.ajax({type: "POST"
          , url: "http://www.geoplugin.net/javascript.gp"
          , dataType: "script"
          , success: callback
    });
}


function callback()
{
    document.getElementById("cityName").innerHTML = geoplugin_city();
    document.getElementById("loader").style.visibility = "hidden";
    document.getElementById("cityName").style.visibility = "visible";
    
    readFile();
    
    PT.Lat = geoplugin_latitude();
    PT.Long = geoplugin_longitude();
    PT.CityName = document.getElementById("cityName").innerHTML;
    
    saveFile();
}