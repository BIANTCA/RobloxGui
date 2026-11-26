local BulbGui = {}
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TVersion = 6.0

local THEMES = {
	{Name = "Obsidian Cyber", bg950 = "#050810", bg900 = "#0A0F1C", bg850 = "#0F1629", bg800 = "#141D35", border = "#1E293B", acc = "#06B6D4", acc2 = "#6366F1"},
	{Name = "Emerald Matrix", bg950 = "#040A08", bg900 = "#08120F", bg850 = "#0D1B17", bg800 = "#12251F", border = "#1B362D", acc = "#10B981", acc2 = "#14B8A6"},
	{Name = "Midnight Crimson", bg950 = "#0B0507", bg900 = "#14090D", bg850 = "#1D0E14", bg800 = "#27131B", border = "#3B1D29", acc = "#F43F5E", acc2 = "#F59E0B"},
	{Name = "Royal Violet", bg950 = "#08060F", bg900 = "#0F0B1C", bg850 = "#161129", bg800 = "#1E1736", border = "#2E2450", acc = "#A855F7", acc2 = "#EC4899"},
	{Name = "Sunset Amber", bg950 = "#0A0705", bg900 = "#130D08", bg850 = "#1C130C", bg800 = "#261A11", border = "#3A2818", acc = "#F59E0B", acc2 = "#EF4444"},
	{Name = "Ocean Deep", bg950 = "#040A12", bg900 = "#08111D", bg850 = "#0C1828", bg800 = "#112035", border = "#1B3250", acc = "#3B82F6", acc2 = "#06B6D4"},
	{Name = "Rose Quartz", bg950 = "#0C0609", bg900 = "#160B11", bg850 = "#20101A", bg800 = "#2B1523", border = "#43213A", acc = "#EC4899", acc2 = "#A855F7"},
	{Name = "Arctic Frost", bg950 = "#060B10", bg900 = "#0B131B", bg850 = "#101C27", bg800 = "#162636", border = "#223A50", acc = "#7DD3FC", acc2 = "#A5B4FC"},
	{Name = "Toxic Lime", bg950 = "#060A04", bg900 = "#0C1308", bg850 = "#131D0D", bg800 = "#1A2812", border = "#2A3F1C", acc = "#84CC16", acc2 = "#FACC15"},
	{Name = "Neon Magenta", bg950 = "#0A040C", bg900 = "#130718", bg850 = "#1C0B24", bg800 = "#260F31", border = "#3D1A4E", acc = "#D946EF", acc2 = "#22D3EE"},
	{Name = "Graphite Mono", bg950 = "#060606", bg900 = "#0E0E0F", bg850 = "#151516", bg800 = "#1D1D1F", border = "#2C2C2F", acc = "#E4E4E7", acc2 = "#A1A1AA"},
	{Name = "Golden Noir", bg950 = "#090705", bg900 = "#120E08", bg850 = "#1B150C", bg800 = "#251D11", border = "#3A2E19", acc = "#EAB308", acc2 = "#F97316"},
	{Name = "Crimson Blood", bg950 = "#0A0404", bg900 = "#140808", bg850 = "#1E0C0C", bg800 = "#281111", border = "#401B1B", acc = "#DC2626", acc2 = "#F97316"},
	{Name = "Mint Breeze", bg950 = "#050A0A", bg900 = "#0A1313", bg850 = "#0F1C1C", bg800 = "#152626", border = "#213B3B", acc = "#5EEAD4", acc2 = "#86EFAC"},
	{Name = "Indigo Night", bg950 = "#05060F", bg900 = "#0A0C1C", bg850 = "#0F1229", bg800 = "#151937", border = "#232A56", acc = "#6366F1", acc2 = "#8B5CF6"},
	{Name = "Cherry Blossom", bg950 = "#0B0709", bg900 = "#150E12", bg850 = "#1F151B", bg800 = "#291C24", border = "#40293A", acc = "#F9A8D4", acc2 = "#FDA4AF"},
	{Name = "Copper Rust", bg950 = "#0A0605", bg900 = "#140D0A", bg850 = "#1D1410", bg800 = "#281C16", border = "#3F2C22", acc = "#FB923C", acc2 = "#D97706"},
	{Name = "Cyber Yellow", bg950 = "#0A0A04", bg900 = "#131308", bg850 = "#1C1C0D", bg800 = "#262612", border = "#3D3D1B", acc = "#FDE047", acc2 = "#22D3EE"},
	{Name = "Aurora Teal", bg950 = "#040B0D", bg900 = "#08141A", bg850 = "#0D1E26", bg800 = "#122831", border = "#1D3F4D", acc = "#2DD4BF", acc2 = "#818CF8"},
	{Name = "Slate Steel", bg950 = "#070A0E", bg900 = "#0D121A", bg850 = "#131A25", bg800 = "#1A2332", border = "#2A374B", acc = "#94A3B8", acc2 = "#38BDF8"},
}

local T = {
	text = Color3.fromHex("E2E8F0"),
	white = Color3.fromHex("F8FAFC"),
	dim = Color3.fromHex("94A3B8"),
	dim2 = Color3.fromHex("64748B"),
	ok = Color3.fromHex("34D399"),
	red = Color3.fromHex("F43F5E"),
	redDark = Color3.fromHex("BE123C"),
}

local function setPalette(def)
	for _, k in ipairs({"bg950", "bg900", "bg850", "bg800", "border", "acc", "acc2"}) do
		T[k] = Color3.fromHex(def[k])
	end
	T.soft = T.bg900:Lerp(T.acc, 0.14)
	T.accBorder = T.bg900:Lerp(T.acc, 0.4)
	T.accDark = T.acc:Lerp(Color3.new(0, 0, 0), 0.25)
	T.hover = T.bg850:Lerp(T.acc, 0.08)
end

local function findTheme(name)
	for _, def in ipairs(THEMES) do
		if def.Name == name then return def end
	end
	return THEMES[1]
end
setPalette(THEMES[1])

local bindings = {}
local function bind(inst, prop, src)
	local fn = type(src) == "function" and src or function() return T[src] end
	inst[prop] = fn()
	bindings[#bindings + 1] = {inst, prop, fn}
end

local P = 12
local SB_W, SB_RAIL = 176, 56
local TOP_H = 56
local NAV_Y = TOP_H + 10
local SET_H = 58

local F_B, F_M, F_R, F_C = Enum.Font.GothamBold, Enum.Font.GothamMedium, Enum.Font.Gotham, Enum.Font.Code
local LEFT = Enum.TextXAlignment.Left

local function smoothTween(obj, props, duration)
	local info = TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	TweenService:Create(obj, info, props):Play()
end

local function applyPalette(def, animate)
	setPalette(def)
	for i = #bindings, 1, -1 do
		local b = bindings[i]
		if b[1] and b[1]:IsDescendantOf(game) then
			if animate then
				smoothTween(b[1], {[b[2]] = b[3]()}, 0.3)
			else
				b[1][b[2]] = b[3]()
			end
		else
			table.remove(bindings, i)
		end
	end
end

local function corner(inst, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = inst
	return c
end

local function stroke(inst, src, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	bind(s, "Color", src or "border")
	s.Parent = inst
	return s
end

local function label(parent, props, colorSrc)
	local L = Instance.new("TextLabel")
	L.BackgroundTransparency = 1
	L.BorderSizePixel = 0
	for k, v in pairs(props) do L[k] = v end
	bind(L, "TextColor3", colorSrc or "text")
	L.Parent = parent
	return L
end

local function escapePattern(str)
	return (str:gsub("%p", "%%%0"))
end

local function fmt(v)
	if type(v) ~= "number" then return tostring(v) end
	return tostring(math.floor(v * 1000 + 0.5) / 1000)
end

local function measure(str, size, font)
	return TextService:GetTextSize(tostring(str), size, font, Vector2.new(1000, 40)).X
end

local function makeRow(parent, height)
	local F = Instance.new("Frame")
	F.Size = UDim2.new(1, 0, 0, height)
	F.BorderSizePixel = 0
	bind(F, "BackgroundColor3", parent:GetAttribute("BulbCard") and "bg900" or "bg850")
	F.Parent = parent
	corner(F, 10)
	local S = stroke(F, "border", 1)
	F.MouseEnter:Connect(function() smoothTween(S, {Color = T.accBorder}, 0.15) end)
	F.MouseLeave:Connect(function() smoothTween(S, {Color = T.border}, 0.15) end)
	return F, S
end

local flowOf = setmetatable({}, {__mode = "k"})
local function getFlow(parent)
	local f = flowOf[parent]
	if f and f.Frame.Parent == parent then return f end
	f = {items = {}, rows = {}, lastW = -1}
	local Frame = Instance.new("Frame")
	Frame.Name = "Flow"
	Frame.Size = UDim2.new(1, 0, 0, 0)
	Frame.AutomaticSize = Enum.AutomaticSize.Y
	Frame.BackgroundTransparency = 1
	Frame:SetAttribute("BulbCard", parent:GetAttribute("BulbCard"))
	Frame.Parent = parent
	local FL = Instance.new("UIListLayout")
	FL.Padding = UDim.new(0, 6)
	FL.SortOrder = Enum.SortOrder.LayoutOrder
	FL.Parent = Frame
	f.Frame = Frame

	function f.Relayout()
		local W = Frame.AbsoluteSize.X
		if W <= 0 then return end
		f.lastW = W
		local live = {}
		for _, it in ipairs(f.items) do
			if it.frame.Parent then table.insert(live, it) end
		end
		f.items = live
		local idx, rowIdx = 1, 0
		while idx <= #live do
			local n = 1
			for _, c in ipairs({3, 2}) do
				if idx + c - 1 <= #live then
					local cw = (W - (c - 1) * 6) / c
					local ok = true
					for k = idx, idx + c - 1 do
						if live[k].textW + 22 > cw then ok = false; break end
					end
					if ok then n = c; break end
				end
			end
			rowIdx += 1
			local row = f.rows[rowIdx]
			if not row then
				row = Instance.new("Frame")
				row.Size = UDim2.new(1, 0, 0, 0)
				row.AutomaticSize = Enum.AutomaticSize.Y
				row.BackgroundTransparency = 1
				local RL2 = Instance.new("UIListLayout")
				RL2.FillDirection = Enum.FillDirection.Horizontal
				RL2.Padding = UDim.new(0, 6)
				RL2.SortOrder = Enum.SortOrder.LayoutOrder
				RL2.Parent = row
				f.rows[rowIdx] = row
			end
			row.LayoutOrder = rowIdx
			row.Parent = Frame
			for k = 0, n - 1 do
				local it = live[idx + k]
				it.frame.LayoutOrder = k
				it.frame.Parent = row
				it.set(n)
			end
			idx += n
		end
		for i = #f.rows, rowIdx + 1, -1 do
			f.rows[i]:Destroy()
			table.remove(f.rows, i)
		end
	end
	function f.Add(frame, textW, set)
		table.insert(f.items, {frame = frame, textW = textW, set = set})
		f.lastW = -1
		task.defer(f.Relayout)
	end
	Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if Frame.AbsoluteSize.X ~= f.lastW then f.Relayout() end
	end)
	flowOf[parent] = f
	return f
end

local function addDescription(frame, lbl, description)
	if not description or description == "" then return end
	frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, frame.Size.Y.Offset + 14)
	lbl.Size = UDim2.new(lbl.Size.X.Scale, lbl.Size.X.Offset, 0, 18)
	lbl.Position = UDim2.new(lbl.Position.X.Scale, lbl.Position.X.Offset, 0, 6)
	local Desc = label(frame, {
		Name = "Description",
		Size = UDim2.new(lbl.Size.X.Scale, lbl.Size.X.Offset - 2, 0, 13),
		Position = UDim2.new(lbl.Position.X.Scale, lbl.Position.X.Offset + 2, 0, 25),
		Text = description,
		Font = F_R,
		TextSize = 10,
		TextXAlignment = LEFT,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, "dim")
	return Desc
end

local currentBody = setmetatable({}, {__mode = "k"})
local cardByBody = setmetatable({}, {__mode = "k"})
local pageByLoose = setmetatable({}, {__mode = "k"})

local function getParent(self, config)
	local container = (config and config.Parent) or self.TabContent
	return currentBody[container] or container
end

local function reg(parent, frame, name)
	local card = cardByBody[parent]
	if card then
		card.AddItem(tostring(name))
		return
	end
	local page = pageByLoose[parent]
	if page then page.AddLoose(frame, tostring(name)) end
end

local function styleScroll(sf)
	sf.BackgroundTransparency = 1
	sf.BorderSizePixel = 0
	sf.ScrollBarThickness = 4
	sf.ScrollBarImageTransparency = 0.3
	bind(sf, "ScrollBarImageColor3", "acc")
	sf.CanvasSize = UDim2.new(0, 0, 0, 0)
	sf.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 12)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = sf

	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 14)
	pad.PaddingRight = UDim.new(0, 14)
	pad.PaddingTop = UDim.new(0, 12)
	pad.PaddingBottom = UDim.new(0, 30)
	pad.Parent = sf
	return layout
end

