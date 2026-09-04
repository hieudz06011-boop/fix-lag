--========================================================--
--      GROW A GARDEN - FPS / LAG OPTIMIZER              --
--                    SINGLE SCRIPT                       --
--========================================================--

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

--========================================================--
-- CONFIG
--========================================================--

local Config = {
    HidePlants = false,
    HideFruits = false,
    RemoveDecorations = false,
    HidePets = false,

    PetEffects = true,

    LowGraphics = true,
    DisableVFX = true,
    DisableShadows = true
}

local Changed = {}

local OriginalGlobalShadows =
    Lighting.GlobalShadows

local OriginalQuality

pcall(function()
    OriginalQuality =
        settings().Rendering.QualityLevel
end)

--========================================================--
-- GUI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "GAG_Optimizer"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player:WaitForChild("PlayerGui")

--========================================================--
-- MAIN
--========================================================--

local Main = Instance.new("Frame")
Main.Name = "Optimizer"
Main.Size = UDim2.fromOffset(360,500)
Main.Position =
    UDim2.new(0.5,-180,0.5,-250)

Main.BackgroundColor3 =
    Color3.fromRGB(24,24,24)

Main.BorderSizePixel = 0
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius =
    UDim.new(0,10)

--========================================================--
-- TOP BAR
--========================================================--

local Top = Instance.new("Frame")
Top.Size =
    UDim2.new(1,0,0,45)

Top.BackgroundColor3 =
    Color3.fromRGB(35,35,35)

Top.BorderSizePixel = 0
Top.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size =
    UDim2.new(1,-90,1,0)

Title.Position =
    UDim2.fromOffset(12,0)

Title.BackgroundTransparency = 1
Title.Text =
    "🌱 Grow a Garden • Optimizer"

Title.TextColor3 =
    Color3.new(1,1,1)

Title.TextSize = 15
Title.Font =
    Enum.Font.GothamBold

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.Parent = Top

--========================================================--
-- MINIMIZE
--========================================================--

local Minimize = Instance.new("TextButton")

Minimize.Size =
    UDim2.fromOffset(40,40)

Minimize.Position =
    UDim2.new(1,-85,0,2)

Minimize.BackgroundTransparency = 1

Minimize.Text = "−"

Minimize.TextColor3 =
    Color3.new(1,1,1)

Minimize.TextSize = 25
Minimize.Font =
    Enum.Font.GothamBold

Minimize.Parent = Top

--========================================================--
-- CLOSE
--========================================================--

local Close = Instance.new("TextButton")

Close.Size =
    UDim2.fromOffset(40,40)

Close.Position =
    UDim2.new(1,-45,0,2)

Close.BackgroundTransparency = 1

Close.Text = "×"

Close.TextColor3 =
    Color3.new(1,1,1)

Close.TextSize = 24
Close.Font =
    Enum.Font.GothamBold

Close.Parent = Top

--========================================================--
-- CONTENT
--========================================================--

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.Size =
    UDim2.new(1,0,1,-45)

Content.Position =
    UDim2.fromOffset(0,45)

Content.BackgroundTransparency = 1

Content.Parent = Main

--========================================================--
-- BUTTON
--========================================================--

local function CreateButton(Text,Y)

    local B = Instance.new("TextButton")

    B.Size =
        UDim2.new(1,-30,0,42)

    B.Position =
        UDim2.fromOffset(15,Y)

    B.BackgroundColor3 =
        Color3.fromRGB(45,45,45)

    B.BorderSizePixel = 0

    B.Text = Text

    B.TextColor3 =
        Color3.new(1,1,1)

    B.TextSize = 12

    B.Font =
        Enum.Font.GothamBold

    B.Parent = Content

    Instance.new("UICorner",B).CornerRadius =
        UDim.new(0,7)

    return B
end

--========================================================--
-- BUTTONS
--========================================================--

local PlantButton =
    CreateButton(
        "🌱 Hide Plants: OFF",
        15
    )

local FruitButton =
    CreateButton(
        "🍎 Hide Fruits: OFF",
        63
    )

local DecorationButton =
    CreateButton(
        "🪑 Remove Decorations: OFF",
        111
    )

local PetButton =
    CreateButton(
        "🐾 Hide Pets: OFF",
        159
    )

local PetEffectButton =
    CreateButton(
        "🫧 Pet Rays / Orbs: ON",
        207
    )

