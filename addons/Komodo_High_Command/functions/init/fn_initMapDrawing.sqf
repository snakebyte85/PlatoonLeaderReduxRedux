isNil{// forced uncsheduled execution (14x faster)

    call KMD_fnc_drawGroupInfo;
    call KMD_fnc_markVics;
    call KMD_fnc_convoyMarker;
    call KMD_fnc_deadVics;
    call KMD_fnc_drawBuildingSearchMarker;
    call KMD_fnc_drawFollowMarker;
    call KMD_fnc_drawDefenceLine;
    call KMD_fnc_drawBoundingLine;
    call KMD_fnc_drawFollowMarkerOther;
    call KMD_fnc_drawFollowMarkerOtherSetup;
    call KMD_fnc_drawGroupsGettingIn;
};
