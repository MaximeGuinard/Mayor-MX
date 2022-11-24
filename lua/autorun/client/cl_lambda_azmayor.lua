surface.CreateFont( 'AzMayor:Font:15', { font = 'Arial', size = 15, weight = 500, } )
surface.CreateFont( 'AzMayor:Font:20', { font = 'Arial', size = 20, weight = 500, } )
surface.CreateFont( 'AzMayor:Font:30', { font = 'Arial', size = 30, weight = 500, } )

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end
net.Receive( 'AzMayor:Menu:Open', function()	
	AzMayor_Base = vgui.Create( 'DFrame' )
	AzMayor_Base:SetSize( 850, 500 )
	AzMayor_Base:Center()
	AzMayor_Base:SetTitle( '' )
	AzMayor_Base:MakePopup()
	AzMayor_Base:SetDraggable( false )
	AzMayor_Base:ShowCloseButton( false )
	AzMayor_Base.Paint = function( self, w, h )
		DrawBlur( self, azmayor['color']['blur'] )

		draw.RoundedBox( 0, 600, 80, 250, h, azmayor['color']['background'] )
	    draw.RoundedBox( 0, 0, 80, w / 1.43, h, azmayor['color']['background'] )

		draw.RoundedBox( 0, 0, 0, w, 80 - 5, azmayor['color']['background'] )
		draw.DrawText( azmayor['text']['title'], 'AzMayor:Font:30', w / 2, h / 5 - 80, azmayor['color']['text'], TEXT_ALIGN_CENTER )
		surface.SetDrawColor( azmayor['color']['line'] )
		surface.DrawLine( 320, 45, 530, 45)

		draw.DrawText( azmayor['text']['lawstitle'], 'AzMayor:Font:20', w / 3, h / 3 - 80, azmayor['color']['text'], TEXT_ALIGN_CENTER )
		surface.SetDrawColor( azmayor['color']['line'] )
		surface.DrawLine( 215, 105, 350, 105)
	end

	local str = ''
	for k, v in pairs( DarkRP.getLaws() ) do 
	   str = str.. k .. '.' .. ' ' .. v .. '\n'
	end

	ltext = vgui.Create( 'DLabel', AzMayor_Base )
	ltext:SetSize( 600, 100 )
	ltext:SetPos( 20, 120 )
	ltext:SetText( str )
	ltext:SetFont( 'AzMayor:Font:20' )
	ltext:SetAutoStretchVertical( true )
	ltext:SizeToContents()

	local e = 0
	for k, v in pairs( azmayor.button ) do

		AzMayor_Button = vgui.Create( 'DButton', AzMayor_Base )
		AzMayor_Button:SetSize( 240, 40 )
		AzMayor_Button:SetPos( 605, 85 + 45 * e )
		AzMayor_Button:SetText( v.name )
		AzMayor_Button:SetTextColor( azmayor['color']['text'] )
		AzMayor_Button:SetFont( 'AzMayor:Font:15' )
		AzMayor_Button.Paint = function( self, w, h )
			if self:IsHovered() then
				draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
			end
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
		end
		AzMayor_Button.DoClick = v.action

		e = e + 1
	end

	AzMayor_TextEntry = vgui.Create( 'DTextEntry', AzMayor_Base )
	AzMayor_TextEntry:SetSize( 585, 45 )
	AzMayor_TextEntry:SetPos( 5, 400 )
	AzMayor_TextEntry:SetText( azmayor['text']['tlaw'] )
	AzMayor_TextEntry.OnGetFocus = function( self ) 
		if self:GetText() == azmayor['text']['tlaw'] then
			self:SetText( '' )
		end
	end
	AzMayor_TextEntry.OnLoseFocus = function( self ) 
		if self:GetText() == '' then
			self:SetText( azmayor['text']['tlaw'] )
		end
	end	
	AzMayor_TextEntry.OnEnter = function()
	end
	AzMayor_TextEntry.Paint = function(self) 
		draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), azmayor['color']['button'] ) 
		self:DrawTextEntryText( azmayor['color']['text'], Color( 0, 0, 0, 255 ), Color( 0, 0, 0, 255 ) ) 
	end

	AzMayor_Addlaw = vgui.Create( 'DButton', AzMayor_Base )
	AzMayor_Addlaw:SetSize( 585, 45 )
	AzMayor_Addlaw:SetPos( 5, 450)
	AzMayor_Addlaw:SetText( azmayor['text']['blaw'] )
	AzMayor_Addlaw:SetTextColor( azmayor['color']['text'] )
	AzMayor_Addlaw:SetFont( 'AzMayor:Font:15' )
	AzMayor_Addlaw.Paint = function( self, w, h )
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
		end
		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
	end
	AzMayor_Addlaw.DoClick = function() 
		RunConsoleCommand( 'say', '/addlaw '.. AzMayor_TextEntry:GetValue() )
	end
end)

function AzMayorClose( base )
	AzMayor_Base:Close()
