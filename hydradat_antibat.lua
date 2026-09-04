--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

repeat
	task.wait();
until game:IsLoaded() 
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local LocalPlayer = Players.LocalPlayer;
local CONFIG_FILE = "hydradat_AntiBat_Config.json";
local AntiBatEnabled = false;
local InfiniteJumpEnabled = false;
local InfiniteJumpHoldEnabled = false;
local IsJumpingHold = false;
local CurrentKeybind = Enum.KeyCode.N;
local WaitingForKeybind = false;
local isMobileMode = true;
local CurrentBG = "rbxassetid://1893323185";
local AntiBatConn = nil;
local AntiRagdollConn = nil;
local JumpHoldConn = nil;
local function saveConfig()
	local FlatIdent_95CAC = 0;
	local data;
	while true do
		if (FlatIdent_95CAC == 0) then
			data = {Keybind=CurrentKeybind.Name,Background=CurrentBG,MobileMode=isMobileMode};
			pcall(function()
				writefile(CONFIG_FILE, HttpService:JSONEncode(data));
			end);
			break;
		end
	end
end
local function loadConfig()
	local success, result = pcall(function()
		if isfile(CONFIG_FILE) then
			return HttpService:JSONEncode(readfile(CONFIG_FILE));
		end
	end);
	if (success and result) then
		local FlatIdent_76979 = 0;
		while true do
			if (FlatIdent_76979 == 1) then
				if (result.MobileMode ~= nil) then
					isMobileMode = result.MobileMode;
				end
				break;
			end
			if (FlatIdent_76979 == 0) then
				if (result.Keybind and Enum.KeyCode[result.Keybind]) then
					CurrentKeybind = Enum.KeyCode[result.Keybind];
				end
				if result.Background then
					CurrentBG = result.Background;
				end
				FlatIdent_76979 = 1;
			end
		end
	end
end
loadConfig();
local function startAntiBat()
	local FlatIdent_24A02 = 0;
	local char;
	local root;
	while true do
		if (FlatIdent_24A02 == 1) then
			root = char:FindFirstChild("HumanoidRootPart");
			if not root then
				return;
			end
			FlatIdent_24A02 = 2;
		end
		if (FlatIdent_24A02 == 0) then
			char = LocalPlayer.Character;
			if not char then
				return;
			end
			FlatIdent_24A02 = 1;
		end
		if (FlatIdent_24A02 == 2) then
			if AntiBatConn then
				AntiBatConn:Disconnect();
			end
			AntiBatConn = RunService.Heartbeat:Connect(function()
				local FlatIdent_8D83D = 0;
				local origXZ;
				while true do
					if (FlatIdent_8D83D == 0) then
						if (not root or not root.Parent) then
							return;
						end
						origXZ = Vector3.new(root.Velocity.X, 0, root.Velocity.Z);
						FlatIdent_8D83D = 1;
					end
					if (FlatIdent_8D83D == 2) then
						root.Velocity = Vector3.new(origXZ.X, root.Velocity.Y, origXZ.Z);
						break;
					end
					if (FlatIdent_8D83D == 1) then
						root.Velocity = Vector3.new(1000, root.Velocity.Y, 1000);
						RunService.RenderStepped:Wait();
						FlatIdent_8D83D = 2;
					end
				end
			end);
			break;
		end
	end
end
local function stopAntiBat()
	if AntiBatConn then
		local FlatIdent_8199B = 0;
		while true do
			if (FlatIdent_8199B == 0) then
				AntiBatConn:Disconnect();
				AntiBatConn = nil;
				break;
			end
		end
	end
end
local function startJumpHoldLoop()
	if JumpHoldConn then
		JumpHoldConn:Disconnect();
	end
	JumpHoldConn = RunService.Heartbeat:Connect(function()
		local FlatIdent_39B0 = 0;
		local char;
		local root;
		while true do
			if (FlatIdent_39B0 == 2) then
				if root then
					root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z);
				end
				break;
			end
			if (FlatIdent_39B0 == 0) then
				if (not InfiniteJumpHoldEnabled or not IsJumpingHold) then
					return;
				end
				char = LocalPlayer.Character;
				FlatIdent_39B0 = 1;
			end
			if (FlatIdent_39B0 == 1) then
				if not char then
					return;
				end
				root = char:FindFirstChild("HumanoidRootPart");
				FlatIdent_39B0 = 2;
			end
		end
	end);
