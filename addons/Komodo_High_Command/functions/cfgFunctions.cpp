class CfgFunctions
{
	class  KMD
	{
		class init
		{
			file = "\Komodo_High_Command\functions\init";
			class initHighCommand {postInit = 1};
			class globalVariables {};
			class strImgVars      {};
			class classVars       {};
			class initMapDrawing  {};
		};

		class misc
		{
			file = "\Komodo_High_Command\functions\misc";
		};

		class rearmFnc
		{
			file = "\Komodo_High_Command\functions\rearmFnc";
			class rearm      {};
			class spawnRearm {};
		};

		class mapIconsFnc
		{
			file = "\Komodo_High_Command\functions\mapIconsFnc";
			class getGroupHealth             {};
			class drawGroupInfo              {};
			class markVics                   {};
			class convoyMarker               {};
			class deadVics                   {};
			class drawBuildingSearchMarker   {};
			class drawFollowMarker           {};
			class drawDefenceLine            {};
			class drawBoundingLine           {};
			class drawFollowMarkerOther      {};
			class drawFollowMarkerOtherSetup {};
			class drawLeftVehicles           {};
			class markTargetsOnMap           {};
			class drawKia                    {};
		};

		class groupFnc
		{
			file = "\Komodo_High_Command\functions\groupFnc";
			class splitHcGroup      {};
			class mergeHcGroup      {};
			class addToHc           {};
			class addToHcExecute    {};
			class removeFromHC      {};
			class spawnRemoveFromHC {};
			class createHcGroup     {};
		};

		class healFnc
		{
			file = "\Komodo_High_Command\functions\healFnc";
			class medicHeal       {};
			class healGroup       {};
			class spawnHealGroup  {};
			class wiaCallout      {};
			class bleedOut        {};
			class ccpReviveAction {};
			class ccp             {};
			class transferMedic   {};

		};

		class miscFnc
		{
			file = "\Komodo_High_Command\functions\miscFnc";
			class reset               {};
			class spawnReset          {};
			class execute             {};
			class spawnExecute        {};
			class hold                {};
			class spawnHold           {};
			class selectGroup         {};
			class remoteCameraIn      {};
			class remoteCameraOut     {};
			class spawnCam            {};
			class angleSwitcher       {};
			class watchDir            {};
			class spawnWatchDir       {};
			class setUnitPos          {};
			class spawnSetUnitPos     {};
			class holdFire            {};
			class openFire            {};
			class follow              {};
			class followOther         {};
			class march               {};
			class icons3D             {};
			class disableHcElements   {};
			class groupIconClickEh    {};
			class entityKilledEh      {};
			class vehicleGroupCheck   {};
		};

		class aiFnc
		{
			file = "\Komodo_High_Command\functions\aiFnc";
			class shareInfo            {};
			class getTargets           {};
			class getTargetsOpfor      {};
			class revealTargets        {};
			class revealTargetsOpfor   {};

			class shareInfoOpfor       {};
			class contactInfoShare     {};
			class contactReport        {};

			class playerReport         {};
			class enemyDestroyedReport {};
			class autoCrouch           {};
			class medicalSetup         {};
			class onDamage             {};
			class specialForceSkill    {};
			class setupAi              {};
			class vehicleSetup         {};

			class aiSetupLoop          {};
			class autoUnstuck          {};
			class resetGroup           {};
			class hardReset            {};
			class spawnHardReset       {};
			class chVehicleDir         {};
			class resetVehicle         {};

			class ammoBearer           {};

		};

		class sitrepFnc
		{
			file = "\Komodo_High_Command\functions\sitrepFnc";
			class groupHealthHex    {};
			class getAmmoGroupState {};
			class sitrepSolo        {};
			class sitrepMulti       {};
			class spawnSitrep       {};
		};

		class vehicleFnc
		{
			file = "\Komodo_High_Command\functions\vehicleFnc";
			class getInVehicle           {};
			class getOutVehicle          {};
			class spawnGetOutVehicle     {};
			class convoyPathFind         {};
			class doorAnimation          {};
			class airAssualtSecurity     {};
			class vehicleSpeedLimit      {};
			class spawnVicSpeed          {};
			class crewVehicle            {};
			class leaveVehicle           {};
			class spawnLeaveVehicle      {};
			class vicTransportSetup      {};
			class infTransportSetup      {};
			class initTransportAndEvents {};
		};

		class buildingFnc
		{
			file = "\Komodo_High_Command\functions\buildingFnc";
			class moveBuilding         {};
			class nearestPos           {};
			class clearBuilding        {};
			class guardBuilding        {};
			class moveToGarrison       {};
			class garrisonBuilding     {};
			class garrisonAreaBuilding {};
		};

		class attackFnc
		{
			file = "\Komodo_High_Command\functions\attackFnc";
			class advance                    {};
			class attack                     {};
			class spawnAdvance               {};
			class spawnAttack                {};
			class suppressiveFire            {};
			class spawnProximitySuppression  {};
			class spawnSuppression           {};
			class boundingSquad              {};
			class boundingMove               {};
			class sweepArea                  {};
		};

		class defenceFnc
		{
			file = "\Komodo_High_Command\functions\defenceFnc";
			class rush           {};
			class spawnRetreat   {};
			class moveTo360      {};
			class pl360          {};
			class atMapPos360    {};
			class spawn360       {};
			class findCover      {};
			class takeCover      {};
			class spawnTakeCover {};
			class defendPosition {};
		};

		class supportFnc
		{
			file = "\Komodo_High_Command\functions\supportFnc";
			class supportStatus   {};
			class cas             {};
			class arty            {};
			class fireMortar      {};
			class interdictionCas {};
			
		};

		class repairFnc
		{
			file = "\Komodo_High_Command\functions\repairFnc";
			class repKilledEh      {};
			class createNewVic     {};
			class crewEject        {};
			class setVicLoadOut    {};
			class repair           {};
			class maintenancePoint {};
		};

		class staticFnc
		{
			file = "\Komodo_High_Command\functions\staticFnc";
			class newBisUnpack {};
			class newBisPack   {};
		};

		class menusFnc
		{
			file = "\Komodo_High_Command\functions\menusFnc";
			class onMapMortar         {};
			class showFireSupportMenu {};
			class showCssMenu         {};
			class showCasMenu         {};
			class showArtyMenu        {};
			class showMortarMenu      {};
			class menuArrayVariables  {};
		}
	};
};