end

function AzMayorRemoveLaws( ply )
	az_rl = vgui.Create( 'DFrame' )
	az_rl:SetSize( 350, 125 )
	az_rl:Center()
	az_rl:SetTitle( '' )
	az_rl:MakePopup()
	az_rl:SetDraggable( false )
	az_rl:ShowCloseButton( false )
	az_rl.Paint = function( self, w, h )
		DrawBlur( self, azmayor['color']['blur'] )

		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['background'] )
		draw.DrawText( azmayor['text']['removealaw'], 'AzMayor:Font:20', w / 2, 10, azmayor['color']['text'], TEXT_ALIGN_CENTER )
	end

	az_te = vgui.Create( "DTextEntry", az_rl )
	az_te:SetSize( 330, 35 )
	az_te:SetPos( 10, 40 )
	az_te:SetText( azmayor['text']['tlaw'] )
	az_te.OnGetFocus = function( self ) 
		if self:GetText() == azmayor['text']['tlaw'] then
			self:SetText( '' )
		end
	end
	az_te.OnLoseFocus = function( self ) 
		if self:GetText() == '' then
			self:SetText( azmayor['text']['tlaw'] )
		end
	end	
	az_te.OnEnter = function()
	end
	az_te.Paint = function(self) 
		draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), azmayor['color']['button'] ) 
		self:DrawTextEntryText( azmayor['color']['text'], Color( 0, 0, 0, 255 ), Color( 0, 0, 0, 255 ) ) 
	end

	az_rla = vgui.Create( 'DButton', az_rl )
	az_rla:SetSize( 160, 40 )
	az_rla:SetPos( 10, 80 )
	az_rla:SetText( 'Accepter' )
	az_rla:SetTextColor( azmayor['color']['text'] )
	az_rla:SetFont( 'AzMayor:Font:15' )
	az_rla.Paint = function( self, w, h )
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
		end
		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
	end
	az_rla.DoClick = function() 
		RunConsoleCommand( 'say', '/removelaw'.. ' ' .. az_te:GetValue() )
		az_rl:Close()
	end

	az_rlr = vgui.Create( 'DButton', az_rl )
	az_rlr:SetSize( 160, 40 )
	az_rlr:SetPos( 180, 80 )
	az_rlr:SetText( 'Annulé' )
	az_rlr:SetTextColor( azmayor['color']['text'] )
	az_rlr:SetFont( 'AzMayor:Font:15' )
	az_rlr.Paint = function( self, w, h )
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
		end
		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
	end
	az_rlr.DoClick = function() 
		az_rl:Close()
	end
	AzMayor_Base:Close()

end

local lockdown
function AzMayorLockdown( ply )
	lockdown = GetGlobalBool( 'DarkRP_LockDown' )

	if lockdown == true then
		chat.AddText( Color( 255, 0, 0 ), azmayor['config']['msgprint'], Color( 250, 250, 250 ), azmayor['text']['lockdownactive'] )	
	else
		chat.AddText( Color( 255, 0, 0 ), azmayor['config']['msgprint'], Color( 250, 250, 250 ), azmayor['text']['lockdownstart'] )
		RunConsoleCommand( 'darkrp', 'lockdown')
		AzMayor_Base:Close()
	end	

end

function AzMayorUnLockdown()
	lockdown = GetGlobalBool( 'DarkRP_LockDown' )

	if lockdown == false then
		chat.AddText( Color( 255, 0, 0 ), azmayor['config']['msgprint'], Color( 250, 250, 250 ), azmayor['text']['lockdownsstart'] )	
	else
		chat.AddText( Color( 255, 0, 0 ), azmayor['config']['msgprint'], Color( 250, 250, 250 ), azmayor['text']['lockdownend'] )
		RunConsoleCommand( 'darkrp', 'unlockdown')
		AzMayor_Base:Close()
	end	
	
end

function AzMayorRemoveAllLaws()
	az_ral = vgui.Create( 'DFrame' )
	az_ral:SetSize( 350, 100 )
	az_ral:Center()
	az_ral:SetTitle( '' )
	az_ral:MakePopup()
	az_ral:SetDraggable( false )
	az_ral:ShowCloseButton( false )
	az_ral.Paint = function( self, w, h )
		DrawBlur( self, azmayor['color']['blur'] )

		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['background'] )
		draw.DrawText( azmayor['text']['removealllaw'], 'AzMayor:Font:20', w / 2, 10, azmayor['color']['text'], TEXT_ALIGN_CENTER )
	end

	az_rala = vgui.Create( 'DButton', az_ral )
	az_rala:SetSize( 160, 40 )
	az_rala:SetPos( 10, 50 )
	az_rala:SetText( 'Accepter' )
	az_rala:SetTextColor( azmayor['color']['text'] )
	az_rala:SetFont( 'AzMayor:Font:15' )
	az_rala.Paint = function( self, w, h )
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
		end
		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
	end
	az_rala.DoClick = function() 
		RunConsoleCommand( 'darkrp', 'resetlaws')
		az_ral:Close()
	end

	az_ralr = vgui.Create( 'DButton', az_ral )
	az_ralr:SetSize( 160, 40 )
	az_ralr:SetPos( 180, 50 )
	az_ralr:SetText( 'Annulé' )
	az_ralr:SetTextColor( azmayor['color']['text'] )
	az_ralr:SetFont( 'AzMayor:Font:15' )
	az_ralr.Paint = function( self, w, h )
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
		end
		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
	end
	az_ralr.DoClick = function() 
		az_ral:Close()
	end
	AzMayor_Base:Close()