end
UserInputService.InputBegan:Connect(function(input, gp)
	local FlatIdent_51F42 = 0;
	while true do
		if (FlatIdent_51F42 == 0) then
			if gp then
				return;
			end
			if ((input.KeyCode == Enum.KeyCode.Space) or (input.UserInputType == Enum.UserInputType.Touch)) then
				IsJumpingHold = true;
			end
			break;
		end
	end
end);
UserInputService.InputEnded:Connect(function(input)
	if ((input.KeyCode == Enum.KeyCode.Space) or (input.UserInputType == Enum.UserInputType.Touch)) then
		IsJumpingHold = false;
	end
end);
UserInputService.JumpRequest:Connect(function()
	local FlatIdent_1BCFB = 0;
	local char;
	local root;
	while true do
		if (FlatIdent_1BCFB == 1) then
			if not char then
				return;
			end
			root = char:FindFirstChild("HumanoidRootPart");
			FlatIdent_1BCFB = 2;
		end
		if (2 == FlatIdent_1BCFB) then
			if root then
				root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z);
			end
			break;
		end
		if (FlatIdent_1BCFB == 0) then
			if not InfiniteJumpEnabled then
				return;
			end
			char = LocalPlayer.Character;
			FlatIdent_1BCFB = 1;
		end
	end
end);
local function startAntiRagdoll()
	local FlatIdent_6053C = 0;
	while true do
		if (FlatIdent_6053C == 0) then
			if AntiRagdollConn then
				return;
			end
			AntiRagdollConn = RunService.Heartbeat:Connect(function()
				local FlatIdent_8F59B = 0;
				local char;
				local hum2;
				local root;
				while true do
					if (FlatIdent_8F59B == 1) then
						hum2 = char:FindFirstChildOfClass("Humanoid");
						root = char:FindFirstChild("HumanoidRootPart");
						FlatIdent_8F59B = 2;
					end
					if (FlatIdent_8F59B == 0) then
						char = LocalPlayer.Character;
						if not char then
							return;
						end
						FlatIdent_8F59B = 1;
					end
					if (FlatIdent_8F59B == 2) then
						if hum2 then
							local st = hum2:GetState();
							if ((st == Enum.HumanoidStateType.Physics) or (st == Enum.HumanoidStateType.Ragdoll) or (st == Enum.HumanoidStateType.FallingDown)) then
								local FlatIdent_7A75F = 0;
								while true do
									if (FlatIdent_7A75F == 1) then
										pcall(function()
											local FlatIdent_E0D0 = 0;
											local pm;
											while true do
												if (FlatIdent_E0D0 == 0) then
													pm = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");
													if pm then
														require(pm:FindFirstChild("ControlModule")):Enable();
													end
													break;
												end
											end
										end);
										if root then
											local FlatIdent_8DCA9 = 0;
											while true do
												if (FlatIdent_8DCA9 == 0) then
													root.Velocity = Vector3.new(0, 0, 0);
													root.RotVelocity = Vector3.new(0, 0, 0);
													break;
												end
											end
										end
										break;
									end
									if (FlatIdent_7A75F == 0) then
										hum2:ChangeState(Enum.HumanoidStateType.Running);
										workspace.CurrentCamera.CameraSubject = hum2;
										FlatIdent_7A75F = 1;
									end
								end
							end
						end
						for _, obj in ipairs(char:GetDescendants()) do
							if (obj:IsA("Motor6D") and not obj.Enabled) then
								obj.Enabled = true;
							end
						end
						break;
					end
				end
			end);
			break;
		end
	end