local GraphicsButton =
    CreateButton(
        "🎨 Low Graphics: ON",
        255
    )

local VFXButton =
    CreateButton(
        "✨ Disable VFX: ON",
        303
    )

local ShadowButton =
    CreateButton(
        "🌑 Disable Shadows: ON",
        351
    )

local ResetButton =
    CreateButton(
        "🔄 Reset",
        399
    )

--========================================================--
-- WORD CHECK
--========================================================--

local function HasWord(Name,List)

    Name =
        string.lower(tostring(Name))

    for _,Word in ipairs(List) do

        if string.find(
            Name,
            string.lower(Word),
            1,
            true
        ) then

            return true

        end

    end

    return false
end

--========================================================--
-- PLANTS
--========================================================--

local PlantWords = {

    "plant",
    "plants",
    "crop",
    "crops",
    "tree",
    "flower",
    "flowering",
    "bush",
    "shrub",
    "seedling",
    "farmplant",
    "grownplant",
    "gardenplant"

}

--========================================================--
-- FRUITS
--========================================================--

local FruitWords = {

    "fruit",
    "apple",
    "banana",
    "mango",
    "coconut",
    "blueberry",
    "strawberry",
    "grape",
    "watermelon",
    "pumpkin",
    "carrot",
    "tomato",
    "corn",
    "cactus",
    "pineapple",
    "pear",
    "peach",
    "avocado",
    "lemon",
    "orange"

}

--========================================================--
-- DECORATIONS / FURNITURE / INTERIOR
--========================================================--

local DecorationWords = {

    -- General
    "decor",
    "decoration",
    "decorations",
    "decorationmodel",
    "ornament",
    "ornaments",
    "prop",
    "props",
    "interior",
    "interiors",
    "furniture",

    -- Furniture
    "chair",
    "chairs",
    "bench",
    "benches",
    "table",
    "tables",
    "sofa",
    "couch",
    "seat",
    "stool",
    "shelf",
    "shelves",
    "cabinet",
    "drawer",

    -- Garden
    "fountain",
    "statue",
    "sculpture",
    "pond",
    "gardenpond",
    "gardenrock",
    "gardenstone",
    "rock",
    "stone",

    -- Lighting
    "lamp",
    "lamps",
    "lantern",
    "lanterns",
    "light",
    "lights",
    "gardenlight",
    "streetlight",

    -- Decoration
    "sign",
    "signs",
    "flag",
    "flags",
    "banner",
    "banners",
    "ornament",
    "flowerpot",
    "plantpot",
    "pot",
    "pots",
    "vase",
    "vases",

    -- Structure
    "fence",
    "fences",
    "gate",
    "gates",
    "arch",
    "pillar",
    "wall",
    "carpet",
    "rug",

    -- Extra
    "toy",
    "toys",
    "present",
    "gift",
    "balloon",
    "balloons",
    "mailbox",
    "well",
    "bridge"

}

--========================================================--
-- PET NAMES
--========================================================--

local PetWords = {

    -- Special
    "dilo",
    "rainbowdilo",
    "rainbow dilo",

    "thunderbirb",
    "thunderbird",
    "rainbowthunderbirb",
    "rainbow thunder birb",
    "rainbow thunder bird",

    -- General
    "pet",
    "pets",

    -- Common pets
    "dog",
    "cat",
    "bunny",
    "rabbit",
    "bee",
    "dragon",
    "monkey",
    "fox",
    "chicken",
    "bear",
    "parrot",
    "penguin",
    "lion",
    "peacock",
    "griffin",
    "french fry",
    "frenchfry",
    "hot dog",
    "hotdog"

}

--========================================================--
-- PET EFFECT NAMES
--========================================================--

local PetEffectWords = {

    "effect",
    "effects",
    "vfx",
    "ray",
    "rays",
    "beam",
    "beams",
    "trail",
    "trails",
    "particle",
    "particles",
    "aura",
    "orb",
    "orbs",
    "sphere",
    "ball",
    "bubble",
    "circle",
    "ring",
    "rings",
    "glow",
    "laser",
    "halo",
    "shockwave"

}

--========================================================--
-- SAVE
--========================================================--