local function buildPage(parent, title, desc)
	local page = {Cards = {}, LooseEntries = {}, Compact = false}

	local Scroll = Instance.new("ScrollingFrame")
	Scroll.Name = "Page_" .. title
	Scroll.Size = UDim2.new(1, 0, 1, 0)
	Scroll.Visible = false
	Scroll.Parent = parent
	styleScroll(Scroll)

	local Head = Instance.new("Frame")
	Head.Name = "PageHead"
	Head.Size = UDim2.new(1, 0, 0, 40)
	Head.BackgroundTransparency = 1
	Head.LayoutOrder = 1
	Head.Parent = Scroll

	label(Head, {
		Size = UDim2.new(1, 0, 0, 20), Text = title, Font = F_B, TextSize = 17,
		TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "white")
	local Sub = label(Head, {
		Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 0, 23), Text = desc or "",
		Font = F_R, TextSize = 11, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "dim")

	local Loose = Instance.new("Frame")
	Loose.Name = "Loose"
	Loose.Size = UDim2.new(1, 0, 0, 0)
	Loose.AutomaticSize = Enum.AutomaticSize.Y
	Loose.BackgroundTransparency = 1
	Loose.LayoutOrder = 2
	Loose.Parent = Scroll
	local LL = Instance.new("UIListLayout")
	LL.Padding = UDim.new(0, 6)
	LL.SortOrder = Enum.SortOrder.LayoutOrder
	LL.Parent = Loose

	local Grid = Instance.new("Frame")
	Grid.Name = "Grid"
	Grid.Size = UDim2.new(1, 0, 0, 0)
	Grid.AutomaticSize = Enum.AutomaticSize.Y
	Grid.BackgroundTransparency = 1
	Grid.LayoutOrder = 3
	Grid.Parent = Scroll
	local GL = Instance.new("UIListLayout")
	GL.FillDirection = Enum.FillDirection.Horizontal
	GL.Padding = UDim.new(0, 8)
	GL.SortOrder = Enum.SortOrder.LayoutOrder
	GL.Parent = Grid

	local function makeCol(order)
		local C = Instance.new("Frame")
		C.Size = UDim2.new(0.5, -4, 0, 0)
		C.AutomaticSize = Enum.AutomaticSize.Y
		C.BackgroundTransparency = 1
		C.LayoutOrder = order
		C.Parent = Grid
		local L = Instance.new("UIListLayout")
		L.Padding = UDim.new(0, 8)
		L.SortOrder = Enum.SortOrder.LayoutOrder
		L.Parent = C
		return C
	end
	local ColL, ColR = makeCol(1), makeCol(2)

	pageByLoose[Loose] = page
	page.Scroll, page.Loose, page.LooseLayout, page.Sub = Scroll, Loose, LL, Sub
	page.Desc = desc

	function page.GetCount()
		return #page.Cards > 0 and #page.Cards or #page.LooseEntries
	end
	function page.UpdateCount()
		if page.OnCount then page.OnCount(page.GetCount()) end
		if not page.Desc or page.Desc == "" then
			local names = {}
			for _, c in ipairs(page.Cards) do table.insert(names, c.Name) end
			Sub.Text = table.concat(names, "  •  ")
		end
	end

	function page.Relayout()
		local cols = {ColL, ColR}
		local weights = {0, 0}
		for i, card in ipairs(page.Cards) do
			local idx = 1
			if not page.Compact and weights[1] > weights[2] then idx = 2 end
			weights[idx] += card.Weight()
			card.Frame.Parent = cols[idx]
			card.Frame.LayoutOrder = i
		end
		ColR.Visible = not page.Compact
		ColL.Size = page.Compact and UDim2.new(1, 0, 0, 0) or UDim2.new(0.5, -4, 0, 0)
	end
	local pending = false
	function page.Request()
		if pending then return end
		pending = true
		task.defer(function()
			pending = false
			page.Relayout()
		end)
	end
	function page.SetCompact(state)
		if page.Compact == state then return end
		page.Compact = state
		page.Relayout()
	end

	function page.AddLoose(frame, name)
		table.insert(page.LooseEntries, {frame = frame, key = string.lower(name)})
		page.UpdateCount()
	end
	function page.AddCard(card)
		table.insert(page.Cards, card)
		card.Frame.Parent = ColL
		page.UpdateCount()
		page.Request()
	end

	function page.Filter(q)
		local n = 0
		for _, e in ipairs(page.LooseEntries) do
			if e.frame.Parent then
				local show = q == "" or string.find(e.key, q, 1, true) ~= nil
				e.frame.Visible = show
				if show then n += 1 end
			end
		end
		for _, c in ipairs(page.Cards) do
			local show = q == "" or string.find(c.Key(), q, 1, true) ~= nil
			c.Frame.Visible = show
			if show then n += 1 end
		end
		return n
	end

	return page
end

local function buildCard(page, o)
	local collapsed = o.Collapsed == true
	local items = {}
	local card = {Name = o.Text}

	local Root = Instance.new("Frame")
	Root.Name = "Section"
	Root.Size = UDim2.new(1, 0, 0, 0)
	Root.AutomaticSize = Enum.AutomaticSize.Y
	Root.BorderSizePixel = 0
	bind(Root, "BackgroundColor3", "bg850")
	corner(Root, 14)
	local RStroke = stroke(Root, "border", 1)

	local RL = Instance.new("UIListLayout")
	RL.SortOrder = Enum.SortOrder.LayoutOrder
	RL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	RL.Parent = Root

	local Head = Instance.new("TextButton")
	Head.Name = "Head"
	Head.Size = UDim2.new(1, 0, 0, 52)
	Head.BackgroundTransparency = 1
	Head.Text = ""
	Head.AutoButtonColor = false
	Head.LayoutOrder = 1
	Head.Parent = Root

	local Tile = Instance.new("Frame")
	Tile.Size = UDim2.new(0, 32, 0, 32)
	Tile.Position = UDim2.new(0, 12, 0, 10)
	Tile.BorderSizePixel = 0
	bind(Tile, "BackgroundColor3", "soft")
	Tile.Parent = Head
	corner(Tile, 9)
	stroke(Tile, "accBorder", 1)
	if o.Icon then
		local Img = Instance.new("ImageLabel")
		Img.Size = UDim2.new(0, 16, 0, 16)
		Img.Position = UDim2.new(0.5, 0, 0.5, 0)
		Img.AnchorPoint = Vector2.new(0.5, 0.5)
		Img.BackgroundTransparency = 1
		Img.Image = "rbxassetid://" .. tostring(o.Icon)
		bind(Img, "ImageColor3", "acc")
		Img.Parent = Tile
	else
		label(Tile, {
			Size = UDim2.new(1, 0, 1, 0), Text = string.upper(string.sub(o.Text, 1, 1)),
			Font = F_B, TextSize = 14,
		}, "acc")
	end

	label(Head, {
		Size = UDim2.new(1, -118, 0, 18), Position = UDim2.new(0, 54, 0, 9), Text = o.Text,
		Font = F_B, TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "white")
	local Sub = label(Head, {
		Size = UDim2.new(1, -118, 0, 14), Position = UDim2.new(0, 54, 0, 28), Text = o.Description or "",
		Font = F_R, TextSize = 11, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "dim")

	local Badge = label(Head, {
		Size = UDim2.new(0, 26, 0, 18), Position = UDim2.new(1, -60, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
		Text = "0", Font = F_C, TextSize = 11, BackgroundTransparency = 0, Visible = false,
	}, "dim")
	bind(Badge, "BackgroundColor3", "bg950")
	corner(Badge, 9)

	local Arrow = label(Head, {
		Size = UDim2.new(0, 22, 1, 0), Position = UDim2.new(1, -30, 0, 0), Text = ">",
		Font = F_B, TextSize = 14, Rotation = collapsed and 0 or 90,
	}, "acc")

	local Div = Instance.new("Frame")
	Div.Size = UDim2.new(1, -24, 0, 1)
	Div.BorderSizePixel = 0
	Div.LayoutOrder = 2
	Div.Visible = not collapsed
	bind(Div, "BackgroundColor3", "border")
	Div.Parent = Root

	local Body = Instance.new("Frame")
	Body.Name = "Body"
	Body.Size = UDim2.new(1, 0, 0, 0)
	Body.AutomaticSize = Enum.AutomaticSize.Y
	Body.BackgroundTransparency = 1
	Body.LayoutOrder = 3
	Body.Visible = not collapsed
	Body:SetAttribute("BulbCard", true)
	Body.Parent = Root

	local BL = Instance.new("UIListLayout")
	BL.Padding = UDim.new(0, 6)
	BL.SortOrder = Enum.SortOrder.LayoutOrder
	BL.Parent = Body
	local BP = Instance.new("UIPadding")
	BP.PaddingLeft = UDim.new(0, 10)
	BP.PaddingRight = UDim.new(0, 10)
	BP.PaddingTop = UDim.new(0, 10)
	BP.PaddingBottom = UDim.new(0, 10)
	BP.Parent = Body

	local function setCollapsed(state)
		collapsed = state
		Body.Visible = not state
		Div.Visible = not state
		smoothTween(Arrow, {Rotation = state and 0 or 90}, 0.2)
		page.Request()
	end
	Head.MouseButton1Click:Connect(function() setCollapsed(not collapsed) end)
	Head.MouseEnter:Connect(function() smoothTween(RStroke, {Color = T.accBorder}, 0.15) end)
	Head.MouseLeave:Connect(function() smoothTween(RStroke, {Color = T.border}, 0.15) end)

	function card.Weight() return collapsed and 2 or (#items + 2) end
	function card.Key()
		return string.lower(o.Text .. " " .. (o.Description or "") .. " " .. table.concat(items, " "))
	end
	function card.AddItem(n)
		table.insert(items, n)
		Badge.Text = tostring(#items)
		Badge.Visible = true
		if not o.Description or o.Description == "" then
			Sub.Text = table.concat(items, "  •  ")
		end
		page.Request()
	end

	card.Frame = Root
	card.Body = Body
	card.SetCollapsed = setCollapsed
	cardByBody[Body] = card
	page.AddCard(card)

	return Root, card
end

function BulbGui:_initConfigSystem(config)
	self._savedFlags = {}
	local folderName = config.FolderName or "TumblrConfigs"
	local fileName = config.FileName or "default.json"
	if isfolder and makefolder and not isfolder(folderName) then
		makefolder(folderName)
	end
	local filePath = folderName .. "/" .. fileName

	function self:_saveConfig()
		if not writefile then return end
		local success, result = pcall(function()
			return writefile(filePath, HttpService:JSONEncode(self._savedFlags))
		end)
		if not success then
			warn("[BulbGui] Failed to save config:", result)
		end
	end

	function self:_loadConfig()
		if not (isfile and readfile) or not isfile(filePath) then
			print("[BulbGui] No config file found, using defaults")
			return
		end
		local success, result = pcall(function()
			return HttpService:JSONDecode(readfile(filePath))
		end)
		if success and type(result) == "table" then
			for key, value in pairs(result) do
				self._savedFlags[key] = value
			end
			print("[BulbGui] Config loaded from:", filePath)
		else
			warn("[BulbGui] Failed to load config:", result)
		end
	end

	self:_loadConfig()
end

function BulbGui:_conn(signal, fn)
	local c = signal:Connect(fn)
	self._conns = self._conns or {}
	table.insert(self._conns, c)
	return c
end

function BulbGui:_calculateSize(config)
	local viewport = workspace.CurrentCamera.ViewportSize
	local desktop = viewport.Y > 1000 and viewport.X > 1000
	local winW, winH
	if config.Size then
		winW, winH = config.Size.X.Offset, config.Size.Y.Offset
	elseif desktop then
		winW, winH = 780, 520
	else
		winW, winH = math.min(viewport.X - 100, 780), math.min(viewport.Y - 60, 520)
	end
	local maxW, maxH = winW + P * 2, winH + P * 2
	local scale = config.InitialScale or 0.6
	local initW, initH = math.floor(maxW * scale), math.floor(maxH * scale)
	self._maxSize = Vector2.new(maxW, maxH)
	self._initSize = Vector2.new(initW, initH)
	self._minSize = Vector2.new(math.min(250 + P * 2, initW), math.min(190 + P * 2, initH))
	return self._initSize
end

function BulbGui:_limits()
	return self._minSize.X, self._minSize.Y, self._maxSize.X, self._maxSize.Y, self._initSize.X, self._initSize.Y
end

function BulbGui:_savedSizeOrDefault()
	local minW, minH, maxW, maxH, initW, initH = self:_limits()
	local sw = self._savedFlags and self._savedFlags["_WindowWidth"]
	local sh = self._savedFlags and self._savedFlags["_WindowHeight"]
	if type(sw) == "number" and type(sh) == "number" and sw >= minW and sw <= maxW and sh >= minH and sh <= maxH then
		return sw, sh
	end
	return initW, initH
end

function BulbGui:_saveWindowState()
	if not self._savedFlags or not self.Shadow then return end
	local S = self.Shadow
	self._savedFlags["_WindowWidth"] = S.AbsoluteSize.X
	self._savedFlags["_WindowHeight"] = (self._minimized and self._restoreH) or S.AbsoluteSize.Y
	self._savedFlags["_WindowPosX"] = S.AbsolutePosition.X
	self._savedFlags["_WindowPosY"] = S.AbsolutePosition.Y
	if self._saveConfig then pcall(function() self:_saveConfig() end) end
end

function BulbGui:_hideWindow()
	local S = self.Shadow
	if not S or not S.Visible or self._animating then return end
	self._animating = true
	self:_saveWindowState()
	local p, s = S.AbsolutePosition, S.AbsoluteSize
	smoothTween(S, {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0, p.X + s.X / 2, 0, p.Y + s.Y / 2),
	}, 0.4)
	task.delay(0.4, function()
		S.Visible = false
		self._animating = false
	end)
end

function BulbGui:_showWindow()
	local S = self.Shadow
	if not S or S.Visible or self._animating then return end
	self._animating = true
	if self._minimized then
		self._minimized = false
		self.ResizeHandle.Visible = true
	end
	local targetW, targetH = self:_savedSizeOrDefault()
	local viewport = workspace.CurrentCamera.ViewportSize
	local cx = math.floor((viewport.X - targetW) / 2)
	local cy = math.floor((viewport.Y - targetH) / 2)
	S.Visible = true
	S.Size = UDim2.new(0, 0, 0, 0)
	S.Position = UDim2.new(0, cx + targetW / 2, 0, cy + targetH / 2)
	smoothTween(S, {
		Size = UDim2.new(0, targetW, 0, targetH),
		Position = UDim2.new(0, cx, 0, cy),
	}, 0.4)
	task.delay(0.4, function()
		self._animating = false
		self:_applyLayout()
	end)
end

function BulbGui:_toggleWindow()
	if self.Shadow.Visible then self:_hideWindow() else self:_showWindow() end
end

function BulbGui:_setMinimized(state)
	local S = self.Shadow
	if not S or self._animating or self._minimized == state then return end
	self._minimized = state
	local w = S.AbsoluteSize.X
	if state then
		self._restoreH = S.AbsoluteSize.Y
		self.ResizeHandle.Visible = false
		smoothTween(S, {Size = UDim2.new(0, w, 0, TOP_H + P * 2)}, 0.3)
	else
		smoothTween(S, {Size = UDim2.new(0, w, 0, self._restoreH or self._initSize.Y)}, 0.3)
		task.delay(0.3, function() self.ResizeHandle.Visible = true end)
	end
end

function BulbGui:_applyLayout()
	if self._animating or not self.Main then return end
	local w = self.Main.AbsoluteSize.X
	if w <= 0 then return end
	local rail = w < 400
	self._rail = rail
	local sbW = rail and SB_RAIL or SB_W
	local ww = w - sbW

	self.Sidebar.Size = UDim2.new(0, sbW, 1, 0)
	self.Workspace.Position = UDim2.new(0, sbW, 0, 0)
	self.Workspace.Size = UDim2.new(1, -sbW, 1, 0)

	local u = self._ui
	u.BrandText.Visible = not rail
	u.BrandIcon.Position = rail and UDim2.new(0.5, 0, 0, 11) or UDim2.new(0, 12, 0, 11)
	u.BrandIcon.AnchorPoint = rail and Vector2.new(0.5, 0) or Vector2.new(0, 0)
	self.NavList.Size = UDim2.new(1, -16, 1, -(NAV_Y + SET_H))

	for _, e in ipairs(self._entries) do e.SetRail(rail) end

	local showPill = ww >= 440
	u.Perf.Visible = showPill
	u.Controls.Size = UDim2.new(0, showPill and 166 or 68, 1, 0)
	u.SearchBar.Size = UDim2.new(1, -((showPill and 166 or 68) + 28), 0, 32)
	local hint = (ww >= 360) and not UIS.TouchEnabled
	u.Hint.Visible = hint
	u.SearchBox.Size = UDim2.new(1, hint and -84 or -38, 1, 0)

	local compact = ww < 470
	for _, e in ipairs(self._entries) do e.Page.SetCompact(compact) end
end

function BulbGui:_createScreenGui()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "BulbGui"
	ScreenGui.Parent = CoreGui
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	return ScreenGui
end

function BulbGui:_createShadow(ScreenGui, size)
	local Shadow = Instance.new("ImageLabel")
	Shadow.Name = "Shadow"
	Shadow.BackgroundTransparency = 1
	Shadow.Image = "rbxassetid://5554236805"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.45
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	Shadow.Parent = ScreenGui
	local viewport = workspace.CurrentCamera.ViewportSize
	Shadow.Size = UDim2.new(0, size.X, 0, size.Y)
	Shadow.Position = UDim2.new(0, math.floor((viewport.X - size.X) / 2), 0, math.floor((viewport.Y - size.Y) / 2))
	return Shadow
end

function BulbGui:_createMainFrame(Shadow)
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Size = UDim2.new(1, -P * 2, 1, -P * 2)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BorderSizePixel = 0
	Main.Active = true
	Main.ClipsDescendants = true
	bind(Main, "BackgroundColor3", "bg900")
	Main.Parent = Shadow
	corner(Main, 14)
	stroke(Main, "border", 1)
	return Main
end

function BulbGui:_setupDraggableWindow(handles, Shadow)
	local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
	for _, handle in ipairs(handles) do
		handle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = UDim2.new(0, Shadow.AbsolutePosition.X, 0, Shadow.AbsolutePosition.Y)
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						if self._savedFlags then
							self._savedFlags["_WindowPosX"] = Shadow.AbsolutePosition.X
							self._savedFlags["_WindowPosY"] = Shadow.AbsolutePosition.Y
							if self._saveConfig then pcall(function() self:_saveConfig() end) end
						end
					end
				end)
			end
		end)
		handle.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
	end
	self:_conn(UIS.InputChanged, function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Shadow.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
		end
	end)
end

function BulbGui:_createToggleButton(ScreenGui)
	local ToggleBtn = Instance.new("TextButton")
	ToggleBtn.Name = "ToggleBtn"
	ToggleBtn.Size = UDim2.new(0, 46, 0, 46)
	ToggleBtn.Position = UDim2.new(0, 15, 0, 60)
	ToggleBtn.Text = ""
	ToggleBtn.AutoButtonColor = false
	bind(ToggleBtn, "BackgroundColor3", "acc")
	ToggleBtn.Parent = ScreenGui
	corner(ToggleBtn, 23)

	local ToggleIcon = Instance.new("ImageLabel")
	ToggleIcon.Size = UDim2.new(0, 20, 0, 20)
	ToggleIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	ToggleIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	ToggleIcon.BackgroundTransparency = 1
	ToggleIcon.Image = "rbxassetid://10723434711"
	bind(ToggleIcon, "ImageColor3", "bg950")
	ToggleIcon.Parent = ToggleBtn

	ToggleBtn.MouseButton1Click:Connect(function()
		if self._toggleMoved then
			self._toggleMoved = false
			return
		end
		self:_toggleWindow()
	end)
	ToggleBtn.MouseEnter:Connect(function()
		smoothTween(ToggleBtn, {Size = UDim2.new(0, 50, 0, 50), BackgroundColor3 = T.accDark})
	end)
	ToggleBtn.MouseLeave:Connect(function()
		smoothTween(ToggleBtn, {Size = UDim2.new(0, 46, 0, 46), BackgroundColor3 = T.acc})
	end)

	local toggleDragging = false
	local toggleDragInput, toggleDragStart, toggleStartPos
	ToggleBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			toggleDragging = true
			self._toggleMoved = false
			toggleDragStart = input.Position
			toggleStartPos = ToggleBtn.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					toggleDragging = false
				end
			end)
		end
	end)
	ToggleBtn.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			toggleDragInput = input
		end
	end)
	self:_conn(UIS.InputChanged, function(input)
		if input == toggleDragInput and toggleDragging then
			local delta = input.Position - toggleDragStart
			if delta.Magnitude > 6 then
				self._toggleMoved = true
			end
			ToggleBtn.Position = UDim2.new(
				toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X,
				toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y
			)
		end
	end)
	return ToggleBtn
