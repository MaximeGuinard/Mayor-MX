AddCSLuaFile("cl_init.lua") 
AddCSLuaFile("shared.lua") 
 
include("shared.lua")
 
function ENT:Initialize()
 
	self:SetModel( 'models/props_lab/workspace003.mdl' )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )  
	self:SetSolid( SOLID_VPHYSICS )    
	self:SetUseType( SIMPLE_USE ) 
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:AcceptInput( strName, _, Caller )
	if azmayor.alowteam[ team.GetName( Caller:Team() ) ] then 
		return DarkRP.notify( Caller, 0.1, 3, azmayor['text']['nogoodteam'])
	end
	
	if strName == "Use" && IsValid( Caller ) && Caller:IsPlayer() then

		net.Start( "AzMayor:Menu:Open" )
		net.WriteEntity( self )
		net.Send( Caller )
		
	end
end