local function Save(Object,Type)

    if Changed[Object] then
        return
    end

    if Object:IsA("BasePart") then

        Changed[Object] = {

            Type = "Part",

            Transparency =
                Object.Transparency,

            LTM =
                Object.LocalTransparencyModifier,

            CastShadow =
                Object.CastShadow,

            CanCollide =
                Object.CanCollide,

            CanTouch =
                Object.CanTouch,

            CanQuery =
                Object.CanQuery
        }

    elseif Object:IsA("Decal")
        or Object:IsA("Texture") then

        Changed[Object] = {

            Type = "Texture",

            Transparency =
                Object.Transparency
        }

    elseif Object:IsA("ParticleEmitter")
        or Object:IsA("Trail")
        or Object:IsA("Beam")
        or Object:IsA("Smoke")
        or Object:IsA("Fire")
        or Object:IsA("Sparkles") then

        Changed[Object] = {

            Type = "Effect",

            Enabled =
                Object.Enabled
        }

    end

end

--========================================================--
-- HIDE
--========================================================--

local function Hide(Object)

    if not Object then
        return
    end

    if Object:IsA("BasePart") then

        Save(Object,"Part")

        Object.LocalTransparencyModifier = 1
        Object.CastShadow = false

    elseif Object:IsA("Decal")
        or Object:IsA("Texture") then

        Save(Object,"Texture")

        Object.Transparency = 1

    elseif Object:IsA("ParticleEmitter")
        or Object:IsA("Trail")
        or Object:IsA("Beam")
        or Object:IsA("Smoke")
        or Object:IsA("Fire")
        or Object:IsA("Sparkles") then

        Save(Object,"Effect")

        Object.Enabled = false

    end

end

--========================================================--
-- HIDE MODEL
--========================================================--

local function HideModel(Model)

    if not Model then
        return
    end

    if Model:IsA("BasePart") then

        Hide(Model)
        return

    end

    for _,Object in ipairs(
        Model:GetDescendants()
    ) do

        Hide(Object)

    end

end

--========================================================--
-- PET DETECTION
--========================================================--

local function IsPetObject(Object)

    local Name =
        string.lower(Object.Name)

    -- Tên chính nó
    if HasWord(Name,PetWords) then
        return true
    end

    -- Kiểm tra tên các parent
    local Parent = Object.Parent
    local Count = 0

    while Parent
        and Parent ~= Workspace
        and Count < 5 do

        if HasWord(
            Parent.Name,
            PetWords
        ) then

            return true

        end

        Parent = Parent.Parent
        Count += 1

    end

    return false
end

--========================================================--
-- PET RAY / ORB
--========================================================--

local function OptimizePetRay(Object)

    if not Config.PetEffects then
        return
    end

    local Name =
        string.lower(Object.Name)

    --------------------------------------------------------
    -- PARTICLE / BEAM / TRAIL
    --------------------------------------------------------

    if Object:IsA("ParticleEmitter")
        or Object:IsA("Beam")
        or Object:IsA("Trail") then

        -- Chỉ ưu tiên effect thuộc pet
        if IsPetObject(Object.Parent)
            or HasWord(Name,PetEffectWords) then

            Hide(Object)

        end

        return

    end

    --------------------------------------------------------
    -- QUẢ CẦU / ORB / SPHERE
    --------------------------------------------------------

    if Object:IsA("BasePart") then

        local IsBall = false

        pcall(function()

            IsBall =
                Object.Shape ==
                Enum.PartType.Ball

        end)

        local NamedEffect =
            HasWord(
                Name,
                PetEffectWords
            )

        local Transparent =
            Object.Transparency >= 0.10

        local ParentIsPet =
            IsPetObject(Object.Parent)

        if IsBall
            or NamedEffect
            or (
                Transparent
                and ParentIsPet
            ) then

            Save(Object,"Part")

            Object.LocalTransparencyModifier = 1

            Object.CastShadow = false

            Object.CanCollide = false
            Object.CanTouch = false
            Object.CanQuery = false

        end

    end

end

--========================================================--
-- PET MODEL
--========================================================--

local function HidePet(Object)

    if not Config.HidePets then
        return
    end

    if Object:IsA("Model")
        or Object:IsA("BasePart") then

        if IsPetObject(Object) then

            HideModel(Object)

        end

    end

end

--========================================================--
-- REMOVE DECOR
--========================================================--