end

function BulbGui:_createNotifHolder(ScreenGui)
	local Holder = Instance.new("Frame")
	Holder.Name = "NotifHolder"
	Holder.Size = UDim2.new(0, 260, 1, -24)
	Holder.Position = UDim2.new(1, -12, 0, 12)
	Holder.AnchorPoint = Vector2.new(1, 0)
	Holder.BackgroundTransparency = 1
	Holder.BorderSizePixel = 0
	Holder.ZIndex = 200
	Holder.Parent = ScreenGui

	local Layout = Instance.new("UIListLayout")
	Layout.Padding = UDim.new(0, 8)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Layout.VerticalAlignment = Enum.VerticalAlignment.Top
	Layout.Parent = Holder
	return Holder
end

function BulbGui:_createResizeHandle(Shadow)
	local Handle = Instance.new("TextButton")
	Handle.Name = "ResizeHandle"
	Handle.Size = UDim2.new(0, 22, 0, 22)
	Handle.Position = UDim2.new(1, -P - 4, 1, -P - 4)
	Handle.AnchorPoint = Vector2.new(1, 1)
	Handle.BackgroundTransparency = 0.3
	Handle.BorderSizePixel = 0
	Handle.Text = ""
	Handle.AutoButtonColor = false
	Handle.ZIndex = 10
	bind(Handle, "BackgroundColor3", "acc")
	Handle.Parent = Shadow
	corner(Handle, 6)

	local function bar(w, x, y)
		local B = Instance.new("Frame")
		B.Size = UDim2.new(0, w, 0, 2)
		B.Position = UDim2.new(0, x, 0, y)
		B.BorderSizePixel = 0
		B.Rotation = -45
		B.ZIndex = 11
		bind(B, "BackgroundColor3", "bg950")
		B.Parent = Handle
	end
	bar(12, 5, 10)
	bar(7, 10, 14)

	Handle.MouseEnter:Connect(function()
		smoothTween(Handle, {BackgroundTransparency = 0}, 0.15)
		UIS.MouseIcon = "rbxasset://SystemCursors/SizeNWSE"
	end)
	Handle.MouseLeave:Connect(function()
		smoothTween(Handle, {BackgroundTransparency = 0.3}, 0.15)
		UIS.MouseIcon = ""
	end)

	local resizing = false
	local startPos, startSize
	Handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			startPos = input.Position
			startSize = Shadow.AbsoluteSize
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
					UIS.MouseIcon = ""
					if self._saveConfig then pcall(function() self:_saveConfig() end) end
				end
			end)
		end
	end)
	self:_conn(UIS.InputChanged, function(input)
		if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - startPos
			local minW, minH, maxW, maxH = self:_limits()
			local newWidth = math.clamp(startSize.X + delta.X, minW, maxW)
			local newHeight = math.clamp(startSize.Y + delta.Y, minH, maxH)
			Shadow.Size = UDim2.new(0, newWidth, 0, newHeight)
			if self._savedFlags then
				self._savedFlags["_WindowWidth"] = newWidth
				self._savedFlags["_WindowHeight"] = newHeight
			end
		end
	end)
	return Handle
end

function BulbGui:_showLoadNotification(config, name)
	if config.LoadedNotification ~= false then
		task.spawn(function()
			task.wait(0.1)
			self:Notify({
				Title = config.NotifyTitle or "Load Script",
				Content = config.NotifyContent or (name .. " on initialisation!"),
				Duration = config.NotifyDuration or 3,
				Image = config.NotifyImage or "10723434711"
			})
		end)
	end
end

