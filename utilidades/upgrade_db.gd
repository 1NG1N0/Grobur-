extends Node


const ICON_PATH = "res://textures/upgrades/"
const WEAPON_PATH = "res://textures/armas/"

const UPGRADES = {
	"icespear1": {
		"icon": WEAPON_PATH + "medula.png",
		"displayname": "lança de medula ossea",
		"details": "Uma lança de medula ossea e jogada em um inimigo aleatorio",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"icespear2": {
		"icon": WEAPON_PATH + "medula.png",
		"displayname": "lança de medula ossea",
		"details": "Mais 1 lança e jogada",
		"level": "Level: 2",
		"prerequisite": ["icespear1"],
		"type": "weapon"
	},
	"icespear3": {
		"icon": WEAPON_PATH + "medula.png",
		"displayname": "lança de medula ossea",
		"details": "A lança atravessa um inimgo e causa +3 de dano",
		"level": "Level: 3",
		"prerequisite": ["icespear2"],
		"type": "weapon"
	},
	"icespear4": {
		"icon": WEAPON_PATH + "medula.png",
		"displayname": "lança de medula ossea",
		"details": "Mais 2 lança e jogada",
		"level": "Level: 4",
		"prerequisite": ["icespear3"],
		"type": "weapon"
	},
	"javelin1": {
		"icon": WEAPON_PATH + "macrofago.png",
		"displayname": "Macrofago",
		"details": "A celula vai passando aleatoriamente atravessando tudo",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"javelin2": {
		"icon": WEAPON_PATH + "macrofago.png",
		"displayname": "Macrofago",
		"details": "A celula vai atravessar mais 1 inimigo",
		"level": "Level: 2",
		"prerequisite": ["javelin1"],
		"type": "weapon"
	},
	"javelin3": {
		"icon": WEAPON_PATH + "macrofago.png",
		"displayname": "Macrofago",
		"details": "A celula vai atravessar mais 1 inimigo",
		"level": "Level: 3",
		"prerequisite": ["javelin2"],
		"type": "weapon"
	},
	"javelin4": {
		"icon": WEAPON_PATH + "macrofago.png",
		"displayname": "Macrofago",
		"details": "A celula agora da +5 dano e causa 20% knockback a mais",
		"level": "Level: 4",
		"prerequisite": ["javelin3"],
		"type": "weapon"
	},
	"tornado1": {
		"icon": WEAPON_PATH + "coaglo.png",
		"displayname": "Coaglo",
		"details": "Um Coaglo em forma de tornado e criado vai em direção dos inimigos",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"tornado2": {
		"icon": WEAPON_PATH + "coaglo.png",
		"displayname": "Coaglo",
		"details": "Um coaglo adicional e criado",
		"level": "Level: 2",
		"prerequisite": ["tornado1"],
		"type": "weapon"
	},
	"tornado3": {
		"icon": WEAPON_PATH + "coaglo.png",
		"displayname": "Coaglo",
		"details": "O tempo de recarga e diminuido em 0.5 segundos",
		"level": "Level: 3",
		"prerequisite": ["tornado2"],
		"type": "weapon"
	},
	"tornado4": {
		"icon": WEAPON_PATH + "coaglo.png",
		"displayname": "Coaglo",
		"details": "Um coaglo adicional e criado e o knockback e diminuido em 25%",
		"level": "Level: 4",
		"prerequisite": ["tornado3"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ICON_PATH + "escudo1.png",
		"displayname": "Vitaminas",
		"details": "Reduz o dano causado em 2",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "escudo1.png",
		"displayname": "Vitaminas",
		"details": "Reduz o dano causado em 2",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "escudo1.png",
		"displayname": "Vitaminas",
		"details": "Reduz o dano causado em 2",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "escudo1.png",
		"displayname": "Vitaminas",
		"details": "Reduz o dano causado em 2",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "boots_4_green2.png",
		"displayname": "turbo imunológico",
		"details": "A velocidade de movimento e aumentada 30%",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "boots_4_green2.png",
		"displayname": "turbo imunológico",
		"details": "A velocidade de movimento e aumentada 30%",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "boots_4_green2.png",
		"displayname": "turbo imunológico",
		"details": "A velocidade de movimento e aumentada 30%",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "boots_4_green2.png",
		"displayname": "turbo imunológico",
		"details": "A velocidade de movimento e aumentada 30%",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"tome1": {
		"icon": ICON_PATH + "crescer.png",
		"displayname": "hipertrofiamento",
		"details": "Aumenta o tamnaho dos ataques em 10%",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"tome2": {
		"icon": ICON_PATH + "crescer.png",
		"displayname": "hipertrofiamento",
		"details": "Aumenta o tamnaho dos ataques em 10%",
		"level": "Level: 2",
		"prerequisite": ["tome1"],
		"type": "upgrade"
	},
	"tome3": {
		"icon": ICON_PATH + "crescer.png",
		"displayname": "hipertrofiamento",
		"details": "Aumenta o tamnaho dos ataques em 10%",
		"level": "Level: 3",
		"prerequisite": ["tome2"],
		"type": "upgrade"
	},
	"tome4": {
		"icon": ICON_PATH + "crescer.png",
		"displayname": "hipertrofiamento",
		"details": "Aumenta o tamnaho dos ataques em 10%",
		"level": "Level: 4",
		"prerequisite": ["tome3"],
		"type": "upgrade"
	},
	"scroll1": {
		"icon": ICON_PATH + "relogio.png",
		"displayname": "Regenaração",
		"details": "Dimunui o tempo de recarga em 5%",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"scroll2": {
		"icon": ICON_PATH + "relogio.png",
		"displayname": "Regenaração",
		"details": "Dimunui o tempo de recarga em 5%",
		"level": "Level: 2",
		"prerequisite": ["scroll1"],
		"type": "upgrade"
	},
	"scroll3": {
		"icon": ICON_PATH + "relogio.png",
		"displayname": "Regenaração",
		"details": "Dimunui o tempo de recarga em 5%",
		"level": "Level: 3",
		"prerequisite": ["scroll2"],
		"type": "upgrade"
	},
	"scroll4": {
		"icon": ICON_PATH + "relogio.png",
		"displayname": "Regenaração",
		"details": "Dimunui o tempo de recarga em 5% e mais 5% de tempo de base",
		"level": "Level: 4",
		"prerequisite": ["scroll3"],
		"type": "upgrade"
	},
	"ring1": {
		"icon": ICON_PATH + "expandir.png",
		"displayname": "Multiplicação",
		"details": "Spawnara +1 ataque nos seus ataques ativosk",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"ring2": {
		"icon": ICON_PATH + "expandir.png",
		"displayname": "Multiplicação",
		"details": "Spawnara +1 ataque nos seus ataques ativos",
		"level": "Level: 2",
		"prerequisite": ["ring1"],
		"type": "upgrade"
	},
	"food": {
		"icon": ICON_PATH + "chunk.png",
		"displayname": "Comida",
		"details": "Recupera 20 pontos da sua vida",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	},
		"neddle1": {
		"icon": WEAPON_PATH + "neddle.png",
		"displayname": "Agulha",
		"details": "Uma agulha que passa por todo mundo",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"neddle2": {
		"icon": WEAPON_PATH + "neddle.png",
		"displayname": "Agulha",
		"details": "Mais uma agulha e jogada",
		"level": "Level: 2",
		"prerequisite": ["neddle1"],
		"type": "weapon"
	},
	"neddle3": {
		"icon": WEAPON_PATH + "neddle.png",
		"displayname": "Agulha",
		"details": "a agulha agora da +2 de dano",
		"level": "Level: 3",
		"prerequisite": ["neddle2"],
		"type": "weapon"
	},
	"neddle4": {
		"icon": WEAPON_PATH + "neddle.png",
		"displayname": "Agulha",
		"details": "Mais 2 agulhas sao jogadas",
		"level": "Level: 4",
		"prerequisite": ["nedlle3"],
		"type": "weapon"
	},
}