local function IsGameplayObject(Name)

    local GameplayWords = {

        "plant",
        "crop",
        "fruit",
        "pet",
        "seed",
        "egg",
        "sprinkler",
        "gear",
        "tool",
        "mutation",
        "harvest",
        "farm",
        "plot",
        "player",
        "character"

    }

    return HasWord(
        Name,
        GameplayWords
    )

end

local function RemoveDecoration(Object)

    if not Config.RemoveDecorations then
        return
    end

    if not Object:IsA("Model") then
        return
    end

    local Name =
        string.lower(Object.Name)

    if IsGameplayObject(Name) then
        return
    end

    if HasWord(
        Name,
        DecorationWords
    ) then

        pcall(function()

            Object:Destroy()

        end)

    end

end

--========================================================--
-- SCAN
--========================================================--

local function Scan()

    local Objects =
        Workspace:GetDescendants()

    for Index,Object in ipairs(Objects) do

        if not Object
            or not Object.Parent then

            continue

        end

        local Name =
            Object.Name

        ----------------------------------------------------
        -- PLANT
        ----------------------------------------------------

        if Config.HidePlants
            and HasWord(
                Name,
                PlantWords
            ) then

            HideModel(Object)

        end

        ----------------------------------------------------
        -- FRUIT
        ----------------------------------------------------

        if Config.HideFruits
            and HasWord(
                Name,
                FruitWords
            ) then

            HideModel(Object)

        end

        ----------------------------------------------------
        -- PET
        ----------------------------------------------------

        if Config.HidePets then

            HidePet(Object)

        end

        ----------------------------------------------------
        -- PET RAY
        ----------------------------------------------------

        if Config.PetEffects then

            OptimizePetRay(Object)

        end

        ----------------------------------------------------
        -- VFX
        ----------------------------------------------------

        if Config.DisableVFX then

            if Object:IsA("ParticleEmitter")
                or Object:IsA("Trail")
                or Object:IsA("Beam")
                or Object:IsA("Smoke")
                or Object:IsA("Fire")
                or Object:IsA("Sparkles") then

                Hide(Object)

            end

        end

        ----------------------------------------------------
        -- DECOR
        ----------------------------------------------------

        if Config.RemoveDecorations then

            RemoveDecoration(Object)

        end

        ----------------------------------------------------
        -- THROTTLE
        ----------------------------------------------------

        if Index % 250 == 0 then
            task.wait()
        end

    end

end

--========================================================--
-- AUTO DETECTION
--========================================================--

Workspace.DescendantAdded:Connect(
    function(Object)

        task.defer(function()

            if not Object
                or not Object.Parent then

                return

            end

            local Name =
                Object.Name

            ------------------------------------------------
            -- PLANT
            ------------------------------------------------

            if Config.HidePlants
                and HasWord(
                    Name,
                    PlantWords
                ) then

                HideModel(Object)

            end

            ------------------------------------------------
            -- FRUIT
            ------------------------------------------------

            if Config.HideFruits
                and HasWord(
                    Name,
                    FruitWords
                ) then

                HideModel(Object)

            end

            ------------------------------------------------
            -- PET
            ------------------------------------------------

            if Config.HidePets then

                HidePet(Object)

            end

            ------------------------------------------------
            -- PET EFFECT
            ------------------------------------------------

            if Config.PetEffects then

                OptimizePetRay(Object)

            end

            ------------------------------------------------
            -- VFX
            ------------------------------------------------

            if Config.DisableVFX then

                if Object:IsA("ParticleEmitter")
                    or Object:IsA("Trail")
                    or Object:IsA("Beam")
                    or Object:IsA("Smoke")
                    or Object:IsA("Fire")
                    or Object:IsA("Sparkles") then

                    Hide(Object)

                end

            end

            ------------------------------------------------
            -- DECOR
            ------------------------------------------------

            if Config.RemoveDecorations then

                RemoveDecoration(Object)

            end

        end)

    end
)

--========================================================--
-- GRAPHICS
--========================================================--

local function ApplyGraphics()

    if not Config.LowGraphics then
        return
    end

    pcall(function()

        settings().Rendering.QualityLevel =
            Enum.QualityLevel.Level01

    end)

    for _,Object in ipairs(
        Lighting:GetChildren()
    ) do

        if Object:IsA("PostEffect") then

            Save(Object,"Effect")

            Object.Enabled = false

        end

    end

end

--========================================================--
-- VFX
--========================================================--