end

function AzMayorWW( text1, text2, text3, cmd )
	AzMayor_BaseWanted = vgui.Create( 'DFrame' )
	AzMayor_BaseWanted:SetSize( 500, 200)
	AzMayor_BaseWanted:Center()
	AzMayor_BaseWanted:SetTitle( '' )
	AzMayor_BaseWanted:MakePopup()
	AzMayor_BaseWanted:SetDraggable( false )
	AzMayor_BaseWanted:ShowCloseButton( false )
	AzMayor_BaseWanted.Paint = function( self, w, h )
		DrawBlur( self, azmayor['color']['blur'] )

		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['background'] )
		draw.DrawText( string.upper( text1 ), 'AzMayor:Font:20', w / 2, 10, azmayor['color']['text'], TEXT_ALIGN_CENTER )
	end

	AzMayor_AllBox = vgui.Create( "DComboBox", AzMayor_BaseWanted )
	AzMayor_AllBox:SetSize( 480, 20 )
	AzMayor_AllBox:SetPos( 10, 70 )
	for k,v in pairs(player.GetAll()) do
		AzMayor_AllBox:AddChoice( v:Name() )
	end
	AzMayor_AllBox.OnSelect = function( panel, index, value )
		chat.AddText( Color( 255, 0, 0 ), "[AzMayor]", Color( 250, 250, 250 ), string.format(azmayor['text']['selectplayer'],'"' .. value .. '" ')  )
	end

	AzMayor_WReson = vgui.Create( "DTextEntry", AzMayor_BaseWanted )
	AzMayor_WReson:SetSize( 480, 45 )
	AzMayor_WReson:SetPos( 10, 100 )
	AzMayor_WReson:SetText( string.upper( text2 ) )
	AzMayor_WReson.OnGetFocus = function( self )
		if self:GetText() == string.upper( text2 ) then
			self:SetText( '' )
		end
	end
	AzMayor_WReson.OnLoseFocus = function( self ) 
		if self:GetText() == '' then
			self:SetText( string.upper( text2 ) )
		end
	end
	AzMayor_WReson.OnEnter = function( self )
	end
	AzMayor_WReson.Paint = function( self ) 
		draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), azmayor['color']['button'] ) 
		self:DrawTextEntryText( azmayor['color']['text'], Color( 0, 0, 0, 255 ), Color( 0, 0, 0, 255 ) ) 
	end

	AzMayor_WAccept = vgui.Create( 'DButton', AzMayor_BaseWanted )
	AzMayor_WAccept:SetSize( 238, 40 )
	AzMayor_WAccept:SetPos( 10, 152 )
	AzMayor_WAccept:SetText( azmayor['text']['accept'] )
	AzMayor_WAccept:SetTextColor( azmayor['color']['text'] )
	AzMayor_WAccept:SetFont( 'AzMayor:Font:15' )
	AzMayor_WAccept.Paint = function( self, w, h )
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
		end
		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
	end
	AzMayor_WAccept.DoClick = function() 
		local sply = AzMayor_AllBox:GetValue()
		local reson = AzMayor_WReson:GetValue()

		chat.AddText( Color( 255, 0, 0 ), '[AzMayor]', Color( 250, 250, 250 ), string.format( ( text3 ), sply .. ' ' .. 'pour'.. ' ' .. '"'..reson..'"'  ) )
		
		RunConsoleCommand( "say", cmd .. ' ' .. sply ..' '.. reson ) 
		AzMayor_BaseWanted:Close()
	end

	AzMayor_WCancel = vgui.Create( 'DButton', AzMayor_BaseWanted )
	AzMayor_WCancel:SetSize( 238, 40 )
	AzMayor_WCancel:SetPos( 252, 152 )
	AzMayor_WCancel:SetText( azmayor['text']['cancel'] )
	AzMayor_WCancel:SetTextColor( azmayor['color']['text'] )
	AzMayor_WCancel:SetFont( 'AzMayor:Font:15' )
	AzMayor_WCancel.Paint = function( self, w, h )
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['switsh'] )
		end
		draw.RoundedBox( 0, 0, 0, w, h, azmayor['color']['button'] )
	end
	AzMayor_WCancel.DoClick = function() 
		AzMayor_BaseWanted:Close()
	end
	AzMayor_Base:Close()
end


