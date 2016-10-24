--------------------------------
-------WantedList Script
--------------------------------
addhook("die", "died")
addhook("leave", "left")
addhook("name", "name")
addhook("startround", "roundrestart")
-- Config ['cant touch this]
max_kills = 0
b = {}
c = {}

if(f1 ~= 1) then
	a = {} 
	for i = 1, 32, 1 do
		a[i] = 0
	end
	f1 = 1
	wantedHUDID = 34
end
--parse("hudtxt "..wantedHUDID.." \"©255255255Wanted:\" 20 130")


function wantedDisplay()
	if wantedD then
		parse("hudtxt "..wantedHUDID.." \"©255255255Wanted:\" 20 130")
	else
		parse("hudtxt "..wantedHUDID.." \"©255255255\" 20 130")
	end
	--Clear
	wantedNum = 1
	for j = 2, 32, 1 do
		num = 0
		parse('hudtxt '..'"'..j..' " "" 20 '..'"'..num..'"')
	end
	--Updating the wanted list
	for k = 1, #a, 1 do
		b[k] = a[k]
	end
	c = sortPlayers(a)
	for j = 1, #c, 1 do
		if(a[tonumber(c[j])] > 0 and player(tonumber(c[j]), "health") > 0) then
			wantedNum = wantedNum + 1
			height = 115 + (wantedNum * 15)
			parse('hudtxt '..'"'..wantedNum..' "'..'"'..wantedLevel_color(tonumber(c[j]))..player(tonumber(c[j]), "name")..'"'..' 20 '..'"'..height..'"')
		end
	end
end

function died(victim, killer)
	
	if player(victim, 'exists') then
		if player(victim, 'team') == 1 then
			a[victim] = 0
		else
			if player(killer, 'team') == 1 then 
				wantedD = true
				a[killer] = a[killer] + 1
			end
		end
	end
	wantedDisplay()
end

function left(id)
	--Removing the people who leave from the wanted list
	a[id] = 0
	wantedDisplay()
end

function name()
	wantedDisplay()
end

function roundrestart()
	wantedD = false
	for i = 1, 32 do
		a[i] = 0
	end
	wantedDisplay()
end

function wantedLevel_color(id)
	if a[id] == nil then return '\169224224224' end
	if a[id] == 2 then return '\169248244000' end
	if a[id] == 3 then return '\169255153000' end
	if a[id] > 3 then return '\169255000000' end
	return '\169224224224'
end

function sortPlayers(a_array)
	for p = 1 , #b do
		maximum_id = findMax(b)
		c[p] = maximum_id
	end
	return c
end

function findMax(array)
	local flag = 0
	for id ,kills in pairs(array) do
		if (tonumber(max_kills) < tonumber(kills)) then 
			max_id = id
			max_kills = kills
			flag = 1
		end
	end
	if flag == 1 then 
		array[max_id] = -999
		max_kills = -1
	end
	return max_id
end