local function ApplyVFX()

    if not Config.DisableVFX then
        return
    end

    for _,Object in ipairs(
        Workspace:GetDescendants()
    ) do

        if Object:IsA("ParticleEmitter")
            or Object:IsA("Trail")
            or Object:IsA("Beam")
            or Object:IsA("Smoke")
            or Object:IsA("Fire")
            or Object:IsA("Sparkles") then

            Hide(Object)

        end

    end

end

--========================================================--
-- SHADOW
--========================================================--

local function ApplyShadows()

    if not Config.DisableShadows then
        return
    end

    Lighting.GlobalShadows = false

    for _,Object in ipairs(
        Workspace:GetDescendants()
    ) do

        if Object:IsA("BasePart") then

            Save(Object,"Part")

            Object.CastShadow = false

        end

    end

end

--========================================================--
-- OPTIMIZE
--========================================================--

local function Optimize()

    ApplyGraphics()
    ApplyVFX()
    ApplyShadows()
    Scan()

end

--========================================================--
-- BUTTON EVENTS
--========================================================--

PlantButton.MouseButton1Click:Connect(
    function()

        Config.HidePlants =
            not Config.HidePlants

        PlantButton.Text =
            Config.HidePlants
            and "🌱 Hide Plants: ON"
            or "🌱 Hide Plants: OFF"

        Scan()

    end
)

FruitButton.MouseButton1Click:Connect(
    function()

        Config.HideFruits =
            not Config.HideFruits

        FruitButton.Text =
            Config.HideFruits
            and "🍎 Hide Fruits: ON"
            or "🍎 Hide Fruits: OFF"

        Scan()

    end
)

DecorationButton.MouseButton1Click:Connect(
    function()

        Config.RemoveDecorations =
            not Config.RemoveDecorations

        DecorationButton.Text =
            Config.RemoveDecorations
            and "🪑 Remove Decorations: ON"
            or "🪑 Remove Decorations: OFF"

        if Config.RemoveDecorations then
            Scan()
        end

    end
)

PetButton.MouseButton1Click:Connect(
    function()

        Config.HidePets =
            not Config.HidePets

        PetButton.Text =
            Config.HidePets
            and "🐾 Hide Pets: ON"
            or "🐾 Hide Pets: OFF"

        Scan()

    end
)

PetEffectButton.MouseButton1Click:Connect(
    function()

        Config.PetEffects =
            not Config.PetEffects

        PetEffectButton.Text =
            Config.PetEffects
            and "🫧 Pet Rays / Orbs: ON"
            or "🫧 Pet Rays / Orbs: OFF"

        Scan()

    end
)

GraphicsButton.MouseButton1Click:Connect(
    function()

        Config.LowGraphics =
            not Config.LowGraphics

        GraphicsButton.Text =
            Config.LowGraphics
            and "🎨 Low Graphics: ON"
            or "🎨 Low Graphics: OFF"

        ApplyGraphics()

    end
)

VFXButton.MouseButton1Click:Connect(
    function()

        Config.DisableVFX =
            not Config.DisableVFX

        VFXButton.Text =
            Config.DisableVFX
            and "✨ Disable VFX: ON"
            or "✨ Disable VFX: OFF"

        ApplyVFX()

    end
)

ShadowButton.MouseButton1Click:Connect(
    function()

        Config.DisableShadows =
            not Config.DisableShadows

        ShadowButton.Text =
            Config.DisableShadows
            and "🌑 Disable Shadows: ON"
            or "🌑 Disable Shadows: OFF"

        ApplyShadows()

    end
)

--========================================================--
-- RESET
--========================================================--