function BulbGui:_registerNav(name, icon, page, order, holder, autoClick)
	local active = false
	local Btn = Instance.new("TextButton")
	Btn.Name = "Nav_" .. name
	Btn.Size = UDim2.new(1, 0, 0, 38)
	Btn.Text = ""
	Btn.AutoButtonColor = false
	Btn.BorderSizePixel = 0
	Btn.LayoutOrder = order
	bind(Btn, "BackgroundColor3", function() return active and T.soft or T.bg850 end)
	Btn.BackgroundTransparency = 1
	Btn.Parent = holder or self.NavList
	corner(Btn, 10)
	local S = stroke(Btn, function() return active and T.accBorder or T.border end, 1, 1)

	local Icon = Instance.new("ImageLabel")
	Icon.Size = UDim2.new(0, 16, 0, 16)
	Icon.Position = UDim2.new(0, 12, 0.5, 0)
	Icon.AnchorPoint = Vector2.new(0, 0.5)
	Icon.BackgroundTransparency = 1
	Icon.Image = "rbxassetid://" .. tostring(icon or 4483362458)
	bind(Icon, "ImageColor3", function() return active and T.acc or T.dim end)
	Icon.Parent = Btn

	local Label = label(Btn, {
		Size = UDim2.new(1, -78, 1, 0), Position = UDim2.new(0, 38, 0, 0), Text = name,
		Font = F_M, TextSize = 12, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, function() return active and T.acc or T.dim end)

	local Badge = label(Btn, {
		Size = UDim2.new(0, 26, 0, 16), Position = UDim2.new(1, -8, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
		Text = "", Font = F_C, TextSize = 10, BackgroundTransparency = 0, Visible = false,
	}, "dim")
	bind(Badge, "BackgroundColor3", "bg950")
	corner(Badge, 8)

	local entry = {Name = name, Page = page, Btn = Btn, Label = Label, Icon = Icon, Badge = Badge, Frame = page.Scroll}

	function entry.SetActive(on)
		active = on
		smoothTween(Btn, {BackgroundTransparency = on and 0 or 1, BackgroundColor3 = on and T.soft or T.bg850}, 0.2)
		smoothTween(S, {Transparency = on and 0 or 1, Color = on and T.accBorder or T.border}, 0.2)
		smoothTween(Icon, {ImageColor3 = on and T.acc or T.dim}, 0.2)
		smoothTween(Label, {TextColor3 = on and T.acc or T.dim}, 0.2)
		Label.Font = on and F_B or F_M
	end
	function entry.SetRail(rail)
		Label.Visible = not rail
		Badge.Visible = (not rail) and page.GetCount() > 0
		Icon.Position = rail and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 12, 0.5, 0)
		Icon.AnchorPoint = rail and Vector2.new(0.5, 0.5) or Vector2.new(0, 0.5)
	end

	page.OnCount = function(n)
		Badge.Text = tostring(n)
		Badge.Visible = n > 0 and not self._rail
	end
	page.UpdateCount()

	Btn.MouseEnter:Connect(function()
		if not active then smoothTween(Btn, {BackgroundTransparency = 0.5}, 0.12) end
	end)
	Btn.MouseLeave:Connect(function()
		if not active then smoothTween(Btn, {BackgroundTransparency = 1}, 0.12) end
	end)

	if autoClick then
		Btn.MouseButton1Click:Connect(function() self:_selectTab(entry) end)
	end

	table.insert(self._entries, entry)
	return entry
end

function BulbGui:_selectTab(entry)
	if not entry then return end
	local changed = self._activeTab ~= entry
	self._activeTab = entry
	for _, e in ipairs(self._entries) do
		local on = e == entry
		e.SetActive(on)
		if on then
			e.Page.Scroll.Visible = true
			if changed then
				e.Page.Scroll.Position = UDim2.new(0, 0, 0, 10)
				smoothTween(e.Page.Scroll, {Position = UDim2.new(0, 0, 0, 0)}, 0.25)
			end
			e.Page.Filter(self._query or "")
		else
			e.Page.Scroll.Visible = false
		end
	end
end

function BulbGui:_search(q)
	q = string.lower(q or "")
	self._query = q
	local counts = {}
	for _, e in ipairs(self._entries) do
		counts[e] = e.Page.Filter(q)
	end
	if q ~= "" and self._activeTab and counts[self._activeTab] == 0 then
		for _, e in ipairs(self._entries) do
			if counts[e] > 0 then
				self:_selectTab(e)
				break
			end
		end
	end
end

function BulbGui:Init(config)
	if CoreGui:FindFirstChild("BulbGui") then
		CoreGui.BulbGui:Destroy()
	end
	if self._conns then
		for _, c in ipairs(self._conns) do pcall(function() c:Disconnect() end) end
	end
	if self._afkConn then
		pcall(function() self._afkConn:Disconnect() end)
		self._afkConn = nil
	end
	self._conns = {}
	table.clear(bindings)
	config = config or {}
	self:_initConfigSystem(config)

	local themeDef = findTheme(config.Theme or self._savedFlags["_Theme"])
	setPalette(themeDef)
	self._themeName = themeDef.Name

	self._entries, self._activeTab, self._query = {}, nil, ""
	self._minimized, self._animating, self._rail = false, false, nil
	self.Tabs = {}
	self.ActiveNotifs = {}

	local name = config.Name or "BulbGui"
	self:_showLoadNotification(config, name)
	local size = self:_calculateSize(config)
	local ScreenGui = self:_createScreenGui()
	local Shadow = self:_createShadow(ScreenGui, size)

	do
		local viewport = workspace.CurrentCamera.ViewportSize
		local w, h = self:_savedSizeOrDefault()
		Shadow.Size = UDim2.new(0, w, 0, h)
		Shadow.Position = UDim2.new(0, math.floor((viewport.X - w) / 2), 0, math.floor((viewport.Y - h) / 2))
	end

	local Main = self:_createMainFrame(Shadow)
	local ui = {}
	self._ui = ui

	local Glow = Instance.new("Frame")
	Glow.Size = UDim2.new(1, -40, 0, 1)
	Glow.Position = UDim2.new(0, 20, 0, 0)
	Glow.BackgroundTransparency = 0.5
	Glow.BorderSizePixel = 0
	Glow.ZIndex = 5
	bind(Glow, "BackgroundColor3", "acc")
	Glow.Parent = Main

	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0, SB_W, 1, 0)
	Sidebar.BorderSizePixel = 0
	bind(Sidebar, "BackgroundColor3", "bg950")
	Sidebar.Parent = Main

	local SideLine = Instance.new("Frame")
	SideLine.Size = UDim2.new(0, 1, 1, 0)
	SideLine.Position = UDim2.new(1, -1, 0, 0)
	SideLine.BorderSizePixel = 0
	bind(SideLine, "BackgroundColor3", "border")
	SideLine.Parent = Sidebar

	local Brand = Instance.new("Frame")
	Brand.Name = "Brand"
	Brand.Size = UDim2.new(1, 0, 0, TOP_H)
	Brand.BackgroundTransparency = 1
	Brand.Parent = Sidebar

	local BrandLine = Instance.new("Frame")
	BrandLine.Size = UDim2.new(1, -24, 0, 1)
	BrandLine.Position = UDim2.new(0, 12, 1, -1)
	BrandLine.BorderSizePixel = 0
	bind(BrandLine, "BackgroundColor3", "border")
	BrandLine.Parent = Brand

	local BrandIcon = Instance.new("Frame")
	BrandIcon.Size = UDim2.new(0, 34, 0, 34)
	BrandIcon.Position = UDim2.new(0, 12, 0, 11)
	BrandIcon.BorderSizePixel = 0
	bind(BrandIcon, "BackgroundColor3", "soft")
	BrandIcon.Parent = Brand
	corner(BrandIcon, 10)
	stroke(BrandIcon, "accBorder", 1)
	local BIcon = Instance.new("ImageLabel")
	BIcon.Size = UDim2.new(0, 18, 0, 18)
	BIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	BIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	BIcon.BackgroundTransparency = 1
	BIcon.Image = "rbxassetid://" .. tostring(config.Icon or "10723434711")
	bind(BIcon, "ImageColor3", "acc")
	BIcon.Parent = BrandIcon

	local BrandText = Instance.new("Frame")
	BrandText.Size = UDim2.new(1, -54, 1, 0)
	BrandText.Position = UDim2.new(0, 54, 0, 0)
	BrandText.BackgroundTransparency = 1
	BrandText.Parent = Brand
	local titleW = math.min(measure(name, 15, F_B) + 4, SB_W - 54 - 52)
	label(BrandText, {
		Size = UDim2.new(0, titleW, 0, 18), Position = UDim2.new(0, 0, 0, 10), Text = name,
		Font = F_B, TextSize = 15, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "white")
	local badgeText = config.Badge or ("v" .. TVersion)
	local BadgeL = label(BrandText, {
		Size = UDim2.new(0, measure(badgeText, 9, F_C) + 10, 0, 14), Position = UDim2.new(0, titleW + 6, 0, 12),
		Text = badgeText, Font = F_C, TextSize = 9, BackgroundTransparency = 0,
	}, "acc")
	bind(BadgeL, "BackgroundColor3", "soft")
	corner(BadgeL, 4)
	stroke(BadgeL, "accBorder", 1)
	label(BrandText, {
		Size = UDim2.new(1, -4, 0, 14), Position = UDim2.new(0, 0, 0, 30),
		Text = config.Subtitle or "Advanced UI Framework", Font = F_R, TextSize = 11,
		TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "dim")

	local NavList = Instance.new("ScrollingFrame")
	NavList.Name = "NavList"
	NavList.Size = UDim2.new(1, -16, 1, -(NAV_Y + SET_H))
	NavList.Position = UDim2.new(0, 8, 0, NAV_Y)
	NavList.BackgroundTransparency = 1
	NavList.BorderSizePixel = 0
	NavList.ScrollBarThickness = 0
	NavList.CanvasSize = UDim2.new(0, 0, 0, 0)
	NavList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	NavList.Parent = Sidebar
	local NL = Instance.new("UIListLayout")
	NL.Padding = UDim.new(0, 4)
	NL.SortOrder = Enum.SortOrder.LayoutOrder
	NL.Parent = NavList

	local toggleKey = config.ToggleKey or Enum.KeyCode.RightShift
	local SetLine = Instance.new("Frame")
	SetLine.Size = UDim2.new(1, -24, 0, 1)
	SetLine.Position = UDim2.new(0, 12, 1, -(SET_H - 4))
	SetLine.BorderSizePixel = 0
	bind(SetLine, "BackgroundColor3", "border")
	SetLine.Parent = Sidebar
	local SettingsHolder = Instance.new("Frame")
	SettingsHolder.Name = "SettingsHolder"
	SettingsHolder.Size = UDim2.new(1, -16, 0, 38)
	SettingsHolder.Position = UDim2.new(0, 8, 1, -46)
	SettingsHolder.BackgroundTransparency = 1
	SettingsHolder.Parent = Sidebar

	local Workspace = Instance.new("Frame")
	Workspace.Name = "Workspace"
	Workspace.Size = UDim2.new(1, -SB_W, 1, 0)
	Workspace.Position = UDim2.new(0, SB_W, 0, 0)
	Workspace.BackgroundTransparency = 1
	Workspace.Parent = Main

	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, TOP_H)
	TopBar.BackgroundTransparency = 1
	TopBar.Parent = Workspace
	local TopLine = Instance.new("Frame")
	TopLine.Size = UDim2.new(1, 0, 0, 1)
	TopLine.Position = UDim2.new(0, 0, 1, -1)
	TopLine.BorderSizePixel = 0
	bind(TopLine, "BackgroundColor3", "border")
	TopLine.Parent = TopBar

	local SearchBar = Instance.new("Frame")
	SearchBar.Size = UDim2.new(1, -194, 0, 32)
	SearchBar.Position = UDim2.new(0, 14, 0.5, 0)
	SearchBar.AnchorPoint = Vector2.new(0, 0.5)
	SearchBar.BorderSizePixel = 0
	bind(SearchBar, "BackgroundColor3", "bg950")
	SearchBar.Parent = TopBar
	corner(SearchBar, 10)
	local SStroke = stroke(SearchBar, "border", 1)

	local Ring = Instance.new("Frame")
	Ring.Size = UDim2.new(0, 10, 0, 10)
	Ring.Position = UDim2.new(0, 11, 0.5, -6)
	Ring.BackgroundTransparency = 1
	Ring.Parent = SearchBar
	corner(Ring, 5)
	stroke(Ring, "acc", 1.5)
	local Handle = Instance.new("Frame")
	Handle.Size = UDim2.new(0, 5, 0, 2)
	Handle.Position = UDim2.new(0, 19, 0.5, 5)
	Handle.Rotation = 45
	Handle.BorderSizePixel = 0
	bind(Handle, "BackgroundColor3", "acc")
	Handle.Parent = SearchBar

	local SearchBox = Instance.new("TextBox")
	SearchBox.Size = UDim2.new(1, -84, 1, 0)
	SearchBox.Position = UDim2.new(0, 32, 0, 0)
	SearchBox.BackgroundTransparency = 1
	SearchBox.Text = ""
	SearchBox.PlaceholderText = "Search modules, toggles..."
	SearchBox.ClearTextOnFocus = false
	SearchBox.Font = F_R
	SearchBox.TextSize = 12
	SearchBox.TextXAlignment = LEFT
	bind(SearchBox, "TextColor3", "text")
	bind(SearchBox, "PlaceholderColor3", "dim2")
	SearchBox.Parent = SearchBar
	SearchBox.Focused:Connect(function() smoothTween(SStroke, {Color = T.acc}, 0.15) end)
	SearchBox.FocusLost:Connect(function() smoothTween(SStroke, {Color = T.border}, 0.15) end)
	SearchBox:GetPropertyChangedSignal("Text"):Connect(function() self:_search(SearchBox.Text) end)

	local Hint = label(SearchBar, {
		Size = UDim2.new(0, 46, 0, 18), Position = UDim2.new(1, -8, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
		Text = "Ctrl+K", Font = F_C, TextSize = 10, BackgroundTransparency = 0,
	}, "dim")
	bind(Hint, "BackgroundColor3", "bg850")
	corner(Hint, 5)

	local Controls = Instance.new("Frame")
	Controls.Size = UDim2.new(0, 166, 1, 0)
	Controls.Position = UDim2.new(1, -12, 0, 0)
	Controls.AnchorPoint = Vector2.new(1, 0)
	Controls.BackgroundTransparency = 1
	Controls.Parent = TopBar
	local CL = Instance.new("UIListLayout")
	CL.FillDirection = Enum.FillDirection.Horizontal
	CL.HorizontalAlignment = Enum.HorizontalAlignment.Right
	CL.VerticalAlignment = Enum.VerticalAlignment.Center
	CL.Padding = UDim.new(0, 6)
	CL.SortOrder = Enum.SortOrder.LayoutOrder
	CL.Parent = Controls

	local Perf = label(Controls, {
		Size = UDim2.new(0, 94, 0, 28), Text = "", Font = F_C, TextSize = 11, RichText = true,
		BackgroundTransparency = 0, LayoutOrder = 1,
	}, "text")
	bind(Perf, "BackgroundColor3", "bg950")
	corner(Perf, 10)
	stroke(Perf, "border", 1)

	local function ctrlBtn(text, order, hoverBg, hoverText, size)
		local B = Instance.new("TextButton")
		B.Size = UDim2.new(0, 28, 0, 28)
		B.Text = text
		B.Font = F_B
		B.TextSize = size or 13
		B.AutoButtonColor = false
		B.BorderSizePixel = 0
		B.LayoutOrder = order
		bind(B, "BackgroundColor3", "bg850")
		bind(B, "TextColor3", "dim")
		B.Parent = Controls
		corner(B, 10)
		stroke(B, "border", 1)
		B.MouseEnter:Connect(function() smoothTween(B, {BackgroundColor3 = hoverBg(), TextColor3 = hoverText()}, 0.15) end)
		B.MouseLeave:Connect(function() smoothTween(B, {BackgroundColor3 = T.bg850, TextColor3 = T.dim}, 0.15) end)
		return B
	end
	local MinBtn = ctrlBtn("-", 2, function() return T.soft end, function() return T.acc end, 16)
	local CloseBtn = ctrlBtn("X", 3, function() return T.bg850:Lerp(T.red, 0.25) end, function() return T.red end, 12)
	MinBtn.MouseButton1Click:Connect(function() self:_setMinimized(not self._minimized) end)
	CloseBtn.MouseButton1Click:Connect(function() self:_hideWindow() end)

	local Pages = Instance.new("Frame")
	Pages.Name = "Pages"
	Pages.Size = UDim2.new(1, 0, 1, -TOP_H)
	Pages.Position = UDim2.new(0, 0, 0, TOP_H)
	Pages.BackgroundTransparency = 1
	Pages.ClipsDescendants = true
	Pages.Parent = Workspace

	local ToggleBtn = self:_createToggleButton(ScreenGui)
	self:_setupDraggableWindow({Brand, TopBar}, Shadow)
	local ResizeHandle = self:_createResizeHandle(Shadow)

	self.ScreenGui = ScreenGui
	self.Main = Main
	self.Shadow = Shadow
	self.Sidebar = Sidebar
	self.Workspace = Workspace
	self.Pages = Pages
	self.NavList = NavList
	self.Content = Pages
	self.TabScroll = NavList
	self.ToggleBtn = ToggleBtn
	self.ResizeHandle = ResizeHandle
	self.SearchBox = SearchBox
	self.NotifHolder = self:_createNotifHolder(ScreenGui)

	ui.BrandText, ui.BrandIcon = BrandText, BrandIcon
	ui.Perf, ui.Controls, ui.SearchBar, ui.SearchBox, ui.Hint = Perf, Controls, SearchBar, SearchBox, Hint

	self:_conn(Main:GetPropertyChangedSignal("AbsoluteSize"), function() self:_applyLayout() end)

	local frames, acc = 0, 0
	self:_conn(RunService.RenderStepped, function(dt)
		frames += 1
		acc += dt
		if acc >= 0.5 then
			local fps = math.floor(frames / acc + 0.5)
			frames, acc = 0, 0
			if Shadow.Visible and Perf.Visible then
				local ping = 0
				pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) end)
				Perf.Text = string.format(
					'<font color="#%s">%d FPS</font> <font color="#%s">|</font> <font color="#%s">%d ms</font>',
					T.ok:ToHex(), fps, T.dim2:ToHex(), T.acc:ToHex(), ping
				)
			end
		end
	end)

	self:_conn(UIS.InputBegan, function(input, gpe)
		if input.KeyCode == Enum.KeyCode.K and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
			if Shadow.Visible then
				task.defer(function()
					SearchBox:CaptureFocus()
					SearchBox.Text = self._query or ""
				end)
			end
		end
	end)

	local SettingsPage = buildPage(Pages, "Settings", "Manage theme, shortcuts and interface preferences.")
	self.SettingsContent = SettingsPage.Loose
	self.SettingsEntry = self:_registerNav("Settings", 10723407389, SettingsPage, 10000, SettingsHolder, true)

	local gameName = "Unknown"
	pcall(function()
		gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	end)
	self:CreateSettingsParagraph({
		Title = "Information",
		Content = "BulbGui Version: " .. TVersion .. "\nCurrent User: " .. Players.LocalPlayer.Name .. "\nGame: " .. gameName
	})

	local themeNames = {}
	for _, def in ipairs(THEMES) do table.insert(themeNames, def.Name) end
	self:CreateSettingsDropdown({
		Name = "Theme",
		Description = "Switch the interface color skin",
		Options = themeNames,
		CurrentOption = self._themeName,
		Flag = "_Theme",
		Callback = function(opt)
			if type(opt) == "string" then self:SetTheme(opt) end
		end
	})
	self:CreateSettingsKeybind({
		Name = "UI Toggle Key",
		Description = "Show or hide the window",
		CurrentKeybind = toggleKey,
		Flag = "_ToggleKey",
		Callback = function() self:_toggleWindow() end
	})

	task.defer(function() self:_applyLayout() end)
	return self