end
LocalPlayer.CharacterAdded:Connect(function()
	local FlatIdent_39EBF = 0;
	while true do
		if (FlatIdent_39EBF == 0) then
			task.wait(0.3);
			if AntiBatEnabled then
				startAntiBat();
			end
			FlatIdent_39EBF = 1;
		end
		if (1 == FlatIdent_39EBF) then
			task.wait(0.5);
			startAntiRagdoll();
			break;
		end
	end
end);
local hydradat_anti_bat = Instance.new("ScreenGui");
hydradat_anti_bat.Name = "hydradat anti bat";
hydradat_anti_bat.ResetOnSpawn = false;
hydradat_anti_bat.DisplayOrder = 10;
hydradat_anti_bat.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
hydradat_anti_bat.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Main = Instance.new("Frame");
Main.Name = "Main";
Main.Active = true;
Main.ClipsDescendants = true;
Main.Position = UDim2.new(0.5, -115, 0.5, -72);
Main.Size = UDim2.new(0, 230, 0, 145);
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12);
Main.BorderSizePixel = 0;
Main.Parent = hydradat_anti_bat;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0, 12);
UICorner.Parent = Main;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3.fromRGB(110, 110, 120);
UIStroke.Thickness = 1.5;
UIStroke.Transparency = 0.25;
UIStroke.Parent = Main;
local SpaceBackground = Instance.new("ImageLabel");
SpaceBackground.Name = "SpaceBackground";
SpaceBackground.ZIndex = 0;
SpaceBackground.Size = UDim2.new(1, 0, 1, 0);
SpaceBackground.BackgroundTransparency = 1;
SpaceBackground.Image = CurrentBG;
SpaceBackground.ScaleType = Enum.ScaleType.Crop;
SpaceBackground.Parent = Main;
local UICorner2 = Instance.new("UICorner");
UICorner2.CornerRadius = UDim.new(0, 12);
UICorner2.Parent = SpaceBackground;
local Header = Instance.new("Frame");
Header.Name = "Header";
Header.Active = true;
Header.ZIndex = 2;
Header.Size = UDim2.new(1, 0, 0, 40);
Header.BackgroundTransparency = 1;
Header.Parent = Main;
local Frame = Instance.new("Frame");
Frame.Size = UDim2.new(1, 0, 1, 0);
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 12);
Frame.BackgroundTransparency = 0.35;
Frame.BorderSizePixel = 0;
Frame.Parent = Header;
local UICorner4 = Instance.new("UICorner");
UICorner4.CornerRadius = UDim.new(0, 12);
UICorner4.Parent = Frame;
local Title = Instance.new("TextLabel");
Title.Name = "Title";
Title.ZIndex = 3;
Title.Position = UDim2.new(0, 10, 0, 0);
Title.Size = UDim2.new(1, -100, 1, 0);
Title.BackgroundTransparency = 1;
Title.Text = "SPACE X HOOK ANTI BAT";
Title.TextColor3 = Color3.fromRGB(240, 240, 240);
Title.TextSize = 11;
Title.TextScaled = true;
Title.Font = Enum.Font.LuckiestGuy;
Title.TextXAlignment = Enum.TextXAlignment.Left;
Title.TextWrapped = true;
Title.Parent = Header;
local UIStroke2 = Instance.new("UIStroke");
UIStroke2.Thickness = 1.2;
UIStroke2.Parent = Title;
local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
UITextSizeConstraint.MinTextSize = 8;
UITextSizeConstraint.MaxTextSize = 11;
UITextSizeConstraint.Parent = Title;
local ModeToggle = Instance.new("TextButton");
ModeToggle.Name = "ModeToggle";
ModeToggle.ZIndex = 4;
ModeToggle.AnchorPoint = Vector2.new(1, 0.5);
ModeToggle.Position = UDim2.new(1, -8, 0.5, 0);
ModeToggle.Size = UDim2.new(0, 42, 0, 18);
ModeToggle.BackgroundColor3 = Color3.fromRGB(26, 26, 30);
ModeToggle.BackgroundTransparency = 0.25;
ModeToggle.Text = (isMobileMode and "PC") or "MOBILE";
ModeToggle.TextColor3 = Color3.fromRGB(240, 240, 240);
ModeToggle.TextSize = 7;
ModeToggle.Font = Enum.Font.GothamBold;
ModeToggle.Parent = Header;
local UICorner5 = Instance.new("UICorner");
UICorner5.CornerRadius = UDim.new(0, 6);
UICorner5.Parent = ModeToggle;
local UIStroke3 = Instance.new("UIStroke");
UIStroke3.Color = Color3.fromRGB(120, 120, 130);
UIStroke3.Transparency = 0.15;
UIStroke3.Parent = ModeToggle;
local BackgroundButton = Instance.new("TextButton");
BackgroundButton.Name = "BackgroundButton";
BackgroundButton.ZIndex = 13;
BackgroundButton.AnchorPoint = Vector2.new(1, 0.5);
BackgroundButton.Position = UDim2.new(1, -54, 0.5, 0);
BackgroundButton.Size = UDim2.new(0, 42, 0, 18);
BackgroundButton.BackgroundColor3 = Color3.fromRGB(42, 42, 48);
BackgroundButton.BackgroundTransparency = 0.15;
BackgroundButton.Text = "BG";
BackgroundButton.TextColor3 = Color3.fromRGB(240, 240, 240);
BackgroundButton.TextSize = 10;
BackgroundButton.Font = Enum.Font.GothamBold;
BackgroundButton.AutoButtonColor = false;
BackgroundButton.Parent = Header;
local UICorner6 = Instance.new("UICorner");
UICorner6.CornerRadius = UDim.new(0, 6);
UICorner6.Parent = BackgroundButton;
local UIStroke4 = Instance.new("UIStroke");
UIStroke4.Color = Color3.fromRGB(120, 120, 130);
UIStroke4.Transparency = 0.15;
UIStroke4.Parent = BackgroundButton;
local ContentHolder = Instance.new("Frame");
ContentHolder.Name = "ContentHolder";
ContentHolder.ZIndex = 2;
ContentHolder.ClipsDescendants = true;
ContentHolder.Position = UDim2.new(0, 10, 0, 42);
ContentHolder.Size = UDim2.new(1, -20, 1, -52);
ContentHolder.BackgroundTransparency = 1;
ContentHolder.Parent = Main;
local Content = Instance.new("Frame");
Content.Name = "Content";
Content.ZIndex = 2;
Content.Size = UDim2.new(1, 0, 1, 0);
Content.BackgroundTransparency = 1;
Content.Parent = ContentHolder;
local PCContent = Instance.new("Frame");
PCContent.Name = "PCContent";
PCContent.Size = UDim2.new(1, 0, 1, 0);
PCContent.BackgroundTransparency = 1;
PCContent.Visible = not isMobileMode;
PCContent.Parent = Content;
local Frame2 = Instance.new("Frame");
Frame2.ZIndex = 3;
Frame2.Size = UDim2.new(1, 0, 0, 32);
Frame2.BackgroundColor3 = Color3.fromRGB(34, 34, 40);
Frame2.BackgroundTransparency = 0.2;
Frame2.BorderSizePixel = 0;
Frame2.Parent = PCContent;
local UICorner7 = Instance.new("UICorner");
UICorner7.Parent = Frame2;
local UIStroke5 = Instance.new("UIStroke");
UIStroke5.Color = Color3.fromRGB(120, 120, 130);
UIStroke5.Parent = Frame2;
local TextLabel = Instance.new("TextLabel");
TextLabel.ZIndex = 4;
TextLabel.Position = UDim2.new(0, 10, 0, 0);
TextLabel.Size = UDim2.new(0, 60, 1, 0);
TextLabel.BackgroundTransparency = 1;
TextLabel.Text = "Anti-Bat";
TextLabel.TextColor3 = Color3.fromRGB(240, 240, 240);
TextLabel.TextSize = 12;
TextLabel.Font = Enum.Font.GothamBold;
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.Parent = Frame2;
local KeybindBtn = Instance.new("TextButton");
KeybindBtn.ZIndex = 10;
KeybindBtn.AnchorPoint = Vector2.new(0, 0.5);
KeybindBtn.Position = UDim2.new(0, 74, 0.5, 0);
KeybindBtn.Size = UDim2.new(0, 32, 0, 16);
KeybindBtn.BackgroundColor3 = Color3.fromRGB(42, 42, 48);
KeybindBtn.BackgroundTransparency = 0.15;
KeybindBtn.Text = CurrentKeybind.Name;
KeybindBtn.TextColor3 = Color3.fromRGB(240, 240, 240);
KeybindBtn.Font = Enum.Font.GothamBold;
KeybindBtn.Parent = Frame2;
local UICorner8 = Instance.new("UICorner");
UICorner8.CornerRadius = UDim.new(0, 5);
UICorner8.Parent = KeybindBtn;
local UIStroke6 = Instance.new("UIStroke");
UIStroke6.Color = Color3.fromRGB(120, 120, 130);
UIStroke6.Transparency = 0.15;
UIStroke6.Parent = KeybindBtn;
local AntiBatToggleBg = Instance.new("Frame");
AntiBatToggleBg.ZIndex = 4;
AntiBatToggleBg.AnchorPoint = Vector2.new(1, 0.5);
AntiBatToggleBg.Position = UDim2.new(1, -10, 0.5, 0);
AntiBatToggleBg.Size = UDim2.new(0, 32, 0, 15);
AntiBatToggleBg.BackgroundColor3 = Color3.fromRGB(52, 52, 58);
AntiBatToggleBg.BorderSizePixel = 0;
AntiBatToggleBg.Parent = Frame2;
local UICorner9 = Instance.new("UICorner");
UICorner9.CornerRadius = UDim.new(1, 0);
UICorner9.Parent = AntiBatToggleBg;
local UIStroke7 = Instance.new("UIStroke");
UIStroke7.Color = Color3.fromRGB(120, 120, 130);
UIStroke7.Transparency = 0.15;
UIStroke7.Parent = AntiBatToggleBg;
local AntiBatKnob = Instance.new("Frame");
AntiBatKnob.ZIndex = 5;
AntiBatKnob.AnchorPoint = Vector2.new(0, 0.5);
AntiBatKnob.Position = UDim2.new(0, 3, 0.5, 0);
AntiBatKnob.Size = UDim2.new(0, 11, 0, 11);
AntiBatKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
AntiBatKnob.BorderSizePixel = 0;
AntiBatKnob.Parent = AntiBatToggleBg;
local UICorner10 = Instance.new("UICorner");
UICorner10.CornerRadius = UDim.new(1, 0);
UICorner10.Parent = AntiBatKnob;
local AntiBatClick = Instance.new("TextButton");
AntiBatClick.ZIndex = 6;
AntiBatClick.Size = UDim2.new(1, 0, 1, 0);
AntiBatClick.BackgroundTransparency = 1;
AntiBatClick.Text = "";
AntiBatClick.Parent = Frame2;
local Frame5 = Instance.new("Frame");
Frame5.ZIndex = 3;
Frame5.Position = UDim2.new(0, 0, 0, 36);
Frame5.Size = UDim2.new(1, 0, 0, 32);
Frame5.BackgroundColor3 = Color3.fromRGB(26, 26, 30);
Frame5.BackgroundTransparency = 0.35;
Frame5.BorderSizePixel = 0;
Frame5.Parent = PCContent;
local UICorner12 = Instance.new("UICorner");
UICorner12.Parent = Frame5;
local UIStroke9 = Instance.new("UIStroke");
UIStroke9.Color = Color3.fromRGB(120, 120, 130);
UIStroke9.Transparency = 0.15;
UIStroke9.Parent = Frame5;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.ZIndex = 4;
TextLabel2.Position = UDim2.new(0, 10, 0, 0);
TextLabel2.Size = UDim2.new(0, 60, 1, 0);
TextLabel2.BackgroundTransparency = 1;
TextLabel2.Text = "Inf Jump";
TextLabel2.TextColor3 = Color3.fromRGB(240, 240, 240);
TextLabel2.TextSize = 12;
TextLabel2.Font = Enum.Font.GothamBold;
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel2.Parent = Frame5;
local InfJumpToggleBg = Instance.new("Frame");
InfJumpToggleBg.ZIndex = 4;
InfJumpToggleBg.AnchorPoint = Vector2.new(1, 0.5);
InfJumpToggleBg.Position = UDim2.new(1, -10, 0.5, 0);
InfJumpToggleBg.Size = UDim2.new(0, 32, 0, 15);
InfJumpToggleBg.BackgroundColor3 = Color3.fromRGB(52, 52, 58);
InfJumpToggleBg.BorderSizePixel = 0;
InfJumpToggleBg.Parent = Frame5;
local UICorner13 = Instance.new("UICorner");
UICorner13.CornerRadius = UDim.new(1, 0);
UICorner13.Parent = InfJumpToggleBg;
local UIStroke10 = Instance.new("UIStroke");
UIStroke10.Color = Color3.fromRGB(120, 120, 130);
UIStroke10.Transparency = 0.15;
UIStroke10.Parent = InfJumpToggleBg;
local InfJumpKnob = Instance.new("Frame");
InfJumpKnob.ZIndex = 5;
InfJumpKnob.AnchorPoint = Vector2.new(0, 0.5);
InfJumpKnob.Position = UDim2.new(0, 3, 0.5, 0);
InfJumpKnob.Size = UDim2.new(0, 11, 0, 11);
InfJumpKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
InfJumpKnob.BorderSizePixel = 0;
InfJumpKnob.Parent = InfJumpToggleBg;
local UICorner14 = Instance.new("UICorner");
UICorner14.CornerRadius = UDim.new(1, 0);
UICorner14.Parent = InfJumpKnob;
local InfJumpClick = Instance.new("TextButton");
InfJumpClick.ZIndex = 6;
InfJumpClick.Size = UDim2.new(1, 0, 1, 0);
InfJumpClick.BackgroundTransparency = 1;
InfJumpClick.Text = "";
InfJumpClick.Parent = Frame5;
local MobileContent = Instance.new("Frame");
MobileContent.Name = "MobileContent";
MobileContent.Size = UDim2.new(1, 0, 1, 0);
MobileContent.BackgroundTransparency = 1;
MobileContent.Visible = isMobileMode;
MobileContent.Parent = Content;
local MobileAntiBatBtn = Instance.new("TextButton");
MobileAntiBatBtn.ZIndex = 3;
MobileAntiBatBtn.Size = UDim2.new(1, 0, 0, 32);
MobileAntiBatBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 40);
MobileAntiBatBtn.BackgroundTransparency = 0.15;
MobileAntiBatBtn.Text = "ANTI-BAT";
MobileAntiBatBtn.TextColor3 = Color3.fromRGB(240, 240, 240);
MobileAntiBatBtn.TextSize = 13;
MobileAntiBatBtn.Font = Enum.Font.GothamBold;
MobileAntiBatBtn.AutoButtonColor = false;
MobileAntiBatBtn.Parent = MobileContent;
local UICornerM1 = Instance.new("UICorner");
UICornerM1.CornerRadius = UDim.new(0, 8);
UICornerM1.Parent = MobileAntiBatBtn;
local UIStrokeM1 = Instance.new("UIStroke");
UIStrokeM1.Color = Color3.fromRGB(120, 120, 130);
UIStrokeM1.Transparency = 0.2;
UIStrokeM1.Parent = MobileAntiBatBtn;
local MobileInfJumpBtn = Instance.new("TextButton");
MobileInfJumpBtn.ZIndex = 3;
MobileInfJumpBtn.Position = UDim2.new(0, 0, 0, 38);
MobileInfJumpBtn.Size = UDim2.new(1, 0, 0, 32);
MobileInfJumpBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 40);
MobileInfJumpBtn.BackgroundTransparency = 0.15;
MobileInfJumpBtn.Text = "INF JUMP";
MobileInfJumpBtn.TextColor3 = Color3.fromRGB(240, 240, 240);
MobileInfJumpBtn.TextSize = 13;
MobileInfJumpBtn.Font = Enum.Font.GothamBold;
MobileInfJumpBtn.AutoButtonColor = false;
MobileInfJumpBtn.Parent = MobileContent;
local UICornerM2 = Instance.new("UICorner");
UICornerM2.CornerRadius = UDim.new(0, 8);
UICornerM2.Parent = MobileInfJumpBtn;
local UIStrokeM2 = Instance.new("UIStroke");
UIStrokeM2.Color = Color3.fromRGB(120, 120, 130);
UIStrokeM2.Transparency = 0.2;
UIStrokeM2.Parent = MobileInfJumpBtn;
local Footer = Instance.new("TextLabel");
Footer.ZIndex = 3;
Footer.Position = UDim2.new(0, 0, 1, -16);
Footer.Size = UDim2.new(1, 0, 0, 16);
Footer.BackgroundTransparency = 1;
Footer.Text = "Anti-Bat | Inf Jump | Anti Ragdoll";
Footer.TextColor3 = Color3.fromRGB(190, 190, 195);
Footer.Font = Enum.Font.Gotham;
Footer.TextSize = 10;
Footer.Parent = Content;
local BackgroundPicker = Instance.new("Frame");
BackgroundPicker.Name = "BackgroundPicker";
BackgroundPicker.Visible = false;
BackgroundPicker.ZIndex = 20;
BackgroundPicker.AnchorPoint = Vector2.new(0.5, 0.5);
BackgroundPicker.Position = UDim2.new(0.5, 0, 0.5, 0);
BackgroundPicker.Size = UDim2.new(0, 260, 0, 205);
BackgroundPicker.BackgroundColor3 = Color3.fromRGB(10, 10, 12);
BackgroundPicker.BorderSizePixel = 0;
BackgroundPicker.Parent = hydradat_anti_bat;
local UICorner16 = Instance.new("UICorner");
UICorner16.CornerRadius = UDim.new(0, 12);
UICorner16.Parent = BackgroundPicker;
local UIStroke12 = Instance.new("UIStroke");
UIStroke12.Color = Color3.fromRGB(110, 110, 120);
UIStroke12.Thickness = 1.5;
UIStroke12.Transparency = 0.15;
UIStroke12.Parent = BackgroundPicker;
local Header2 = Instance.new("Frame");
Header2.ZIndex = 21;
Header2.Size = UDim2.new(1, 0, 0, 38);
Header2.BackgroundColor3 = Color3.fromRGB(10, 10, 12);
Header2.BackgroundTransparency = 0.15;
Header2.BorderSizePixel = 0;
Header2.Parent = BackgroundPicker;
local UICorner17 = Instance.new("UICorner");
UICorner17.CornerRadius = UDim.new(0, 12);
UICorner17.Parent = Header2;
local TextLabel4 = Instance.new("TextLabel");
TextLabel4.ZIndex = 22;
TextLabel4.Position = UDim2.new(0, 12, 0, 0);
TextLabel4.Size = UDim2.new(1, -54, 1, 0);
TextLabel4.BackgroundTransparency = 1;
TextLabel4.Text = "Change Background";
TextLabel4.TextColor3 = Color3.fromRGB(240, 240, 240);
TextLabel4.TextSize = 16;
TextLabel4.Font = Enum.Font.GothamBold;
TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel4.Parent = Header2;
local Close = Instance.new("TextButton");
Close.Name = "Close";
Close.ZIndex = 22;
Close.AnchorPoint = Vector2.new(1, 0.5);
Close.Position = UDim2.new(1, -9, 0.5, 0);
Close.Size = UDim2.new(0, 28, 0, 25);
Close.BackgroundColor3 = Color3.fromRGB(26, 26, 30);
Close.BackgroundTransparency = 0.1;
Close.Text = "x";
Close.TextColor3 = Color3.fromRGB(240, 240, 240);
Close.TextSize = 14;
Close.Font = Enum.Font.GothamBold;
Close.AutoButtonColor = false;
Close.Parent = Header2;
local UICorner18 = Instance.new("UICorner");
UICorner18.CornerRadius = UDim.new(0, 7);
UICorner18.Parent = Close;
local BackgroundGrid = Instance.new("Frame");
BackgroundGrid.ZIndex = 21;
BackgroundGrid.Position = UDim2.new(0, 12, 0, 48);
BackgroundGrid.Size = UDim2.new(1, -24, 1, -60);
BackgroundGrid.BackgroundTransparency = 1;
BackgroundGrid.Parent = BackgroundPicker;
local UIGridLayout = Instance.new("UIGridLayout");
UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 8);
UIGridLayout.CellSize = UDim2.new(0, 72, 0, 72);
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIGridLayout.FillDirectionMaxCells = 3;
UIGridLayout.Parent = BackgroundGrid;
local bgIds = {"rbxassetid://118100574986629","rbxassetid://76835310118322","rbxassetid://114138477258742"};
for i, id in ipairs(bgIds) do
	local FlatIdent_494DF = 0;
	local btn;
	local c;
	local s;
	while true do
		if (FlatIdent_494DF == 0) then
			btn = Instance.new("ImageButton");
			btn.ZIndex = 22;
			btn.LayoutOrder = i;
			btn.BackgroundColor3 = Color3.fromRGB(26, 26, 30);
			FlatIdent_494DF = 1;
		end
		if (FlatIdent_494DF == 3) then
			s = Instance.new("UIStroke");
			s.Color = Color3.fromRGB(120, 120, 130);
			s.Transparency = 0.1;
			s.Parent = btn;
			FlatIdent_494DF = 4;
		end
		if (FlatIdent_494DF == 2) then
			btn.Parent = BackgroundGrid;
			c = Instance.new("UICorner");
			c.CornerRadius = UDim.new(0, 10);
			c.Parent = btn;
			FlatIdent_494DF = 3;
		end
		if (FlatIdent_494DF == 4) then
			btn.MouseButton1Click:Connect(function()
				CurrentBG = id;
				SpaceBackground.Image = id;
				BackgroundPicker.Visible = false;
				saveConfig();
			end);
			break;
		end
		if (FlatIdent_494DF == 1) then
			btn.BackgroundTransparency = 0.1;
			btn.Image = id;
			btn.ScaleType = Enum.ScaleType.Crop;
			btn.AutoButtonColor = false;
			FlatIdent_494DF = 2;
		end
	end
