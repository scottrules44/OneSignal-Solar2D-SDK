-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

print("CORONA: Start main.lua")

local json = require "json"
local composer = require "composer"
local OneSignal = require ("plugin.OneSignal")
local notifications = require( "plugin.notifications.v2" )


local launchArgs = ...

-- Set up notification options
local options = {
    alert = "Wake up!",
    badge = 2,
    custom = { foo = "bar" }
}

-- Schedule a notification to occur 60 seconds from now
local notification1 = notifications.scheduleNotification( 60, options )



-- Listen for notifications
local function onNotification( event )
    print( event.name )
    if ( event.custom ) then
        print( event.custom.foo )
    end
end
Runtime:addEventListener( "notification", onNotification )

-- The launch arguments provide a notification event if this app was started when the user tapped on a notification
-- In this case, you must call the notification listener manually
if ( launchArgs and launchArgs.notification ) then
    onNotification( launchArgs.notification )
end


-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- NOTIFICATION OPENED CALLBACK
-- This function gets called when the user opens a notification
function NotificationOpenedHandler(message, additionalData, isActive)
	-- Easy way to dump table to string, not necessary to access contents
	local additionalDataString = nil
	if (additionalData) then
		additionalDataString = json.encode( additionalData )
	end

	-- Print all of the handler params
	print("Corona Notification Opened!")
	print( additionalDataString )
end

-- IAM CLICK ACTION CALLBACK
-- This function gets called when the user clicks on an IAM element
function InAppMessagedClickHandler(actionTable)
	-- Print all of the handler params from the actionTable
	print("In App Message Clicked!" ..
	"\nClick Name: " .. tostring( actionTable['click_name'] ) ..
	"\nClick Url: " .. tostring( actionTable['click_url'] ) ..
	"\nFirst Click: " .. tostring( actionTable['first_click']) ..
	"\nCloses Message: " .. tostring( actionTable['closes_message']))
end

-- GET TRIGGER VALUE FOR KEY CALLBACK
-- After the trigger value for an trigger key is received it is provided here with the corresponding key
function GetTriggerValueForKeyHandler(key, value)
	-- Print the key, value pair from obtaining the trigger value
	print("Obtained Trigger Value for Key!" ..
	"\nTrigger Key, Value: " .. tostring(key) .. ", " .. tostring(value))
end

-- IAM PUBLIC METHODS
-- Example showcase of IAM methods for public usage in Corona
function ExampleInAppMessagingMethods()
	-- Toggle showing of IAMs for the device
	OneSignal.PauseInAppMessages(false)

	-- Adding a single trigger, value pair or several at a time with a table
	OneSignal.AddTrigger("trigger_1", "one")
	local triggerTable = { ["trigger_2"] = "two", ["trigger_3"] = "three", ["trigger_4"] = "four" }
	OneSignal.AddTriggers(triggerTable)

	-- Removing a single trigger by key or removing several at a time with a table
	OneSignal.RemoveTriggerForKey("trigger_4")
	local removeTriggers = {"trigger_1", "trigger_3"}
	OneSignal.RemoveTriggersForKeys(removeTriggers)

	-- Getting a trigger's value by key and returning the key, value in a callback
	OneSignal.GetTriggerValueForKey("trigger_2", GetTriggerValueForKeyHandler)
	OneSignal.GetTriggerValueForKey("trigger_3", GetTriggerValueForKeyHandler)
end

-- START OF LUA SCRIPT
OneSignal.Init("1abe37f9-6957-406d-82f6-60180397a71b", "714322744251", NotificationOpenedHandler)
OneSignal.SetInAppMessageClickHandler(InAppMessagedClickHandler)
OneSignal.RegisterForNotifications();
ExampleInAppMessagingMethods()

-- Go to view1 scene
composer.gotoScene( "view1" )
