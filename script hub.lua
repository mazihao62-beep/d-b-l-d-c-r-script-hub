local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local currentLanguage = "Chinese"

local function showNotification(title, content, duration)
    duration = duration or 2
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = content,
        Duration = duration,
    })
end

local function createLanguageSelection()
    local langGui = Instance.new("ScreenGui")
    langGui.Name = "LanguageSelector"
    langGui.Parent = playerGui
    langGui.AncestryChanged:Connect(function()
        if not langGui.Parent then langGui.Parent = playerGui end
    end)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 240, 0, 120)
    frame.Position = UDim2.new(0.5, -120, 0.5, -60)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = langGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(255, 100, 100)
    stroke.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Text = "Select Language / 选择语言"
    titleLabel.Parent = frame

    local chineseBtn = Instance.new("TextButton")
    chineseBtn.Size = UDim2.new(0, 100, 0, 40)
    chineseBtn.Position = UDim2.new(0.5, -110, 0, 45)
    chineseBtn.Text = "中文"
    chineseBtn.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
    chineseBtn.TextColor3 = Color3.new(1, 1, 1)
    chineseBtn.Font = Enum.Font.SourceSansBold
    chineseBtn.TextSize = 18
    chineseBtn.Parent = frame
    Instance.new("UICorner", chineseBtn).CornerRadius = UDim.new(0, 8)

    local englishBtn = Instance.new("TextButton")
    englishBtn.Size = UDim2.new(0, 100, 0, 40)
    englishBtn.Position = UDim2.new(0.5, 10, 0, 45)
    englishBtn.Text = "English"
    englishBtn.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
    englishBtn.TextColor3 = Color3.new(1, 1, 1)
    englishBtn.Font = Enum.Font.SourceSansBold
    englishBtn.TextSize = 18
    englishBtn.Parent = frame
    Instance.new("UICorner", englishBtn).CornerRadius = UDim.new(0, 8)

    local function addHover(btn)
        local orig = btn.BackgroundColor3
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = orig:Lerp(Color3.new(1,1,1), 0.2) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = orig end)
    end
    addHover(chineseBtn)
    addHover(englishBtn)

    chineseBtn.MouseButton1Click:Connect(function()
        currentLanguage = "Chinese"
        langGui:Destroy()
        createScriptHub()
    end)
    englishBtn.MouseButton1Click:Connect(function()
        currentLanguage = "English"
        langGui:Destroy()
        createScriptHub()
    end)
end

function createScriptHub()
    local hubGui = Instance.new("ScreenGui")
    hubGui.Name = "ScriptHub"
    hubGui.Parent = playerGui
    hubGui.AncestryChanged:Connect(function()
        if not hubGui.Parent then hubGui.Parent = playerGui end
    end)

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 280)
    mainFrame.Position = UDim2.new(0.5, -200, 0.4, -140)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = hubGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Thickness = 2
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    mainStroke.Color = Color3.fromRGB(255, 100, 100)
    mainStroke.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 36)
    titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Text = "大不列颠超入脚本中心(b站:大不列颠超入_)"
    titleLabel.Parent = titleBar

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -20, 1, -46)
    contentFrame.Position = UDim2.new(0, 10, 0, 40)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ScrollBarThickness = 4
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
    contentFrame.Parent = mainFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = contentFrame

    local scripts = {
        { Name = "排干湖水", Func = function() loadDrainLake() end },
        { Name = "滑膛枪与机器人", Func = function() loadMusketRobot() end },
        { Name = "动物医院", Func = function() loadAnimalHospital() end },
    }

    for _, script in ipairs(scripts) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 42)
        btn.Text = script.Name
        btn.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 16
        btn.Parent = contentFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local origColor = btn.BackgroundColor3
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = origColor:Lerp(Color3.new(1,1,1), 0.2) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = origColor end)

        btn.MouseButton1Click:Connect(function()
            hubGui:Destroy()
            script.Func()
        end)
    end

    RunService.Heartbeat:Connect(function()
        local hue = (tick() * 0.5) % 1
        mainStroke.Color = Color3.fromHSV(hue, 1, 1)
    end)
end

