/*
 * Movement function for gdc_choppa, a script for AI piloted helicopter transport
 * makes the helicopter move to requested loaction
 * 
 * Parameters
 * NONE
 *
 * Return : nothing
*/
private ["_text","_veh","_group","_wp","_effect","_dir"];


if (((([] call acre_api_fnc_getCurrentRadioChannelNumber) == gdc_choppa_chan) AND (([([] call acre_api_fnc_getCurrentRadio)] call acre_api_fnc_getBaseRadio) == gdc_choppa_radio)) OR ((vehicle player) == gdc_choppa_helo)) then {
	hint "Ouvrez votre map et cliquez à l'endroit désiré pour désigner la LZ";

	player onMapSingleClick {
		hint "";
		player onMapSingleClick "";
		// Déplacement du marker et de l'hélipad
		"gdc_choppa_mk" setMarkerPosLocal _pos;
		"gdc_choppa_mk" setMarkerAlphaLocal 1;
		gdc_choppa_pad setpos _pos;
		
		// Suppression des Waypoints précédement ajoutés
		{
			deleteWaypoint _x;
		} forEach (waypoints (group gdc_choppa_helo));
		// interruption d'un éventuel atterissage en cours
		gdc_choppa_helo land "NONE";
		
		// Création des points de passage de l'hélico
		_wp = (group gdc_choppa_helo) addWaypoint [_pos,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "CARELESS";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointStatements ["true","gdc_choppa_helo land 'LAND';"];
	};
} else {
	// Si c'est le mauvais canal, afficher un texte.
	_text = getText (configFile >> "CfgWeapons" >> gdc_choppa_radio >> "displayName");
	_text = "Selectionner votre " + _text + " et réglez-la sur le canal " + (str gdc_choppa_chan) + " pour pouvoir contacter l'hélicoptère.";
	hint _text;
};





