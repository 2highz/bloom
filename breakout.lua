
local module = {};
local players = game["GetService"](game, "Players");
local player = players["LocalPlayer"];
local getinfo = getgenv()["debug"] and getgenv()["debug"]["getinfo"] or getgenv()["getinfo"];
local breakout;
for i, v in getgenv()["getgc"]() do
	if getinfo(v).name == "AttemptBreakout" then
		breakout = v;
		break;
	end;
end;
module.request_function = function (a, b)
	breakout(player, a, b);
end;
return module
--perma ban--