-- 三个脚本的加载函数（占位，将在 Part2、3、4 中定义）
function loadDrainLake()
    local langTable = {
        Chinese = {
            title = "排干湖水脚本",
            waterStart = "开始无限拿水", waterStop = "停止无限拿水",
            interactStart = "开启全图互动+秒互动", interactStop = "关闭全图互动+秒互动",
            sell1 = "自动售卖(1号机)", sell1Stop = "停止售卖(1号机)",
            chest = "自动开箱子", chestStop = "停止开箱子",
            sell2 = "自动售卖(2号机)", sell2Stop = "停止售卖(2号机)",
            notice = "自动售卖与开箱子需要开启全图互动与秒互动",
            floatText = "b站:英吉利超入_",
            waterOn = "无限拿水已开启", interactOn = "全图互动已开启",
            sell1On = "售卖1号机已开启", chestOn = "自动开箱已开启", sell2On = "售卖2号机已开启",
        },
        English = {
            title = "Drain Lake Script",
            waterStart = "Start Infinite Water", waterStop = "Stop Infinite Water",
            interactStart = "Enable Full Map Interaction", interactStop = "Disable Full Map Interaction",
            sell1 = "Auto Sell (Machine 1)", sell1Stop = "Stop Sell (Machine 1)",
            chest = "Auto Open Chest", chestStop = "Stop Open Chest",
            sell2 = "Auto Sell (Machine 2)", sell2Stop = "Stop Sell (Machine 2)",
            notice = "Auto Sell & Chest require Full Map Interaction enabled",
            floatText = "bilibili: Yingjili Chaoru_",
            waterOn = "Infinite Water enabled", interactOn = "Full Map Interaction enabled",
            sell1On = "Sell Machine 1 started", chestOn = "Auto Open Chest started", sell2On = "Sell Machine 2 started",
        }
    }
    local lang = langTable[currentLanguage]

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local remoteBucketUsed = ReplicatedStorage:WaitForChild("VerdantRemotes"):WaitForChild("VDT_Bucket.Used")
    local remoteBucketPoured = ReplicatedStorage:WaitForChild("VerdantRemotes"):WaitForChild("VDT_Bucket.Poured")
    local remoteChestOpen = ReplicatedStorage:WaitForChild("VerdantRemotes"):WaitForChild("VDT_Chest.Open")

    local sell1Prompt = Workspace:WaitForChild("Scripted"):WaitForChild("CheckpointParts"):WaitForChild("1"):WaitForChild("Drain"):WaitForChild("Scripted"):WaitForChild("ProximityPosition"):WaitForChild("ProximityPrompt")
    local chestPart = Workspace:WaitForChild("Scripted"):WaitForChild("Chests"):WaitForChild("Chest"):WaitForChild("Part")
    local sell2Prompt = Workspace:WaitForChild("Scripted"):WaitForChild("CheckpointParts"):WaitForChild("1"):WaitForChild("Drain"):WaitForChild("Scripted"):WaitForChild("ProximityPosition"):WaitForChild("ProximityPrompt")

    local function showNotification(title, content, duration)
        duration = duration or 2
        StarterGui:SetCore("SendNotification", { Title = title, Text = content, Duration = duration })
    end

    local function createMainGui()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "DrainLakeUI"
        screenGui.Parent = playerGui
        screenGui.AncestryChanged:Connect(function() if not screenGui.Parent then screenGui.Parent = playerGui end end)
        task.spawn(function() while true do if not screenGui.Parent then screenGui.Parent = playerGui end; task.wait(1) end end)

        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 300, 0, 340)
        mainFrame.Position = UDim2.new(0.5, -150, 0.4, -170)
        mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        mainFrame.BackgroundTransparency = 0.05
        mainFrame.BorderSizePixel = 0
        mainFrame.Active = true
        mainFrame.Draggable = true
        mainFrame.Parent = screenGui
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

        local mainStroke = Instance.new("UIStroke")
        mainStroke.Thickness = 2
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        mainStroke.Color = Color3.fromRGB(255, 100, 100)
        mainStroke.Parent = mainFrame

        local lastPosition = mainFrame.Position
        local lastSize = mainFrame.Size
        local isMaximized = false
        mainFrame:GetPropertyChangedSignal("Position"):Connect(function() if not isMaximized then lastPosition = mainFrame.Position end end)
        mainFrame:GetPropertyChangedSignal("Size"):Connect(function() if not isMaximized then lastSize = mainFrame.Size end end)

        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 32)
        titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        titleBar.BorderSizePixel = 0
        titleBar.Parent = mainFrame
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 10)
        titleCorner.Parent = titleBar

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -70, 1, 0)
        titleLabel.Position = UDim2.new(0, 12, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextSize = 16
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Text = lang.title
        titleLabel.TextScaled = true
        titleLabel.Parent = titleBar

        local minimizeBtn = Instance.new("TextButton")
        minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
        minimizeBtn.Position = UDim2.new(1, -56, 0, 3)
        minimizeBtn.Text = "─"
        minimizeBtn.Font = Enum.Font.SourceSansBold
        minimizeBtn.TextSize = 16
        minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        minimizeBtn.BorderSizePixel = 0
        minimizeBtn.Parent = titleBar
        Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 5)

        local maximizeBtn = Instance.new("TextButton")
        maximizeBtn.Size = UDim2.new(0, 26, 0, 26)
        maximizeBtn.Position = UDim2.new(1, -28, 0, 3)
        maximizeBtn.Text = "□"
        maximizeBtn.Font = Enum.Font.SourceSansBold
        maximizeBtn.TextSize = 16
        maximizeBtn.TextColor3 = Color3.new(1, 1, 1)
        maximizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        maximizeBtn.BorderSizePixel = 0
        maximizeBtn.Parent = titleBar
        Instance.new("UICorner", maximizeBtn).CornerRadius = UDim.new(0, 5)

        local function addHover(btn)
            local orig = btn.BackgroundColor3
            btn.MouseEnter:Connect(function() btn.BackgroundColor3 = orig:Lerp(Color3.new(1,1,1), 0.2) end)
            btn.MouseLeave:Connect(function() btn.BackgroundColor3 = orig end)
        end
        addHover(minimizeBtn)
        addHover(maximizeBtn)

        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, -24, 1, -44)
        contentFrame.Position = UDim2.new(0, 12, 0, 38)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Parent = mainFrame

        local listLayout = Instance.new("UIListLayout")
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 8)
        listLayout.Parent = contentFrame

        local function createToggleButton(text, parent, order)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 42)
            btn.Text = text
            btn.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.SourceSansBold
            btn.TextSize = 18
            btn.LayoutOrder = order
            btn.Parent = parent
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
            return btn
        end

        local waterBtn = createToggleButton(lang.waterStart, contentFrame, 1)
        local interactBtn = createToggleButton(lang.interactStart, contentFrame, 2)
        local sell1Btn = createToggleButton(lang.sell1, contentFrame, 3)
        local chestBtn = createToggleButton(lang.chest, contentFrame, 4)
        local sell2Btn = createToggleButton(lang.sell2, contentFrame, 5)

        local noticeLabel = Instance.new("TextLabel")
        noticeLabel.Size = UDim2.new(1, 0, 0, 22)
        noticeLabel.LayoutOrder = 6
        noticeLabel.BackgroundTransparency = 1
        noticeLabel.Font = Enum.Font.SourceSans
        noticeLabel.TextSize = 13
        noticeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        noticeLabel.TextXAlignment = Enum.TextXAlignment.Center
        noticeLabel.Text = lang.notice
        noticeLabel.Parent = contentFrame

        local function addToggleHover(btn, getIsActiveFunc, activeColor)
            local orig = btn.BackgroundColor3
            btn.MouseEnter:Connect(function()
                if not getIsActiveFunc() then btn.BackgroundColor3 = orig:Lerp(Color3.new(1,1,1), 0.15) end
            end)
            btn.MouseLeave:Connect(function()
                if getIsActiveFunc() and activeColor then btn.BackgroundColor3 = activeColor else btn.BackgroundColor3 = orig end
            end)
        end

        local floatFrame = Instance.new("Frame")
        floatFrame.Size = UDim2.new(0, 260, 0, 40)
        floatFrame.Position = UDim2.new(0.5, -130, 0, 10)
        floatFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        floatFrame.BackgroundTransparency = 0.1
        floatFrame.BorderSizePixel = 0
        floatFrame.Visible = false
        floatFrame.Active = true
        floatFrame.Draggable = true
        floatFrame.Parent = screenGui

        local floatCorner = Instance.new("UICorner")
        floatCorner.CornerRadius = UDim.new(0, 20)
        floatCorner.Parent = floatFrame

        local floatStroke = Instance.new("UIStroke")
        floatStroke.Thickness = 1.5
        floatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        floatStroke.Color = Color3.fromRGB(255, 100, 100)
        floatStroke.Parent = floatFrame

        local floatLabel = Instance.new("TextLabel")
        floatLabel.Size = UDim2.new(1, -20, 1, 0)
        floatLabel.Position = UDim2.new(0, 10, 0, 0)
        floatLabel.BackgroundTransparency = 1
        floatLabel.Font = Enum.Font.SourceSansBold
        floatLabel.TextSize = 16
        floatLabel.TextColor3 = Color3.new(1, 1, 1)
        floatLabel.Text = lang.floatText
        floatLabel.TextXAlignment = Enum.TextXAlignment.Center
        floatLabel.Parent = floatFrame

        local touchStartPos = nil
        floatFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                touchStartPos = input.Position
            end
        end)
        floatFrame.InputEnded:Connect(function(input)
            if touchStartPos and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                if (input.Position - touchStartPos).Magnitude < 5 then
                    mainFrame.Visible = true
                    floatFrame.Visible = false
                end
                touchStartPos = nil
            end
        end)

        minimizeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; floatFrame.Visible = true end)
        maximizeBtn.MouseButton1Click:Connect(function()
            if not isMaximized then
                lastPosition = mainFrame.Position; lastSize = mainFrame.Size
                mainFrame.Size = UDim2.new(1, 0, 1, 0); mainFrame.Position = UDim2.new(0, 0, 0, 0)
                maximizeBtn.Text = "❐"; isMaximized = true
            else
                mainFrame.Size = lastSize; mainFrame.Position = lastPosition
                maximizeBtn.Text = "□"; isMaximized = false
            end
        end)

        local function createLoopToggle(btn, startText, stopText, remote, args, getIsActive, setActive, notifyText)
            local thread = nil
            local origColor = Color3.fromRGB(60, 160, 60)
            local activeColor = Color3.fromRGB(200, 50, 50)
            local function loop()
                while getIsActive() do
                    if #args > 0 then remote:FireServer(unpack(args)) else remote:FireServer() end
                    task.wait(0.05)
                end
            end
            btn.MouseButton1Click:Connect(function()
                if getIsActive() then
                    setActive(false); btn.Text = startText; btn.BackgroundColor3 = origColor
                else
                    setActive(true); btn.Text = stopText; btn.BackgroundColor3 = activeColor
                    thread = task.spawn(loop)
                    showNotification(notifyText, "", 2)
                end
            end)
            addToggleHover(btn, getIsActive, activeColor)
        end

        local isWaterActive = false
        createLoopToggle(waterBtn, lang.waterStart, lang.waterStop, remoteBucketUsed, {}, function() return isWaterActive end, function(v) isWaterActive = v end, lang.waterOn)

        local isInteractActive = false
        local originalData = {}
        local descendantAddedConn = nil
        local function modifyPrompt(prompt, enable)
            if enable then
                if not originalData[prompt] then originalData[prompt] = { Distance = prompt.MaxActivationDistance, HoldDuration = prompt.HoldDuration } end
                prompt.MaxActivationDistance = math.huge; prompt.HoldDuration = 0
            else
                local data = originalData[prompt]
                if data and prompt and prompt.Parent then prompt.MaxActivationDistance = data.Distance; prompt.HoldDuration = data.HoldDuration end
            end
        end
        local function processAllPrompts(enable)
            for _, obj in ipairs(Workspace:GetDescendants()) do if obj:IsA("ProximityPrompt") then modifyPrompt(obj, enable) end end
        end
        local function onDescendantAdded(descendant)
            if descendant:IsA("ProximityPrompt") then modifyPrompt(descendant, true) end
        end
        interactBtn.MouseButton1Click:Connect(function()
            isInteractActive = not isInteractActive
            if isInteractActive then
                interactBtn.Text = lang.interactStop; interactBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                processAllPrompts(true); descendantAddedConn = Workspace.DescendantAdded:Connect(onDescendantAdded)
                showNotification(lang.interactOn, "", 2)
            else
                interactBtn.Text = lang.interactStart; interactBtn.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
                if descendantAddedConn then descendantAddedConn:Disconnect(); descendantAddedConn = nil end
                for prompt, data in pairs(originalData) do if prompt and prompt.Parent then prompt.MaxActivationDistance = data.Distance; prompt.HoldDuration = data.HoldDuration end end
                originalData = {}
            end
        end)
        addToggleHover(interactBtn, function() return isInteractActive end, Color3.fromRGB(200, 50, 50))

        local isSell1Active = false
        createLoopToggle(sell1Btn, lang.sell1, lang.sell1Stop, remoteBucketPoured, {sell1Prompt}, function() return isSell1Active end, function(v) isSell1Active = v end, lang.sell1On)
        local isChestActive = false
        createLoopToggle(chestBtn, lang.chest, lang.chestStop, remoteChestOpen, {chestPart}, function() return isChestActive end, function(v) isChestActive = v end, lang.chestOn)
        local isSell2Active = false
        createLoopToggle(sell2Btn, lang.sell2, lang.sell2Stop, remoteBucketPoured, {sell2Prompt}, function() return isSell2Active end, function(v) isSell2Active = v end, lang.sell2On)

        RunService.Heartbeat:Connect(function()
            local hue = (tick() * 0.5) % 1
            local color = Color3.fromHSV(hue, 1, 1)
            mainStroke.Color = color; floatStroke.Color = color
        end)
    end
    createMainGui()
end
function loadMusketRobot() end
function loadAnimalHospital() end

createLanguageSelection()
