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
function loadDrainLake() end
function loadMusketRobot() end
function loadAnimalHospital() end

createLanguageSelection()