ResetButton.MouseButton1Click:Connect(
    function()

        for Object,Data in pairs(Changed) do

            if Object
                and Object.Parent then

                if Data.Type == "Part" then

                    Object.Transparency =
                        Data.Transparency

                    Object.LocalTransparencyModifier =
                        Data.LTM

                    Object.CastShadow =
                        Data.CastShadow

                    Object.CanCollide =
                        Data.CanCollide

                    Object.CanTouch =
                        Data.CanTouch

                    Object.CanQuery =
                        Data.CanQuery

                elseif Data.Type == "Texture" then

                    Object.Transparency =
                        Data.Transparency

                elseif Data.Type == "Effect" then

                    Object.Enabled =
                        Data.Enabled

                end

            end

        end

        table.clear(Changed)

        Lighting.GlobalShadows =
            OriginalGlobalShadows

        pcall(function()

            if OriginalQuality then

                settings().Rendering.QualityLevel =
                    OriginalQuality

            end

        end)

        Config.HidePlants = false
        Config.HideFruits = false
        Config.HidePets = false
        Config.PetEffects = false
        Config.LowGraphics = false
        Config.DisableVFX = false
        Config.DisableShadows = false

        PlantButton.Text =
            "🌱 Hide Plants: OFF"

        FruitButton.Text =
            "🍎 Hide Fruits: OFF"

        DecorationButton.Text =
            "🪑 Remove Decorations: OFF"

        PetButton.Text =
            "🐾 Hide Pets: OFF"

        PetEffectButton.Text =
            "🫧 Pet Rays / Orbs: OFF"

        GraphicsButton.Text =
            "🎨 Low Graphics: OFF"

        VFXButton.Text =
            "✨ Disable VFX: OFF"

        ShadowButton.Text =
            "🌑 Disable Shadows: OFF"

    end
)

--========================================================--
-- MINIMIZE / EXPAND
--========================================================--

local ExpandedSize =
    UDim2.fromOffset(360,500)

local MinimizedSize =
    UDim2.fromOffset(360,45)

local Minimized = false

Minimize.MouseButton1Click:Connect(
    function()

        Minimized =
            not Minimized

        if Minimized then

            Main.Size =
                MinimizedSize

            Minimize.Text = "+"

            -- ẨN TOÀN BỘ NÚT OPTIMIZER
            Content.Visible = false

        else

            Main.Size =
                ExpandedSize

            Minimize.Text = "−"

            -- HIỆN LẠI TOÀN BỘ
            Content.Visible = true

        end

    end
)

--========================================================--
-- MAIN DRAG
--========================================================--

local Dragging = false
local DragStart
local StartPos

Top.InputBegan:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1 then

            Dragging = true

            DragStart =
                Input.Position

            StartPos =
                Main.Position

        end

    end
)

UIS.InputChanged:Connect(
    function(Input)

        if Dragging
            and Input.UserInputType ==
            Enum.UserInputType.MouseMovement then

            local Delta =
                Input.Position -
                DragStart

            Main.Position =
                UDim2.new(

                    StartPos.X.Scale,
                    StartPos.X.Offset +
                        Delta.X,

                    StartPos.Y.Scale,
                    StartPos.Y.Offset +
                        Delta.Y
                )

        end

    end
)

UIS.InputEnded:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1 then

            Dragging = false

        end

    end
)

Close.MouseButton1Click:Connect(
    function()

        Main.Visible = false

    end
)

--========================================================--
-- PERFORMANCE MONITOR
--========================================================--

local Monitor =
    Instance.new("Frame")

Monitor.Name =
    "PerformanceMonitor"

Monitor.Size =
    UDim2.fromOffset(210,145)

Monitor.Position =
    UDim2.fromOffset(20,20)

Monitor.BackgroundColor3 =
    Color3.fromRGB(20,20,20)

Monitor.BorderSizePixel = 0
Monitor.Parent = Gui

Instance.new("UICorner",Monitor).CornerRadius =
    UDim.new(0,8)

--========================================================--
-- MONITOR TOP
--========================================================--

local MonitorTop =
    Instance.new("Frame")

MonitorTop.Size =
    UDim2.new(1,0,0,30)

MonitorTop.BackgroundColor3 =
    Color3.fromRGB(35,35,35)

MonitorTop.BorderSizePixel = 0
MonitorTop.Parent = Monitor

local MonitorTitle =
    Instance.new("TextLabel")

MonitorTitle.Size =
    UDim2.new(1,-35,1,0)

MonitorTitle.Position =
    UDim2.fromOffset(8,0)

MonitorTitle.BackgroundTransparency = 1

MonitorTitle.Text =
    "📊 Performance"

MonitorTitle.TextColor3 =
    Color3.new(1,1,1)

MonitorTitle.TextSize = 13
MonitorTitle.Font =
    Enum.Font.GothamBold

MonitorTitle.TextXAlignment =
    Enum.TextXAlignment.Left

MonitorTitle.Parent =
    MonitorTop

--========================================================--
-- MONITOR X
--========================================================--