end

function BulbGui:SetTheme(name)
	local def = findTheme(name)
	self._themeName = def.Name
	applyPalette(def, true)
	if self._savedFlags then
		self._savedFlags["_Theme"] = def.Name
		if self._saveConfig then pcall(function() self:_saveConfig() end) end
	end
end

function BulbGui:Notify(config)
	config = config or {}
	local title = config.Title or "Notification"
	local content = config.Content or "This is a notification"
	local duration = config.Duration or 3
	local image = config.Image or "10723434711"
	if not self.NotifHolder then return end

	local list = self.ActiveNotifs
	list.n = (list.n or 0) + 1
	local id = list.n
	table.insert(list, id)

	local Notif = Instance.new("Frame")
	Notif.Name = "Notif_" .. id
	Notif.Size = UDim2.new(1, 0, 0, 0)
	Notif.AutomaticSize = Enum.AutomaticSize.Y
	Notif.BorderSizePixel = 0
	Notif.LayoutOrder = id
	Notif.ZIndex = 200
	bind(Notif, "BackgroundColor3", "bg850")
	Notif.Parent = self.NotifHolder
	corner(Notif, 12)
	stroke(Notif, "accBorder", 1)

	local Scale = Instance.new("UIScale")
	Scale.Scale = 0.7
	Scale.Parent = Notif
	TweenService:Create(Scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

	local NPad = Instance.new("UIPadding")
	NPad.PaddingLeft = UDim.new(0, 12)
	NPad.PaddingRight = UDim.new(0, 12)
	NPad.PaddingTop = UDim.new(0, 10)
	NPad.PaddingBottom = UDim.new(0, 10)
	NPad.Parent = Notif

	local NLayout = Instance.new("UIListLayout")
	NLayout.Padding = UDim.new(0, 5)
	NLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NLayout.Parent = Notif

	local TitleRow = Instance.new("Frame")
	TitleRow.Size = UDim2.new(1, 0, 0, 18)
	TitleRow.BackgroundTransparency = 1
	TitleRow.LayoutOrder = 1
	TitleRow.Parent = Notif

	local NIcon = Instance.new("ImageLabel")
	NIcon.Size = UDim2.new(0, 16, 0, 16)
	NIcon.Position = UDim2.new(0, 0, 0.5, 0)
	NIcon.AnchorPoint = Vector2.new(0, 0.5)
	NIcon.BackgroundTransparency = 1
	NIcon.Image = "rbxassetid://" .. tostring(image)
	bind(NIcon, "ImageColor3", "acc")
	NIcon.ZIndex = 201
	NIcon.Parent = TitleRow

	label(TitleRow, {
		Size = UDim2.new(1, -24, 1, 0), Position = UDim2.new(0, 24, 0, 0), Text = title, Font = F_B,
		TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 201,
	}, "white")

	label(Notif, {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = content, Font = F_R,
		TextSize = 12, TextXAlignment = LEFT, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true,
		LayoutOrder = 2, ZIndex = 201,
	}, "dim")

	local ProgressBg = Instance.new("Frame")
	ProgressBg.Size = UDim2.new(1, 0, 0, 3)
	ProgressBg.BorderSizePixel = 0
	ProgressBg.LayoutOrder = 3
	ProgressBg.ZIndex = 201
	bind(ProgressBg, "BackgroundColor3", "border")
	ProgressBg.Parent = Notif
	corner(ProgressBg, 2)

	local ProgressFill = Instance.new("Frame")
	ProgressFill.Size = UDim2.new(1, 0, 1, 0)
	ProgressFill.BorderSizePixel = 0
	ProgressFill.ZIndex = 202
	bind(ProgressFill, "BackgroundColor3", "acc")
	ProgressFill.Parent = ProgressBg
	corner(ProgressFill, 2)
	TweenService:Create(ProgressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()

	task.delay(duration, function()
		TweenService:Create(Scale, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale = 0}):Play()
		task.wait(0.22)
		Notif:Destroy()
		local idx = table.find(list, id)
		if idx then table.remove(list, idx) end
	end)
end

function BulbGui:ConfirmationAction(config)
	config = config or {}
	local title = config.Title or "Confirmation"
	local message = config.Message or "Are you sure?"
	local confirmText = config.ConfirmText or "Yes"
	local cancelText = config.CancelText or "No"
	local onConfirm = config.OnConfirm or function() end
	local onCancel = config.OnCancel or function() end

	local Overlay = Instance.new("Frame")
	Overlay.Size = UDim2.new(1, 0, 1, 0)
	Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Overlay.BackgroundTransparency = 1
	Overlay.BorderSizePixel = 0
	Overlay.ZIndex = 100
	Overlay.Active = true
	Overlay.Parent = self.ScreenGui
	smoothTween(Overlay, {BackgroundTransparency = 0.5}, 0.2)

	local dialogW = 300
	local msgSize = TextService:GetTextSize(message, 13, F_R, Vector2.new(dialogW - 32, 1000))
	local dialogH = 48 + msgSize.Y + 14 + 34 + 16

	local Dialog = Instance.new("Frame")
	Dialog.Size = UDim2.new(0, dialogW, 0, dialogH)
	Dialog.Position = UDim2.new(0.5, 0, 0.5, 0)
	Dialog.AnchorPoint = Vector2.new(0.5, 0.5)
	Dialog.BorderSizePixel = 0
	Dialog.ZIndex = 101
	bind(Dialog, "BackgroundColor3", "bg850")
	Dialog.Parent = Overlay
	corner(Dialog, 14)
	stroke(Dialog, "accBorder", 1)

	local DScale = Instance.new("UIScale")
	DScale.Scale = 0.75
	DScale.Parent = Dialog
	TweenService:Create(DScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

	local Icon = Instance.new("ImageLabel")
	Icon.Size = UDim2.new(0, 20, 0, 20)
	Icon.Position = UDim2.new(0, 16, 0, 14)
	Icon.BackgroundTransparency = 1
	Icon.Image = "rbxassetid://10723407389"
	Icon.ZIndex = 102
	bind(Icon, "ImageColor3", "acc")
	Icon.Parent = Dialog

	label(Dialog, {
		Size = UDim2.new(1, -60, 0, 20), Position = UDim2.new(0, 44, 0, 14), Text = title, Font = F_B,
		TextSize = 15, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 102,
	}, "white")

	label(Dialog, {
		Size = UDim2.new(1, -32, 0, msgSize.Y), Position = UDim2.new(0, 16, 0, 46), Text = message, Font = F_R,
		TextSize = 13, TextWrapped = true, TextXAlignment = LEFT, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 102,
	}, "dim")

	local ButtonContainer = Instance.new("Frame")
	ButtonContainer.Size = UDim2.new(1, -32, 0, 34)
	ButtonContainer.Position = UDim2.new(0, 16, 1, -50)
	ButtonContainer.BackgroundTransparency = 1
	ButtonContainer.ZIndex = 102
	ButtonContainer.Parent = Dialog

	local ButtonLayout = Instance.new("UIListLayout")
	ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
	ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ButtonLayout.Padding = UDim.new(0, 8)
	ButtonLayout.Parent = ButtonContainer

	local function makeBtn(text, bg, hover, order)
		local B = Instance.new("TextButton")
		B.Size = UDim2.new(0, 84, 0, 34)
		B.BackgroundColor3 = bg
		B.Text = text
		B.TextColor3 = T.white
		B.Font = F_B
		B.TextSize = 13
		B.AutoButtonColor = false
		B.LayoutOrder = order
		B.ZIndex = 102
		B.Parent = ButtonContainer
		corner(B, 10)
		B.MouseEnter:Connect(function() smoothTween(B, {BackgroundColor3 = hover}, 0.15) end)
		B.MouseLeave:Connect(function() smoothTween(B, {BackgroundColor3 = bg}, 0.15) end)
		return B
	end

	local CancelBtn = makeBtn(cancelText, T.border, T.border:Lerp(T.acc, 0.3), 0)
	local ConfirmBtn = makeBtn(confirmText, T.red, T.redDark, 1)

	local closed = false
	local function closeDialog()
		if closed then return end
		closed = true
		smoothTween(Overlay, {BackgroundTransparency = 1}, 0.15)
		TweenService:Create(DScale, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale = 0.8}):Play()
		task.wait(0.16)
		Overlay:Destroy()
	end

	CancelBtn.MouseButton1Click:Connect(function()
		pcall(onCancel)
		closeDialog()
	end)
	ConfirmBtn.MouseButton1Click:Connect(function()
		pcall(onConfirm)
		closeDialog()
	end)
	Overlay.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local mp = input.Position
			local dp, ds = Dialog.AbsolutePosition, Dialog.AbsoluteSize
			if mp.X < dp.X or mp.X > dp.X + ds.X or mp.Y < dp.Y or mp.Y > dp.Y + ds.Y then
				pcall(onCancel)
				closeDialog()
			end
		end
	end)
