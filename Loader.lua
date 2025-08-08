function Notify(Title, Text, Duration, AllowIcon , Type)
    local ID = "rbxassetid://0"

    if AllowIcon == true then
        if Type == "Incorrect" then
            ID = "rbxassetid://76158329070538"
        end
        if Type == "Correct" then
            ID = "rbxassetid://86326453570125"
        end
        if Type == "Mobile" then
            ID = "rbxassetid://102823779517881"
        end
        if Type == "PC" then
            ID = "rbxassetid://121599643825209"
        end
        if Type == "Loading" then
            ID = "rbxassetid://86828340832955"
        end
        if Type == "Notice" then  
            ID = "rbxassetid://80875848007870"
        end
    end

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Icon = ID,
        Duration = Duration
    })
end

Notify("Error!", "Outdated Script Please join discord!!", 9e9, true, "Incorrect")
Notify("Error!", "Copied the discord link!", 9e9, true, "Incorrect")
setclipboard("https://discord.gg/hgyGpQwSPa")