local MonitorClose =
    Instance.new("TextButton")

MonitorClose.Size =
    UDim2.fromOffset(30,30)

MonitorClose.Position =
    UDim2.new(1,-30,0,0)

MonitorClose.BackgroundTransparency = 1

MonitorClose.Text = "×"

MonitorClose.TextColor3 =
    Color3.new(1,1,1)

MonitorClose.TextSize = 20
MonitorClose.Font =
    Enum.Font.GothamBold

MonitorClose.Parent =
    MonitorTop

MonitorClose.MouseButton1Click:Connect(
    function()

        Monitor.Visible = false

    end
)

--========================================================--
-- MONITOR TEXT
--========================================================--

local MonitorText =
    Instance.new("TextLabel")

MonitorText.Size =
    UDim2.new(1,-20,1,-38)

MonitorText.Position =
    UDim2.fromOffset(10,35)

MonitorText.BackgroundTransparency = 1

MonitorText.TextColor3 =
    Color3.new(1,1,1)

MonitorText.TextSize = 12
MonitorText.Font =
    Enum.Font.Code

MonitorText.TextXAlignment =
    Enum.TextXAlignment.Left

MonitorText.TextYAlignment =
    Enum.TextYAlignment.Top

MonitorText.Text =
    "FPS : --\nCPU : --\nRAM : --\nPING: --"

MonitorText.Parent =
    Monitor

--========================================================--
-- PERFORMANCE
--========================================================--

local Frames = 0
local LastTime = os.clock()
local FPS = 0

RunService.RenderStepped:Connect(
    function()

        Frames += 1

        local Now =
            os.clock()

        if Now - LastTime >= 1 then

            FPS =
                Frames /
                (Now - LastTime)

            Frames = 0
            LastTime = Now

            local RAM = 0
            local Ping = 0

            pcall(function()

                RAM =
                    Stats:GetTotalMemoryUsageMb()

            end)

            pcall(function()

                local Network =
                    Stats:FindFirstChild(
                        "Network"
                    )

                if Network then

                    local ServerStats =
                        Network:FindFirstChild(
                            "ServerStatsItem"
                        )

                    if ServerStats then

                        local PingItem =
                            ServerStats:FindFirstChild(
                                "Data Ping"
                            )

                        if PingItem then

                            Ping =
                                PingItem:GetValue()

                        end

                    end

                end

            end)

            -- CPU chỉ là ước lượng workload
            -- của client, không phải CPU Windows thật.

            local CPU =
                math.clamp(

                    math.floor(

                        (
                            1 -
                            math.clamp(
                                FPS / 60,
                                0,
                                1
                            )
                        ) * 100

                    ),

                    0,
                    100
                )

            MonitorText.Text =
                string.format(

                    "FPS : %d\nCPU : ~%d%%\nRAM : %.0f MB\nPING: %.0f ms",

                    math.floor(
                        FPS + 0.5
                    ),

                    CPU,
                    RAM,
                    Ping
                )

        end

    end
)

--========================================================--
-- MONITOR DRAG
--========================================================--

local MonitorDragging = false
local MonitorDragStart
local MonitorStartPos

MonitorTop.InputBegan:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1 then

            MonitorDragging = true

            MonitorDragStart =
                Input.Position

            MonitorStartPos =
                Monitor.Position

        end

    end
)

UIS.InputChanged:Connect(
    function(Input)

        if MonitorDragging
            and Input.UserInputType ==
            Enum.UserInputType.MouseMovement then

            local Delta =
                Input.Position -
                MonitorDragStart

            Monitor.Position =
                UDim2.new(

                    MonitorStartPos.X.Scale,

                    MonitorStartPos.X.Offset +
                        Delta.X,

                    MonitorStartPos.Y.Scale,

                    MonitorStartPos.Y.Offset +
                        Delta.Y
                )

        end

    end
)

UIS.InputEnded:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1 then

            MonitorDragging = false

        end

    end
)

--========================================================--
-- START
--========================================================--

Optimize()

Main.Visible = true
Monitor.Visible = true

print("========================================")
print(" GAG OPTIMIZER LOADED")
print(" Hide Plants       : READY")
print(" Hide Fruits       : READY")
print(" Remove Decorations: READY")
print(" Hide Pets         : READY")
print(" Pet Rays / Orbs   : READY")
print(" Performance       : READY")
print("========================================")