end
local function setToggle(knob, bg, enabled)
	TweenService:Create(knob, TweenInfo.new(0.15), {Position=((enabled and UDim2.new(1, -14, 0.5, 0)) or UDim2.new(0, 3, 0.5, 0)),BackgroundColor3=((enabled and Color3.fromRGB(0, 0, 0)) or Color3.fromRGB(255, 255, 255))}):Play();
	TweenService:Create(bg, TweenInfo.new(0.15), {BackgroundColor3=((enabled and Color3.fromRGB(255, 255, 255)) or Color3.fromRGB(52, 52, 58))}):Play();
end
local function updateMobileButtons()
	local FlatIdent_207CC = 0;
	while true do
		if (FlatIdent_207CC == 0) then
			if AntiBatEnabled then
				local FlatIdent_6DC53 = 0;
				while true do
					if (0 == FlatIdent_6DC53) then
						MobileAntiBatBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
						UIStrokeM1.Transparency = 0;
						break;
					end
				end
			else
				local FlatIdent_61EE = 0;
				while true do
					if (0 == FlatIdent_61EE) then
						MobileAntiBatBtn.TextColor3 = Color3.fromRGB(240, 240, 240);
						UIStrokeM1.Transparency = 0.2;
						break;
					end
				end
			end
			if InfiniteJumpEnabled then
				MobileInfJumpBtn.TextColor3 = Color3.fromRGB(0, 0, 0);
				UIStrokeM2.Transparency = 0;
			else
				local FlatIdent_89237 = 0;
				while true do
					if (FlatIdent_89237 == 0) then
						MobileInfJumpBtn.TextColor3 = Color3.fromRGB(240, 240, 240);
						UIStrokeM2.Transparency = 0.2;
						break;
					end
				end
			end
			break;
		end
	end
