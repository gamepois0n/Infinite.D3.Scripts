SNOGroups = {}
--SNOGroups.StringList = Infinity.D3.SNOGroups.GetStringList()

function SNOGroups.DumpToFile(table, filename)
    local json = JSON:new()
    Infinity.FileSystem.WriteFile(filename, json:encode_pretty(table))
end

function SNOGroups.DumpStringList(file)
	local t = {}

	for k,v in pairs(SNOGroups.StringList) do
		table.insert(t, {Id = k, Text = v})
	end

	SNOGroups.DumpToFile(t, file)
end

