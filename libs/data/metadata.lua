local metadata =
{
	plugin =
	{
		format = 'staticLibrary',
		staticLibs = { 'plugin_OneSignal', "objc" },
		frameworks = { 'WebKit', 'UserNotifications', "OneSignal" },
		frameworksOptional = {},
		delegates = {"OneSignalCoronaDelegate"}
	},
}

return metadata
