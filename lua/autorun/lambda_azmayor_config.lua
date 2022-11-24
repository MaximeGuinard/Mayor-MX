azmayor = azmayor or {}
azmayor = {
	['color'] = {
		['blur'] = 1.5,
		['background'] = Color( 90, 94, 107, 130 ),
		['text'] = Color( 255, 255, 255, 200 ),
		['button'] = Color( 128, 128, 128, 100 ),
		['switsh'] = Color( 200, 10, 10, 100 ),
		['line'] = Color( 200, 10, 10, 100 ),
	},

	['config'] = {
		['msgprint'] = '[AzMayor]',
	},


	['text'] = {
		['title'] = 'MENU DU MAIRE',
		['lawstitle'] = 'LOIS EXISTANT :',
		['nogoodteam'] = "Vous n'avez pas le bon métier",
		['wanted'] = 'RECHERCHER UNE PERSONNE',
		['blaw'] = 'Ajouter un lois',
		['tlaw'] = 'Écriver une lois correcte',
		['removealllaw'] = "Voulez-vous vraiment suprimer toutes les lois",
		['removealaw'] = "Quel lois voulez-vous suprimer",
		['cancel'] = 'Annulé',
		['accept'] = "Accepter",
		['selectplayer'] = "Vous-avez selectionner %s",

		['lockdownactive'] = "Vous avez déjà un Couvre-Feu en cour",
		['lockdownstart'] = "Vous avez lancé un Couvre-Feu",
		['lockdownsstart'] = "Vous devez dabors activer le Couvre-Feu",
		['lockdownend'] = "Vous avez arreter le Couvre-Feu",
	},
}

azmayor.alowteam = {
	['Citoyen'] = true,
	['Banquier'] = true,
	["Chauffeur"] = true,
	['Cuisinier'] = true,
	['Agent sous couverture'] = true,
	['Gendarme (Gendarmerie)'] = true,
	['Juge'] = true,
	['Avocat'] = true,
	['Garde du corps du Maire'] = true,
	['Agent de sécurité / Gardien de prison'] = true,
	['Pompier'] = true,
	["Armurier"] = true,
	['Ambulancier'] = true,
	['Infirmier'] = true,
	['DIR'] = true,
	['Négociateur (GIGN)'] = true,
	['Caporal (GIGN)'] = true,
	['Adjudant (GIGN)'] = true,
	["Capitaine (GIGN)"] = true,
	['Colonel (GIGN)'] = true,
	["Marchand d'arme CSGO"] = true,
}

azmayor.button = {
	{ name = 'Fermer', action = function() AzMayorClose() end, },
	{ name = 'Lancer le couvre-feu', action = function() AzMayorLockdown() end, },
	{ name = 'Terminer le couvre-feu', action = function() AzMayorUnLockdown() end, },
	{ name = 'Rechercher une personne', action = function() AzMayorWW( 'RECHERCHER UNE PERSONNE', 'Écriver la reson de la recherche', 'vous avez mi un avie de rechercher sur %s', '/wanted') end, },
	{ name = "Mettre un mandat", action = function() AzMayorWW( "Metre un mandat", 'Écrive la reson du mandat de perquisition', 'vous avez mi un mandat sur %s', '/warrant') end, },
	{ name = "Virer une personne", action = function() AzMayorWW( "VIRER UNE PERSONNE", 'Ecriver la reson pour virer cette personne', 'vous avez virer %s', '/demote') end, },
	{ name = "Supprimer une lois", action = function() AzMayorRemoveLaws() end, },
	{ name = "Supprimer toutes les lois", action = function() AzMayorRemoveAllLaws() end, },
}