end

function BulbGui:CreateTab(nameOrConfig, iconId)
	local config = {}
	if typeof(nameOrConfig) == "table" then
		config = nameOrConfig
	else
		config.Name = nameOrConfig or "Tab"
		config.Icon = iconId or 4483362458
	end
	local name = config.Name or "Tab"
	local icon = config.Icon or 4483362458

	local page = buildPage(self.Pages, name, config.Description)
	local entry = self:_registerNav(name, icon, page, #self.Tabs + 1)
	entry.Content = page.Loose
	table.insert(self.Tabs, entry)

	local held = false
	local holdTimer = nil
	local function requestDelete()
		self:ConfirmationAction({
			Title = "Delete Tab",
			Message = "Delete tab '" .. name .. "'?",
			ConfirmText = "Delete",
			CancelText = "Cancel",
			OnConfirm = function()
				entry.Btn:Destroy()
				page.Scroll:Destroy()
				for i, tab in ipairs(self.Tabs) do
					if tab == entry then table.remove(self.Tabs, i) break end
				end
				for i, e in ipairs(self._entries) do
					if e == entry then table.remove(self._entries, i) break end
				end
				if self._activeTab == entry then
					self._activeTab = nil
					self:_selectTab(self.Tabs[1] or self.SettingsEntry)
				end
				self:Notify({Title = "Tab Deleted", Content = "Tab '" .. name .. "' deleted", Duration = 2})
			end
		})
	end

	entry.Btn.MouseButton1Click:Connect(function()
		if held then
			held = false
			return
		end
		self:_selectTab(entry)
	end)
	entry.Btn.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if holdTimer then task.cancel(holdTimer) end
		holdTimer = task.delay(0.8, function()
			holdTimer = nil
			held = true
			requestDelete()
		end)
	end)
	entry.Btn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			if holdTimer then task.cancel(holdTimer); holdTimer = nil end
		end
	end)

	if config.Expanded == true or (self._activeTab == nil) then
		self:_selectTab(entry)
	end
	self._rail = nil
	self:_applyLayout()

	return setmetatable({
		Name = name,
		TabContent = page.Loose,
		ContentLayout = page.LooseLayout,
		Frame = page.Scroll,
		Body = page.Loose,
		Select = function() self:_selectTab(entry) end,
		Collapse = function() end,
		Expand = function() self:_selectTab(entry) end,
		Toggle = function() self:_selectTab(entry) end,
		IsCollapsed = function() return self._activeTab ~= entry end,
	}, {
		__index = self
	})
end

function BulbGui:EndSection(config)
	local container = (config and config.Parent) or self.TabContent
	if container then currentBody[container] = nil end
end

function BulbGui:CreateSettingsSection(name)
	if type(name) == "table" then
		name.Parent = self.SettingsContent
		return self:CreateSection(name)
	end
	return self:CreateSection({Name = name, Parent = self.SettingsContent})
end

function BulbGui:CreateSettingsToggle(config)
	config.Parent = self.SettingsContent
	return self:CreateToggle(config)
end

function BulbGui:CreateSettingsSlider(config)
	config.Parent = self.SettingsContent
	return self:CreateSlider(config)
end

function BulbGui:CreateSettingsDropdown(config)
	config.Parent = self.SettingsContent
	return self:CreateDropdown(config)
end

function BulbGui:CreateSettingsButton(config)
	config.Parent = self.SettingsContent
	return self:CreateButton(config)
end

function BulbGui:CreateSettingsParagraph(config)
	config.Parent = self.SettingsContent
	return self:CreateParagraph(config)
end

function BulbGui:CreateSettingsInput(config)
	config.Parent = self.SettingsContent
	return self:CreateInput(config)
end

function BulbGui:CreateSettingsKeybind(config)
	config.Parent = self.SettingsContent
	return self:CreateKeybind(config)
end

function BulbGui:CreateSection(config)
	local isTable = type(config) == "table"
	local text = (isTable and config.Name) or (type(config) == "string" and config) or "Section"
	local description = isTable and config.Description or nil
	local container = (isTable and config.Parent) or self.TabContent
	local collapsed = false
	if isTable then
		if config.Collapsed ~= nil then
			collapsed = config.Collapsed and true or false
		elseif config.Expanded ~= nil then
			collapsed = not config.Expanded
		end
	end

	local page = pageByLoose[container]
	local Root, card = buildCard(page, {
		Text = text,
		Description = description,
		Icon = isTable and config.Icon or nil,
		Collapsed = collapsed,
	})
	currentBody[container] = card.Body

	return Root, {
		Frame = Root,
		Body = card.Body,
		Collapse = function() card.SetCollapsed(true) end,
		Expand = function() card.SetCollapsed(false) end,
		Toggle = function() card.SetCollapsed(not card.Weight or false) end,
		IsCollapsed = function() return not card.Body.Visible end,
	}
end