end
local function switchMode()
	isMobileMode = not isMobileMode;
	ModeToggle.Text = (isMobileMode and "PC") or "MOBILE";
	PCContent.Visible = not isMobileMode;
	MobileContent.Visible = isMobileMode;
	saveConfig();
end
AntiBatClick.MouseButton1Click:Connect(function()
	local FlatIdent_49280 = 0;
	while true do
		if (FlatIdent_49280 == 0) then
			AntiBatEnabled = not AntiBatEnabled;
			if AntiBatEnabled then
				startAntiBat();
			else
				stopAntiBat();
			end
			FlatIdent_49280 = 1;
		end
		if (FlatIdent_49280 == 1) then
			setToggle(AntiBatKnob, AntiBatToggleBg, AntiBatEnabled);
			updateMobileButtons();
			break;
		end
	end
end);
InfJumpClick.MouseButton1Click:Connect(function()
	InfiniteJumpEnabled = not InfiniteJumpEnabled;
	InfiniteJumpHoldEnabled = InfiniteJumpEnabled;
	if not InfiniteJumpHoldEnabled then
		IsJumpingHold = false;
	end
	setToggle(InfJumpKnob, InfJumpToggleBg, InfiniteJumpEnabled);
	updateMobileButtons();
end);
MobileAntiBatBtn.MouseButton1Click:Connect(function()
	local FlatIdent_2E9CB = 0;
	while true do
		if (FlatIdent_2E9CB == 1) then
			setToggle(AntiBatKnob, AntiBatToggleBg, AntiBatEnabled);
			updateMobileButtons();
			break;
		end
		if (FlatIdent_2E9CB == 0) then
			AntiBatEnabled = not AntiBatEnabled;
			if AntiBatEnabled then
				startAntiBat();
			else
				stopAntiBat();
			end
			FlatIdent_2E9CB = 1;
		end
	end
end);
MobileInfJumpBtn.MouseButton1Click:Connect(function()
	local FlatIdent_8BC55 = 0;
	while true do
		if (FlatIdent_8BC55 == 0) then
			InfiniteJumpEnabled = not InfiniteJumpEnabled;
			InfiniteJumpHoldEnabled = InfiniteJumpEnabled;
			FlatIdent_8BC55 = 1;
		end
		if (FlatIdent_8BC55 == 1) then
			if not InfiniteJumpHoldEnabled then
				IsJumpingHold = false;
			end
			setToggle(InfJumpKnob, InfJumpToggleBg, InfiniteJumpEnabled);
			FlatIdent_8BC55 = 2;
		end
		if (FlatIdent_8BC55 == 2) then
			updateMobileButtons();
			break;
		end
	end
end);
KeybindBtn.MouseButton1Click:Connect(function()
	if WaitingForKeybind then
		return;
	end
	WaitingForKeybind = true;
	KeybindBtn.Text = "...";
	KeybindBtn.TextColor3 = Color3.fromRGB(255, 200, 100);
end);
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then
		return;
	end
	if WaitingForKeybind then
		local FlatIdent_6A091 = 0;
		while true do
			if (FlatIdent_6A091 == 0) then
				if (input.UserInputType == Enum.UserInputType.Keyboard) then
					local FlatIdent_882F4 = 0;
					while true do
						if (FlatIdent_882F4 == 0) then
							CurrentKeybind = input.KeyCode;
							WaitingForKeybind = false;
							FlatIdent_882F4 = 1;
						end
						if (FlatIdent_882F4 == 2) then
							saveConfig();
							break;
						end
						if (FlatIdent_882F4 == 1) then
							KeybindBtn.Text = CurrentKeybind.Name;
							KeybindBtn.TextColor3 = Color3.fromRGB(240, 240, 240);
							FlatIdent_882F4 = 2;
						end
					end
				end
				return;
			end
		end
	end
	if ((input.UserInputType == Enum.UserInputType.Keyboard) and (input.KeyCode == CurrentKeybind)) then
		AntiBatEnabled = not AntiBatEnabled;
		if AntiBatEnabled then
			startAntiBat();
		else
			stopAntiBat();
		end
		setToggle(AntiBatKnob, AntiBatToggleBg, AntiBatEnabled);
		updateMobileButtons();
	end
end);
BackgroundButton.MouseButton1Click:Connect(function()
	BackgroundPicker.Visible = not BackgroundPicker.Visible;
end);
Close.MouseButton1Click:Connect(function()
	BackgroundPicker.Visible = false;
end);
ModeToggle.MouseButton1Click:Connect(switchMode);
local dragging, dragStart, startPos;
Header.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_28014 = 0;
		while true do
			if (FlatIdent_28014 == 1) then
				startPos = Main.Position;
				break;
			end
			if (FlatIdent_28014 == 0) then
				dragging = true;
				dragStart = input.Position;
				FlatIdent_28014 = 1;
			end
		end
	end
end);
UserInputService.InputChanged:Connect(function(input)
	if (dragging and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		local FlatIdent_72421 = 0;
		local delta;
		while true do
			if (FlatIdent_72421 == 0) then
				delta = input.Position - dragStart;
				Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
				break;
			end
		end
	end
end);
UserInputService.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		dragging = false;
	end
end);
startAntiRagdoll();
startJumpHoldLoop();
setToggle(AntiBatKnob, AntiBatToggleBg, false);
setToggle(InfJumpKnob, InfJumpToggleBg, false);
updateMobileButtons();