function BulbGui:CreateButton(config)
	config = config or {}
	local text = config.Name or "Button"
	local callback = config.Callback or function() end
	local onDelete = config.OnDelete or function() end
	local deleteTitle = config.DeleteTitle or "Delete Button"
	local deleteMessage = config.DeleteMessage or "Are you sure you want to delete button '" .. text .. "'?"
	local deleteMode = config.DeleteMode or "none"
	local interactText = config.Interact or "Execute"

	local parent = getParent(self, config)
	local compact = not (config.Description and config.Description ~= "")
	local holder, flow = parent, nil
	if compact then
		flow = getFlow(parent)
		holder = flow.Frame
	else
		flowOf[parent] = nil
	end
	local ButtonFrame = makeRow(holder, 40)
	local function measureBtn(str)
		return math.clamp(measure(str, 12, F_B) + 24, 70, 170)
	end
	local adjustedWidth = measureBtn(interactText)
	local stacked = false

	local ButtonLabel = label(ButtonFrame, {
		Size = UDim2.new(1, -(adjustedWidth + 28), 1, 0), Position = UDim2.new(0, 14, 0, 0), Text = text,
		Font = F_M, TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "text")
	addDescription(ButtonFrame, ButtonLabel, config.Description)

	local Btn = Instance.new("TextButton")
	Btn.Size = UDim2.new(0, adjustedWidth, 0, 28)
	Btn.Position = UDim2.new(1, -adjustedWidth - 8, 0.5, 0)
	Btn.AnchorPoint = Vector2.new(0, 0.5)
	Btn.Text = interactText
	Btn.Font = F_B
	Btn.TextSize = 12
	Btn.AutoButtonColor = false
	Btn.BorderSizePixel = 0
	bind(Btn, "BackgroundColor3", "acc")
	bind(Btn, "TextColor3", "bg950")
	Btn.Parent = ButtonFrame
	corner(Btn, 10)

	local function applyMode(n)
		if not compact then return end
		stacked = n > 1
		if stacked then
			ButtonFrame.Size = UDim2.new(1 / n, -(6 * (n - 1) / n), 0, 66)
			ButtonLabel.Size = UDim2.new(1, -12, 0, 18)
			ButtonLabel.Position = UDim2.new(0, 6, 0, 8)
			ButtonLabel.TextXAlignment = Enum.TextXAlignment.Center
			Btn.AnchorPoint = Vector2.new(0.5, 0)
			Btn.Position = UDim2.new(0.5, 0, 0, 32)
			Btn.Size = UDim2.new(1, -16, 0, 26)
		else
			ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
			ButtonLabel.Size = UDim2.new(1, -(adjustedWidth + 28), 1, 0)
			ButtonLabel.Position = UDim2.new(0, 14, 0, 0)
			ButtonLabel.TextXAlignment = LEFT
			Btn.AnchorPoint = Vector2.new(0, 0.5)
			Btn.Position = UDim2.new(1, -adjustedWidth - 8, 0.5, 0)
			Btn.Size = UDim2.new(0, adjustedWidth, 0, 28)
		end
	end
	if flow then
		flow.Add(ButtonFrame, math.max(measure(text, 13, F_M), measure(interactText, 12, F_B) + 4), applyMode)
	end

	Btn.MouseEnter:Connect(function() smoothTween(Btn, {BackgroundColor3 = T.accDark}, 0.12) end)
	Btn.MouseLeave:Connect(function() smoothTween(Btn, {BackgroundColor3 = T.acc}, 0.12) end)
	Btn.MouseButton1Down:Connect(function()
		if not stacked then smoothTween(Btn, {Size = UDim2.new(0, adjustedWidth - 4, 0, 25)}, 0.08) end
	end)
	Btn.MouseButton1Up:Connect(function()
		if not stacked then smoothTween(Btn, {Size = UDim2.new(0, adjustedWidth, 0, 28)}, 0.12) end
	end)
	Btn.MouseButton1Click:Connect(function()
		if deleteMode == "none" then
			pcall(callback)
		elseif deleteMode == "instant" then
			pcall(onDelete)
			ButtonFrame:Destroy()
		elseif deleteMode == "confirm" then
			self:ConfirmationAction({
				Title = deleteTitle,
				Message = deleteMessage,
				ConfirmText = config.ConfirmText or "Delete",
				CancelText = "Cancel",
				OnConfirm = function()
					pcall(onDelete)
					ButtonFrame:Destroy()
				end
			})
		end
	end)

	reg(parent, ButtonFrame, text)
	return {
		Frame = ButtonFrame,
		Button = Btn,
		Label = ButtonLabel,
		Set = function(_, property, value)
			if property == "Name" then
				ButtonLabel.Text = value
			elseif property == "Interact" then
				Btn.Text = value
				local aw = measureBtn(value)
				adjustedWidth = aw
				if not stacked then
					ButtonLabel.Size = UDim2.new(1, -(aw + 28), 1, 0)
					smoothTween(Btn, {
						Size = UDim2.new(0, aw, 0, 28),
						Position = UDim2.new(1, -aw - 8, 0.5, 0)
					}, 0.25)
				end
			elseif property == "Visible" then
				ButtonFrame.Visible = value
			elseif property == "Callback" then
				callback = value
			end
		end
	}
end

function BulbGui:CreateParagraph(config)
	config = config or {}
	local title = config.Title or "Paragraph"
	local content = config.Content
	local icon = config.Icon or nil
	local copyable = config.Copyable or false

	local parent = getParent(self, config)
	flowOf[parent] = nil
	local ParaFrame = Instance.new("Frame")
	ParaFrame.Size = UDim2.new(1, 0, 0, 0)
	ParaFrame.AutomaticSize = Enum.AutomaticSize.Y
	ParaFrame.BorderSizePixel = 0
	bind(ParaFrame, "BackgroundColor3", parent:GetAttribute("BulbCard") and "bg900" or "bg850")
	ParaFrame.Parent = parent
	corner(ParaFrame, 10)
	stroke(ParaFrame, "border", 1)

	local ParaPadding = Instance.new("UIPadding")
	ParaPadding.PaddingLeft = UDim.new(0, 14)
	ParaPadding.PaddingRight = UDim.new(0, 14)
	ParaPadding.PaddingTop = UDim.new(0, 10)
	ParaPadding.PaddingBottom = UDim.new(0, 10)
	ParaPadding.Parent = ParaFrame

	local ParaLayout = Instance.new("UIListLayout")
	ParaLayout.Padding = UDim.new(0, 5)
	ParaLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ParaLayout.Parent = ParaFrame

	local TitleContainer = Instance.new("Frame")
	TitleContainer.Size = UDim2.new(1, 0, 0, 20)
	TitleContainer.BackgroundTransparency = 1
	TitleContainer.LayoutOrder = 1
	TitleContainer.Parent = ParaFrame

	local HLayout = Instance.new("UIListLayout")
	HLayout.FillDirection = Enum.FillDirection.Horizontal
	HLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	HLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	HLayout.SortOrder = Enum.SortOrder.LayoutOrder
	HLayout.Padding = UDim.new(0, 6)
	HLayout.Parent = TitleContainer

	if icon then
		local IconImage = Instance.new("ImageLabel")
		IconImage.Size = UDim2.new(0, 16, 0, 16)
		IconImage.BackgroundTransparency = 1
		IconImage.Image = "rbxassetid://" .. tostring(icon)
		IconImage.LayoutOrder = 1
		bind(IconImage, "ImageColor3", "acc")
		IconImage.Parent = TitleContainer
	end

	local TitleLabel = label(TitleContainer, {
		Size = UDim2.new(1, icon and -22 or 0, 0, 20), Text = title, Font = F_B, TextSize = 14,
		TextXAlignment = LEFT, LayoutOrder = 2,
	}, "acc")

	local ContentLabel
	local function buildContentLabel(text)
		if copyable then
			ContentLabel = Instance.new("TextBox")
			ContentLabel.TextEditable = false
			ContentLabel.ClearTextOnFocus = false
			ContentLabel.MultiLine = true
		else
			ContentLabel = Instance.new("TextLabel")
		end
		ContentLabel.Size = UDim2.new(1, 0, 0, 0)
		ContentLabel.AutomaticSize = Enum.AutomaticSize.Y
		ContentLabel.BackgroundTransparency = 1
		ContentLabel.Text = text
		bind(ContentLabel, "TextColor3", "dim")
		ContentLabel.Font = F_R
		ContentLabel.TextSize = 12
		ContentLabel.TextXAlignment = LEFT
		ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
		ContentLabel.TextWrapped = true
		ContentLabel.LayoutOrder = 3
		ContentLabel.Parent = ParaFrame
	end
	if content and content ~= "" then
		buildContentLabel(content)
	end

	local controller = {}
	function controller:Set(newTitle, newContent)
		if newTitle ~= nil then
			TitleLabel.Text = tostring(newTitle)
		end
		if newContent ~= nil then
			newContent = tostring(newContent)
			if newContent == "" then
				if ContentLabel then
					ContentLabel:Destroy()
					ContentLabel = nil
				end
			elseif ContentLabel then
				ContentLabel.Text = newContent
			else
				buildContentLabel(newContent)
			end
		end
	end
	function controller:SetTitle(newTitle)
		controller:Set(newTitle, nil)
	end
	function controller:SetContent(newContent)
		controller:Set(nil, newContent)
	end
	function controller:Get()
		return TitleLabel.Text, ContentLabel and ContentLabel.Text or ""
	end
	controller.Frame = ParaFrame
	controller.TitleLabel = TitleLabel

	reg(parent, ParaFrame, title)
	return ParaFrame, TitleLabel, ContentLabel, controller
end

function BulbGui:CreateInput(config)
	config = config or {}
	local text = config.Name or "Input"
	local placeholder = config.PlaceholderText or "Enter text..."
	local default = config.CurrentValue or config.Default or ""
	local callback = config.Callback or function() end
	local flag = config.Flag
	local removeTextAfterFocusLost = config.RemoveTextAfterFocusLost or false
	local currentValue = default
	if flag and self._savedFlags and self._savedFlags[flag] ~= nil then
		currentValue = self._savedFlags[flag]
	end

	local parent = getParent(self, config)
	flowOf[parent] = nil
	local InputFrame = makeRow(parent, 40)
	local InputLabel = label(InputFrame, {
		Size = UDim2.new(0.35, 0, 1, 0), Position = UDim2.new(0, 14, 0, 0), Text = text, Font = F_M,
		TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "text")
	addDescription(InputFrame, InputLabel, config.Description)

	local InputBox = Instance.new("TextBox")
	InputBox.Size = UDim2.new(0.6, -12, 0, 28)
	InputBox.Position = UDim2.new(0.4, 0, 0.5, 0)
	InputBox.AnchorPoint = Vector2.new(0, 0.5)
	InputBox.Text = tostring(currentValue)
	InputBox.PlaceholderText = placeholder
	InputBox.Font = F_R
	InputBox.TextSize = 12
	InputBox.TextXAlignment = LEFT
	InputBox.ClearTextOnFocus = false
	InputBox.BorderSizePixel = 0
	bind(InputBox, "BackgroundColor3", "bg950")
	bind(InputBox, "PlaceholderColor3", "dim2")
	bind(InputBox, "TextColor3", "text")
	InputBox.Parent = InputFrame
	corner(InputBox, 8)
	local IStroke = stroke(InputBox, "border", 1)

	local InputPadding = Instance.new("UIPadding")
	InputPadding.PaddingLeft = UDim.new(0, 9)
	InputPadding.PaddingRight = UDim.new(0, 9)
	InputPadding.Parent = InputBox

	local function saveValue(value)
		currentValue = value
		if flag then
			if not self._savedFlags then self._savedFlags = {} end
			self._savedFlags[flag] = value
			if self._saveConfig then pcall(function() self:_saveConfig() end) end
		end
	end

	InputBox.Focused:Connect(function()
		smoothTween(IStroke, {Color = T.acc})
	end)
	InputBox.FocusLost:Connect(function()
		smoothTween(IStroke, {Color = T.border})
		local inputValue = InputBox.Text
		saveValue(inputValue)
		pcall(callback, inputValue)
		if removeTextAfterFocusLost then
			InputBox.Text = ""
		end
	end)
	if not removeTextAfterFocusLost then
		InputBox:GetPropertyChangedSignal("Text"):Connect(function()
			local inputValue = InputBox.Text
			saveValue(inputValue)
			pcall(callback, inputValue)
		end)
	end

	reg(parent, InputFrame, text)
	return {
		Frame = InputFrame,
		Box = InputBox,
		Label = InputLabel,
		Set = function(_, newValue)
			InputBox.Text = tostring(newValue)
			saveValue(newValue)
			pcall(callback, newValue)
		end,
		Get = function()
			return currentValue
		end
	}
end

function BulbGui:CreateToggle(config)
	config = config or {}
	local text = config.Name or "Toggle"
	local flag = config.Flag
	local callback = config.Callback or function() end
	local current = config.CurrentValue or false
	if flag and self._savedFlags and self._savedFlags[flag] ~= nil then
		current = self._savedFlags[flag]
	end

	local parent = getParent(self, config)
	local compact = not (config.Description and config.Description ~= "")
	local holder, flow = parent, nil
	if compact then
		flow = getFlow(parent)
		holder = flow.Frame
	else
		flowOf[parent] = nil
	end
	local ToggleFrame = makeRow(holder, 40)

	local ToggleLabel = label(ToggleFrame, {
		Size = UDim2.new(1, -72, 1, 0), Position = UDim2.new(0, 14, 0, 0), Text = text, Font = F_M,
		TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, function() return current and T.text or T.dim end)
	addDescription(ToggleFrame, ToggleLabel, config.Description)

	local ToggleBtn = Instance.new("TextButton")
	ToggleBtn.Size = UDim2.new(0, 38, 0, 20)
	ToggleBtn.Position = UDim2.new(1, -50, 0.5, 0)
	ToggleBtn.AnchorPoint = Vector2.new(0, 0.5)
	ToggleBtn.Text = ""
	ToggleBtn.AutoButtonColor = false
	ToggleBtn.BorderSizePixel = 0
	bind(ToggleBtn, "BackgroundColor3", function() return current and T.acc or T.border end)
	ToggleBtn.Parent = ToggleFrame
	corner(ToggleBtn, 10)

	local Circle = Instance.new("Frame")
	Circle.Size = UDim2.new(0, 14, 0, 14)
	Circle.Position = current and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
	Circle.AnchorPoint = Vector2.new(0, 0.5)
	Circle.BorderSizePixel = 0
	bind(Circle, "BackgroundColor3", function() return current and T.white or T.dim end)
	Circle.Parent = ToggleBtn
	corner(Circle, 7)

	local function applyMode(n)
		if not compact then return end
		if n > 1 then
			ToggleFrame.Size = UDim2.new(1 / n, -(6 * (n - 1) / n), 0, 58)
			ToggleLabel.Size = UDim2.new(1, -12, 0, 18)
			ToggleLabel.Position = UDim2.new(0, 6, 0, 8)
			ToggleLabel.TextXAlignment = Enum.TextXAlignment.Center
			ToggleBtn.AnchorPoint = Vector2.new(0.5, 0)
			ToggleBtn.Position = UDim2.new(0.5, 0, 0, 32)
		else
			ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
			ToggleLabel.Size = UDim2.new(1, -72, 1, 0)
			ToggleLabel.Position = UDim2.new(0, 14, 0, 0)
			ToggleLabel.TextXAlignment = LEFT
			ToggleBtn.AnchorPoint = Vector2.new(0, 0.5)
			ToggleBtn.Position = UDim2.new(1, -50, 0.5, 0)
		end
	end
	if flow then flow.Add(ToggleFrame, measure(text, 13, F_M), applyMode) end

	local function setState(state)
		current = state
		smoothTween(ToggleBtn, {BackgroundColor3 = state and T.acc or T.border}, 0.2)
		smoothTween(Circle, {
			Position = state and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
			BackgroundColor3 = state and T.white or T.dim,
		}, 0.2)
		smoothTween(ToggleLabel, {TextColor3 = state and T.text or T.dim}, 0.2)
		if flag then
			if not self._savedFlags then self._savedFlags = {} end
			self._savedFlags[flag] = current
			if self._saveConfig then pcall(function() self:_saveConfig() end) end
		end
		pcall(callback, current)
	end

	ToggleBtn.MouseButton1Click:Connect(function()
		setState(not current)
	end)
	if current then
		task.defer(function() setState(true) end)
	end

	reg(parent, ToggleFrame, text)
	return {
		Frame = ToggleFrame,
		Button = ToggleBtn,
		Label = ToggleLabel,
		State = function() return current end,
		Set = setState
	}
end

function BulbGui:CreateSlider(config)
	config = config or {}
	local text = config.Name or "Slider"
	local min, max = (config.Range and config.Range[1]) or 0, (config.Range and config.Range[2]) or 100
	local increment = config.Increment or 1
	local default = config.CurrentValue or min
	local callback = config.Callback or function() end
	local suffix = config.Suffix or ""
	local flag = config.Flag
	local value = default
	if flag and self._savedFlags and self._savedFlags[flag] ~= nil then
		value = self._savedFlags[flag]
	end

	local parent = getParent(self, config)
	flowOf[parent] = nil
	local SliderFrame = makeRow(parent, 54)
	local SliderLabel = label(SliderFrame, {
		Size = UDim2.new(1, -92, 0, 20), Position = UDim2.new(0, 14, 0, 6), Text = text, Font = F_M,
		TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "text")
	addDescription(SliderFrame, SliderLabel, config.Description)

	local ValueBox = Instance.new("TextBox")
	ValueBox.Size = UDim2.new(0, 66, 0, 22)
	ValueBox.Position = UDim2.new(1, -76, 0, 6)
	ValueBox.Text = fmt(value) .. suffix
	ValueBox.Font = F_C
	ValueBox.TextSize = 12
	ValueBox.TextXAlignment = Enum.TextXAlignment.Center
	ValueBox.ClearTextOnFocus = false
	ValueBox.BorderSizePixel = 0
	bind(ValueBox, "BackgroundColor3", "bg950")
	bind(ValueBox, "TextColor3", "acc")
	ValueBox.Parent = SliderFrame
	corner(ValueBox, 7)

	local Hit = Instance.new("Frame")
	Hit.Size = UDim2.new(1, -28, 0, 24)
	Hit.Position = UDim2.new(0, 14, 1, -28)
	Hit.BackgroundTransparency = 1
	Hit.Parent = SliderFrame

	local SliderBg = Instance.new("Frame")
	SliderBg.Size = UDim2.new(1, 0, 0, 5)
	SliderBg.Position = UDim2.new(0, 0, 0.5, 0)
	SliderBg.AnchorPoint = Vector2.new(0, 0.5)
	SliderBg.BorderSizePixel = 0
	bind(SliderBg, "BackgroundColor3", "border")
	SliderBg.Parent = Hit
	corner(SliderBg, 3)

	local SliderFill = Instance.new("Frame")
	SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
	SliderFill.BorderSizePixel = 0
	bind(SliderFill, "BackgroundColor3", "acc")
	SliderFill.Parent = SliderBg
	corner(SliderFill, 3)

	local SliderButton = Instance.new("Frame")
	SliderButton.Size = UDim2.new(0, 15, 0, 15)
	SliderButton.Position = UDim2.new((value - min) / (max - min), 0, 0.5, 0)
	SliderButton.AnchorPoint = Vector2.new(0.5, 0.5)
	SliderButton.BorderSizePixel = 0
	SliderButton.ZIndex = 5
	bind(SliderButton, "BackgroundColor3", "acc")
	SliderButton.Parent = SliderBg
	corner(SliderButton, 8)
	stroke(SliderButton, "bg900", 2)

	local dragging = false
	local function updateValue(newValue, skipCallback)
		newValue = math.round(newValue / increment) * increment
		newValue = math.clamp(newValue, min, max)
		value = newValue
		local percent = (value - min) / (max - min)
		SliderFill.Size = UDim2.new(percent, 0, 1, 0)
		SliderButton.Position = UDim2.new(percent, 0, 0.5, 0)
		ValueBox.Text = fmt(value) .. suffix
		if flag then
			if not self._savedFlags then self._savedFlags = {} end
			self._savedFlags[flag] = value
			if self._saveConfig then pcall(function() self:_saveConfig() end) end
		end
		if not skipCallback then
			pcall(callback, value)
		end
	end

	local function updateFromX(x)
		local relativeX = x - SliderBg.AbsolutePosition.X
		local percent = math.clamp(relativeX / SliderBg.AbsoluteSize.X, 0, 1)
		updateValue(min + (max - min) * percent)
	end

	Hit.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			smoothTween(SliderButton, {Size = UDim2.new(0, 20, 0, 20)}, 0.1)
			updateFromX(input.Position.X)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					smoothTween(SliderButton, {Size = UDim2.new(0, 15, 0, 15)}, 0.15)
				end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateFromX(input.Position.X)
		end
	end)
	ValueBox.FocusLost:Connect(function()
		local cleaned = ValueBox.Text
		if suffix ~= "" then
			cleaned = cleaned:gsub(escapePattern(suffix), "")
		end
		cleaned = cleaned:gsub("%s+", "")
		local typed = tonumber(cleaned)
		if typed then
			updateValue(typed, false)
		else
			ValueBox.Text = fmt(value) .. suffix
		end
	end)
	updateValue(value, false)

	reg(parent, SliderFrame, text)
	return {
		Frame = SliderFrame,
		Set = function(_, newValue)
			updateValue(newValue, true)
		end
	}
end

function BulbGui:CreateDropdown(config)
	config = config or {}
	local text = config.Name or "Dropdown"
	local options = config.Options or {"Option 1", "Option 2"}
	local currentOption = config.CurrentOption or options[1]
	local multipleOptions = config.MultipleOptions or false
	local callback = config.Callback or function() end
	local flag = config.Flag
	local current = multipleOptions and {} or currentOption
	if flag and self._savedFlags and self._savedFlags[flag] ~= nil then
		current = self._savedFlags[flag]
	end
	if multipleOptions then
		if type(current) ~= "table" then
			current = (type(current) == "string" and current ~= "") and {[current] = true} or {}
		end
	elseif type(current) == "table" then
		current = current[1]
	end

	local parent = getParent(self, config)
	flowOf[parent] = nil
	local Wrap = Instance.new("Frame")
	Wrap.Size = UDim2.new(1, 0, 0, 0)
	Wrap.AutomaticSize = Enum.AutomaticSize.Y
	Wrap.BackgroundTransparency = 1
	Wrap:SetAttribute("BulbCard", parent:GetAttribute("BulbCard"))
	Wrap.Parent = parent
	local WL = Instance.new("UIListLayout")
	WL.Padding = UDim.new(0, 4)
	WL.SortOrder = Enum.SortOrder.LayoutOrder
	WL.Parent = Wrap

	local DropdownFrame = makeRow(Wrap, 40)
	DropdownFrame.LayoutOrder = 1
	local Label = label(DropdownFrame, {
		Size = UDim2.new(0.42, -14, 1, 0), Position = UDim2.new(0, 14, 0, 0), Text = text, Font = F_M,
		TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "text")
	addDescription(DropdownFrame, Label, config.Description)

	local DropBtn = Instance.new("TextButton")
	DropBtn.Size = UDim2.new(0.55, -10, 0, 28)
	DropBtn.Position = UDim2.new(0.45, 0, 0.5, 0)
	DropBtn.AnchorPoint = Vector2.new(0, 0.5)
	DropBtn.Text = ""
	DropBtn.AutoButtonColor = false
	DropBtn.BorderSizePixel = 0
	bind(DropBtn, "BackgroundColor3", "bg950")
	DropBtn.Parent = DropdownFrame
	corner(DropBtn, 8)
	local DropStroke = stroke(DropBtn, "border", 1)

	local DropLabel = label(DropBtn, {
		Size = UDim2.new(1, -30, 1, 0), Position = UDim2.new(0, 10, 0, 0),
		Text = multipleOptions and "None" or (current or ""), Font = F_R, TextSize = 12,
		TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "text")

	local Arrow = label(DropBtn, {
		Size = UDim2.new(0, 18, 1, 0), Position = UDim2.new(1, -22, 0, 0), Text = "v", Font = F_B, TextSize = 12,
	}, "dim")

	local OptionFrame = Instance.new("Frame")
	OptionFrame.Size = UDim2.new(1, 0, 0, 0)
	OptionFrame.AutomaticSize = Enum.AutomaticSize.Y
	OptionFrame.BorderSizePixel = 0
	OptionFrame.Visible = false
	OptionFrame.LayoutOrder = 2
	bind(OptionFrame, "BackgroundColor3", "bg950")
	OptionFrame.Parent = Wrap
	corner(OptionFrame, 10)
	stroke(OptionFrame, "border", 1)

	local Layout = Instance.new("UIListLayout")
	Layout.FillDirection = Enum.FillDirection.Horizontal
	Layout.Wraps = true
	Layout.Padding = UDim.new(0, 6)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.Parent = OptionFrame

	local Padding = Instance.new("UIPadding")
	Padding.PaddingTop = UDim.new(0, 8)
	Padding.PaddingBottom = UDim.new(0, 8)
	Padding.PaddingLeft = UDim.new(0, 8)
	Padding.PaddingRight = UDim.new(0, 8)
	Padding.Parent = OptionFrame

	local optionButtons = {}
	local expanded = false

	local function saveFlag()
		if flag then
			if not self._savedFlags then self._savedFlags = {} end
			self._savedFlags[flag] = current
			if self._saveConfig then pcall(function() self:_saveConfig() end) end
		end
	end

	local function updateDisplay()
		if multipleOptions then
			local count = 0
			for _ in pairs(current) do count = count + 1 end
			DropLabel.Text = count > 0 and count .. " Selected" or "None"
		else
			DropLabel.Text = current or ""
		end
	end

	local function setExpanded(state)
		expanded = state
		if state then
			OptionFrame.Visible = true
			for _, d in pairs(optionButtons) do
				d.button.BackgroundTransparency = 1
				d.button.TextTransparency = 1
				smoothTween(d.button, {BackgroundTransparency = 0, TextTransparency = 0}, 0.25)
			end
		else
			OptionFrame.Visible = false
		end
		smoothTween(Arrow, {Rotation = state and 180 or 0}, 0.2)
		smoothTween(DropStroke, {Color = state and T.acc or T.border}, 0.15)
	end

	local function selectOption(opt)
		if multipleOptions then
			if current[opt] then current[opt] = nil else current[opt] = true end
			updateDisplay()
			saveFlag()
			pcall(callback, current)
		else
			current = opt
			updateDisplay()
			setExpanded(false)
			saveFlag()
			pcall(callback, current)
		end
	end

	local function isSel(opt)
		if multipleOptions then return current[opt] and true or false end
		return opt == current
	end

	local function createOptionButton(opt)
		local OptBtn = Instance.new("TextButton")
		OptBtn.Size = UDim2.new(0, measure(opt, 12, F_R) + 24, 0, 26)
		OptBtn.Text = opt
		OptBtn.Font = F_R
		OptBtn.TextSize = 12
		OptBtn.AutoButtonColor = false
		OptBtn.BorderSizePixel = 0
		bind(OptBtn, "BackgroundColor3", function() return isSel(opt) and T.acc or T.border end)
		bind(OptBtn, "TextColor3", function() return isSel(opt) and T.bg950 or T.text end)
		OptBtn.Parent = OptionFrame
		corner(OptBtn, 13)

		local function refreshSelected(sel)
			smoothTween(OptBtn, {BackgroundColor3 = sel and T.acc or T.border, TextColor3 = sel and T.bg950 or T.text}, 0.15)
		end

		OptBtn.MouseEnter:Connect(function()
			if not isSel(opt) then smoothTween(OptBtn, {BackgroundColor3 = T.border:Lerp(T.acc, 0.25)}, 0.12) end
		end)
		OptBtn.MouseLeave:Connect(function()
			if not isSel(opt) then smoothTween(OptBtn, {BackgroundColor3 = T.border}, 0.12) end
		end)
		OptBtn.MouseButton1Click:Connect(function()
			selectOption(opt)
			for k, btnData in pairs(optionButtons) do
				btnData.refresh(isSel(k))
			end
		end)
		optionButtons[opt] = {button = OptBtn, refresh = refreshSelected}
		return OptBtn
	end

	for _, opt in ipairs(options) do
		createOptionButton(opt)
	end

	DropBtn.MouseButton1Click:Connect(function()
		setExpanded(not expanded)
	end)
	updateDisplay()

	reg(parent, Wrap, text)
	return {
		Frame = Wrap,
		Button = DropBtn,
		Label = Label,
		State = function() return current end,
		Set = function(_, value)
			if multipleOptions then
				if type(value) == "table" then
					current = value
				else
					selectOption(value)
				end
			else
				if table.find(options, value) then
					current = value
				end
			end
			updateDisplay()
			saveFlag()
			for k, btnData in pairs(optionButtons) do
				btnData.refresh(isSel(k))
			end
			pcall(callback, current)
		end,
		Add = function(_, newOption)
			if table.find(options, newOption) then return end
			table.insert(options, newOption)
			createOptionButton(newOption)
		end,
		Remove = function(_, optionToRemove)
			local index = table.find(options, optionToRemove)
			if not index then return end
			table.remove(options, index)
			if optionButtons[optionToRemove] then
				optionButtons[optionToRemove].button:Destroy()
				optionButtons[optionToRemove] = nil
			end
			if multipleOptions then
				current[optionToRemove] = nil
				updateDisplay()
			else
				if current == optionToRemove and #options > 0 then
					selectOption(options[1])
				end
			end
			saveFlag()
		end,
		Clear = function(_)
			for _, btnData in pairs(optionButtons) do
				btnData.button:Destroy()
			end
			options = {}
			optionButtons = {}
			if multipleOptions then current = {} else current = nil end
			updateDisplay()
			saveFlag()
		end,
		Refresh = function(_, newOptions, keepCurrent)
			for _, btnData in pairs(optionButtons) do
				btnData.button:Destroy()
			end
			optionButtons = {}
			options = newOptions or options
			if multipleOptions then
				if not keepCurrent then current = {} end
			else
				if not keepCurrent or current == nil or not table.find(options, current) then
					current = options[1] or nil
				end
			end
			for _, opt in ipairs(options) do
				createOptionButton(opt)
			end
			updateDisplay()
			saveFlag()
		end
	}
end

function BulbGui:CreateKeybind(config)
	config = config or {}
	local text = config.Name or "Keybind"
	local currentKey = config.CurrentKeybind or Enum.KeyCode.F
	local holdToInteract = config.HoldToInteract or false
	local callback = config.Callback or function() end
	local flag = config.Flag
	if flag and self._savedFlags and type(self._savedFlags[flag]) == "string" then
		local ok, saved = pcall(function() return Enum.KeyCode[self._savedFlags[flag]] end)
		if ok and saved then currentKey = saved end
	end

	local parent = getParent(self, config)
	flowOf[parent] = nil
	local KeyFrame = makeRow(parent, 40)
	local KeyLabel = label(KeyFrame, {
		Size = UDim2.new(1, -118, 1, 0), Position = UDim2.new(0, 14, 0, 0), Text = text, Font = F_M,
		TextSize = 13, TextXAlignment = LEFT, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "text")
	addDescription(KeyFrame, KeyLabel, config.Description)

	local waitingForKey = false
	local KeyButton = Instance.new("TextButton")
	KeyButton.Size = UDim2.new(0, 96, 0, 26)
	KeyButton.Position = UDim2.new(1, -104, 0.5, 0)
	KeyButton.AnchorPoint = Vector2.new(0, 0.5)
	KeyButton.Text = "[" .. currentKey.Name .. "]"
	KeyButton.Font = F_C
	KeyButton.TextSize = 12
	KeyButton.AutoButtonColor = false
	KeyButton.BorderSizePixel = 0
	bind(KeyButton, "BackgroundColor3", function() return waitingForKey and T.border or T.soft end)
	bind(KeyButton, "TextColor3", function() return waitingForKey and T.text or T.acc end)
	KeyButton.Parent = KeyFrame
	corner(KeyButton, 8)
	stroke(KeyButton, "accBorder", 1)

	local function setKey(newKey)
		currentKey = newKey
		waitingForKey = false
		KeyButton.Text = "[" .. newKey.Name .. "]"
		smoothTween(KeyButton, {BackgroundColor3 = T.soft, TextColor3 = T.acc}, 0.15)
		if flag then
			if not self._savedFlags then self._savedFlags = {} end
			self._savedFlags[flag] = newKey.Name
			if self._saveConfig then pcall(function() self:_saveConfig() end) end
		end
	end

	KeyButton.MouseEnter:Connect(function()
		if not waitingForKey then smoothTween(KeyButton, {BackgroundColor3 = T.accBorder}, 0.15) end
	end)
	KeyButton.MouseLeave:Connect(function()
		if not waitingForKey then smoothTween(KeyButton, {BackgroundColor3 = T.soft}, 0.15) end
	end)
	KeyButton.MouseButton1Click:Connect(function()
		if waitingForKey then return end
		waitingForKey = true
		KeyButton.Text = "Press Key..."
		smoothTween(KeyButton, {BackgroundColor3 = T.border, TextColor3 = T.text}, 0.15)
		local conn
		conn = UIS.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
				conn:Disconnect()
				setKey(input.KeyCode)
			end
		end)
	end)

	if holdToInteract then
		UIS.InputBegan:Connect(function(input, gpe)
			if not gpe and not waitingForKey and input.KeyCode == currentKey then
				pcall(callback, true)
			end
		end)
		UIS.InputEnded:Connect(function(input)
			if not waitingForKey and input.KeyCode == currentKey then
				pcall(callback, false)
			end
		end)
	else
		UIS.InputBegan:Connect(function(input, gpe)
			if not gpe and not waitingForKey and input.KeyCode == currentKey then
				pcall(callback)
			end
		end)
	end

	reg(parent, KeyFrame, text)
	return {
		Frame = KeyFrame,
		Button = KeyButton,
		Label = KeyLabel,
		Key = function() return currentKey end,
		Set = setKey
	}
end

return BulbGui
